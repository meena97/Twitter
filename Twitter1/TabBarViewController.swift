//
//  TabBarViewController.swift
//  Twitter1
//
//  Created by Meena Sengottuvelu on 6/26/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserverForName(AppInfo.notifications.UserDidLogout, object: nil, queue: NSOperationQueue.mainQueue()) { _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        AppInfo.tabBarController = self
    }
    
}
