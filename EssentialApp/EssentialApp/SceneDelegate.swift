//
//  SceneDelegate.swift
//  EssentialApp
//
//  Created by KDZ on 8/12/25.
//

import UIKit
import CoreData
import EssentialFeed

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private lazy var feedService = FeedService()
    
    private lazy var navigationController = UINavigationController(
        rootViewController: FeedUIComposer.feedComposedWith(
            feedLoader: feedService.loadRemoteFeedWithLocalFallback,
            imageLoader: feedService.loadLocalImageWithRemoteFallback,
            selection: showComments))
    
    convenience init(httpClient: HTTPClient, store: FeedStore & FeedImageDataStore & Scheduler & Sendable) {
        self.init()
        self.feedService = FeedService(httpClient: httpClient, store: store)
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        configureWindow()
    }
    
    func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        feedService.validateCache()
    }
    
    private func showComments(for image: FeedImage) {
        let comments = CommentsUIComposer.commentsComposedWith(commentsLoader: feedService.loadComments(for: image))
        navigationController.pushViewController(comments, animated: true)
    }
    
    private func loadComments(url: URL) -> () async throws -> [ImageComment] {
        return { [httpClient] in
            let (data, response) = try await httpClient.get(from: url)
            return try ImageCommentsMapper.map(data, from: response)
        }
    }
    
    private func loadRemoteFeedWithLocalFallback() async throws -> Paginated<FeedImage>{
        do {
            let feed = try await loadAndCacheRemoteFeed()
            return makeFirstPage(items: feed)
        } catch {
            let feed = try await loadLocalFeed()
            return makeFirstPage(items: feed)
        }
    }
    
    private func loadAndCacheRemoteFeed() async throws -> [FeedImage] {
        let feed = try await loadRemoteFeed()
        await store.schedule { [store] in
            let localFeedLoader = LocalFeedLoader(store: store, currentDate: Date.init)
            try? localFeedLoader.save(feed)
        }
        return feed
    }
    
    private func loadLocalFeed() async throws -> [FeedImage] {
        try await store.schedule { [store] in
            let localFeedLoader = LocalFeedLoader(store: store, currentDate: Date.init)
            return try localFeedLoader.load()
        }
    }
    
    private func loadRemoteFeed(after: FeedImage? = nil) async throws -> [FeedImage] {
        let url = FeedEndpoint.get(after: after).url(baseURL: baseURL)
        let (data, response) = try await httpClient.get(from: url)
        return try FeedItemsMapper.map(data, from: response)
    }
    
    private func loadMoreRemoteFeed(last: FeedImage?) async throws -> Paginated<FeedImage> {
        async let cachedItems = try await loadLocalFeed()
        async let newItems = try await loadRemoteFeed(after: last)
        
        let items = try await cachedItems + newItems
        
        await store.schedule { [store] in
            let localFeedLoader = LocalFeedLoader(store: store, currentDate: Date.init)
            try? localFeedLoader.save(items)
        }
        
        return try await makePage(items: items, last: newItems.last)
    }
    
    private func makeFirstPage(items: [FeedImage]) -> Paginated<FeedImage> {
        makePage(items: items, last: items.last)
    }
    
    private func makePage(items: [FeedImage], last: FeedImage?) -> Paginated<FeedImage> {
        Paginated(items: items, loadMore: last.map { last in
            { @MainActor @Sendable in try await self.loadMoreRemoteFeed(last: last) }
        })
    }
    
    private func loadLocalImageWithRemoteFallback(url: URL) async throws -> Data {
        do {
            return try await loadLocalImage(url: url)
        } catch {
            return try await loadAndCacheRemoteImage(url: url)
        }
    }
    
    private func loadLocalImage(url: URL) async throws -> Data {
        try await store.schedule { [store] in
            let localImageLoader = LocalFeedImageDataLoader(store: store)
            let imageData = try localImageLoader.loadImageData(from: url)
            return imageData
        }
    }

    private func loadAndCacheRemoteImage(url: URL) async throws -> Data {
        let (data, response) = try await httpClient.get(from: url)
        let imageData = try FeedImageDataMapper.map(data, from: response)
        await store.schedule { [store] in
            let localImageLoader = LocalFeedImageDataLoader(store: store)
            try? localImageLoader.save(data, for: url)
        }
        return imageData
    }
}

protocol StoreScheduler {
    @MainActor
    func schedule<T>(_ action: @escaping @Sendable () throws -> T) async rethrows -> T
}

extension CoreDataFeedStore: StoreScheduler {
    @MainActor
    func schedule<T>(_ action: @escaping @Sendable () throws -> T) async rethrows -> T {
        if contextQueue == .main {
            return try action()
        } else {
            return try await perform(action)
        }
    }
}

extension InMemoryFeedStore: StoreScheduler {
    @MainActor
    func schedule<T>(_ action: @escaping @Sendable () throws -> T) async rethrows -> T {
        try action()
    }
}
