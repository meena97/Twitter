//
//  ProfileDescriptionRightPageViewController.swift
//  Twitter1
//
//  Created by Meena Sengottuvelu on 6/26/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit

final class ProfileDescriptionRightPageViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var taglineLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserverForName(AppInfo.notifications.ProfileConfigureRightSubviews, object: nil, queue: NSOperationQueue.mainQueue()) { _ in
            self.grabLoadedUser()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        grabLoadedUser()
    }
    
    // MARK: - Private Methods
    private func grabLoadedUser() {
        if User.bufferUser != nil {
            taglineLabel.text = User.bufferUser?.tagline as? String
        }
    }
    
}
