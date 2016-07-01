//
//  SplashViewController.swift
//  Twitter1
//
//  Created by Meena Sengottuvelu on 6/26/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: Private Properties
    private var attemptingLogin = false
    
    // MARK: - IBOutlets
    @IBOutlet var LogoHeightOriginalConstraint: NSLayoutConstraint!
    @IBOutlet var LogoHeightLargeConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        guard !attemptingLogin else {
            return
        }
        
        proceed()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        LogoHeightLargeConstraint.active = false
        LogoHeightOriginalConstraint.active = true
    }
    
    // MARK: - Private Methods
    private func goToLogin() {
        self.performSegueWithIdentifier("toLogin", sender: self)
    }
    
    private func goToApp() {
        LogoHeightOriginalConstraint.active = false
        LogoHeightLargeConstraint.active = true
        UIView.animateWithDuration(0.5) {
            self.view.layoutIfNeeded()
        }
        
        self.performSegueWithIdentifier("toTabbedView", sender: self)
    }
    
    private func proceed() {
        delay(0.5, closure: User.currentUser == nil ? goToLogin : goToApp)
    }
    
}

// MARK: - TwitterLoginLoungeDelegate
extension SplashViewController: TwitterLoginLoungeDelegate {
    
    func continueLogin() {
        attemptingLogin = false
        proceed()
    }
    
    func doNotContinueLogin() {
        attemptingLogin = true
    }
    
}
