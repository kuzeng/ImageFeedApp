//
//  ImageCommentCellController.swift
//  EssentialFeediOS
//
//  Created by KDZ on 10/13/25.
//

import UIKit
import EssentialFeed

public class ImageCommentCellController: CellController {
    private var model: ImageCommentViewModel
    
    public init(model: ImageCommentViewModel) {
        self.model = model
    }
    
    public func view(in tableView: UITableView) -> UITableViewCell {
        let cell: ImageCommentCell = tableView.dequeueReusableCell()
        cell.messageLabel.text = model.message
        cell.usernameLabel.text = model.username
        cell.dateLabel.text = model.date
        return cell
    }
}
