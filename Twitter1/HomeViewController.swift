//
//  HomeViewController.swift
//  Twitter1
//
//  Created by Meena Sengottuvelu on 6/26/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit

final class HomeViewController: TweetTableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var tableViewOutlet: UITableView! {
        didSet {
            tableView = tableViewOutlet
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        UIApplication.sharedApplication().statusBarStyle = .Default
        
        let logo = UIImage(named: "Icon-Twitter")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = logo
        self.navigationItem.titleView = imageView
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureViewController()
    }
    
    // MARK: - Internal Methods
    override func reloadData(append: Bool = false) {
        TwitterClient.sharedInstance.homeTimeline(lastTweetId, success: reloadCompletion(append), failure: { error in
            print(error.localizedDescription)
        })
    }
    
    // MARK: - Navigation
    // prepareForSegue is defined in parent class (TweetTableViewController)
    
}
