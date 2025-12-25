//
//  EssentialFeedAPI_EndToEndTests.swift
//  EssentialFeedAPI EndToEndTests
//
//  Created by Kuiduan Zeng on 5/20/25.
//

import XCTest
import EssentialFeed

final class EssentialFeedAPI_EndToEndTests: XCTestCase {

    func test_endToEndTestServerGETFeedResult_matchesFixedTestAccountData() {

        switch getFeedResult()! {
        case let .success(imageFeed):
            XCTAssertEqual(imageFeed.count, 10, "Expected 10 images in the test account feed (with limit=10)")
            
            XCTAssertEqual(imageFeed[0], expectedImage(at: 0), "Unexpected image values at index \(0)")
            XCTAssertEqual(imageFeed[1], expectedImage(at: 1), "Unexpected image values at index \(1)")
            XCTAssertEqual(imageFeed[2], expectedImage(at: 2), "Unexpected image values at index \(2)")
            XCTAssertEqual(imageFeed[3], expectedImage(at: 3), "Unexpected image values at index \(3)")
            XCTAssertEqual(imageFeed[4], expectedImage(at: 4), "Unexpected image values at index \(4)")
            XCTAssertEqual(imageFeed[5], expectedImage(at: 5), "Unexpected image values at index \(5)")
            XCTAssertEqual(imageFeed[6], expectedImage(at: 6), "Unexpected image values at index \(6)")
            XCTAssertEqual(imageFeed[7], expectedImage(at: 7), "Unexpected image values at index \(7)")
            XCTAssertEqual(imageFeed[8], expectedImage(at: 8), "Unexpected image values at index \(8)")
            XCTAssertEqual(imageFeed[9], expectedImage(at: 9), "Unexpected image values at index \(9)")
            
        case let .failure(error):
            XCTFail("Expected successful feed result, got error: \(error) instead")
        }
    }
    
    func test_endToEndTestServerGETFeedImageDataResult_matchesFixedTestAccountData() {
        switch getFeedImageDataResult() {
        case let .success(data)?:
            XCTAssertFalse(data.isEmpty, "Expected non-empty image data")

        case let .failure(error)?:
            XCTFail("Expected successful image data result, got \(error) instead")

        default:
            XCTFail("Expected successful image data result, got no result instead")
        }
    }
    
    // MARK: - Helpers
    
    private func getFeedResult(file: StaticString = #filePath, line: UInt = #line) -> Swift.Result<[FeedImage], Error>? {
        let client = ephemeralClient()
        let exp = expectation(description: "Wait for load completion")
        
        var receivedResult: Swift.Result<[FeedImage], Error>?
        client.get(from: feedTestServerURL) { result in
            receivedResult = result.flatMap { (data, response) in
                do {
                    return .success(try FeedItemsMapper.map(data, from: response))
                } catch {
                    return .failure(error)
                }
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        
        return receivedResult
    }
    
    private func getFeedImageDataResult(file: StaticString = #file, line: UInt = #line) -> Result<Data, Error>? {
        let loader = RemoteFeedImageDataLoader(client: ephemeralClient())
        trackForMemoryLeaks(loader, file: file, line: line)

        let url = URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1/image/11E123D5-1272-4F17-9B91-F3D0FFEC895A/blob")!
        
        let receivedResult = Result { try loader.loadImageData(from: url) }

        return receivedResult
    }
    
    private var feedTestServerURL: URL {
        return FeedEndpoint.get().url(baseURL: URL(string: "https://ile-api.essentialdeveloper.com/essential-feed")!)
    }
    
    private func ephemeralClient(file: StaticString = #file, line: UInt = #line) -> HTTPClient {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        trackForMemoryLeaks(client, file: file, line: line)
        return client
    }
    
    private func expectedImage(at index: Int) -> FeedImage {
        return FeedImage(
            id: id(at: index),
            description: description(at: index),
            location: location(at: index),
            url: imageURL(at: index))
    }
    
    private func id(at index: Int) -> UUID {
        return UUID(uuidString: [
            "11E123D5-1272-4F17-9B91-F3D0FFEC895A",
            "31768993-1A2E-4B65-BD2A-D8AF06416730",
            "54F35D06-9CC6-4294-A0D8-963D397E8B98",
            "93F3F9B1-D3B0-46B6-9546-2808A65FCC20",
            "CF68C4D7-D7B9-44BE-8D10-BDD8464915C2",
            "8FD1F6C1-F8DE-4C76-B57C-4AE28F14D270",
            "5ACC3B53-F55F-4C89-8DD4-4013420D6D15",
            "145B5EEA-EBBE-4271-845B-BA7BA6805A65",
            "1C61138B-B183-438C-B6A5-2AEEA0B78756",
            "B6A7CEA2-1D32-41D7-8688-B85B00922FC0"
        ][index])!
    }
    
    private func description(at index: Int) -> String? {
        return [
            "The East Side Gallery is an open-air gallery in Berlin. It consists of a series of murals painted directly on a 1,316 m long remnant of the Berlin Wall, located near the centre of Berlin, on Mühlenstraße in Friedrichshain-Kreuzberg. The gallery has official status as a Denkmal, or heritage-protected landmark.",
            "Garth Pier is a Grade II listed structure in Bangor, Gwynedd, North Wales. At 1,500 feet in length, it is the second-longest pier in Wales, and the ninth longest in the British Isles.",
            "☀️🍁 Good day, team! Beatiful morning for a brief 5K! The Grade I listed Brompton Cemetery is the well-loved resting place of over 200,000 people, a haven for wildlife and a popular destination for locals and tourists alike.",
            "Summer sunset",
            "Several bridges named London Bridge have spanned the River Thames between the City of London and Southwark, in central London.",
            "Glorious day!! 🎢",
            nil,
            "Autumn on the track. 🏃‍♂️💨\nGetting ready for a good solid session, focusing on maintaining a constant speed for the duration. Looking for the acceleration during the last two rounds.",
            nil,
            nil
        ][index]
    }
    
    private func location(at index: Int) -> String? {
        return [
            "East Side Gallery\nMemorial in Berlin, Germany",
            "Bangor Pier",
            "Brompton Cemetery, London",
            nil,
            "London Bridge",
            "Brighton Seafront",
            "The Burren Rocks",
            nil,
            "Cardiff Bay",
            "St Fagans National Museum of History"
        ][index]
    }
    
    private func imageURL(at index: Int) -> URL {
        return URL(string: "https://ile-api.essentialdeveloper.com/essential-feed/v1/image/\(id(at: index).uuidString)/blob")!
    }
}
