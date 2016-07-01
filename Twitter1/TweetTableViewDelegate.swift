//
//  HomeViewDelegate.swift
//  Twitter1
//
//  Created by Meena Sengottuvelu on 6/26/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit

protocol TweetTableViewDelegate: class {
    
    func reloadTableCellAtIndexPath(cell: UITableViewCell, indexPath: NSIndexPath)
    
    func openProfile(userScreenname: NSString)
    
    func openCompose(viewController: UIViewController)
    
}
