//
//  ProfileViewController.swift
//  Twitter1
//
//  Created by Meena Sengottuvelu on 6/26/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit

final class ProfileViewController: TweetTableViewController {
    
    // MARK: - Properties
    
    // MARK: Public Properties
    var user: User!
    var userScreenname: NSString?
    
    // MARK: Private Properties
    private var pagedView: ProfileDescriptionPageViewController?
    
    // MARK: - IBOutlets
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileImageSuperview: UIView!
    
    @IBOutlet var shadowEffectView: UIView!
    @IBOutlet var tableViewOutlet: UITableView! {
        didSet {
            tableView = tableViewOutlet
        }
    }
    
    @IBOutlet var closeModalButton: UIButton!
    
    @IBOutlet var profileDescriptionContainer: UIView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserverForName(AppInfo.notifications.ProfileConfigureView, object: nil, queue: NSOperationQueue.mainQueue()) { _ in
            self.user = User.bufferUser
            self.populateSubviews()
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = shadowEffectView.bounds
        let topColor = UIColor(white: 0, alpha: 0.3).CGColor as CGColorRef
        let bottomColor = UIColor(white: 0, alpha: 0.0).CGColor as CGColorRef
        gradientLayer.colors = [topColor, bottomColor]
        gradientLayer.locations = [0.0, 1.0]
        shadowEffectView.layer.addSublayer(gradientLayer)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        configureViewController()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        lastTweetId = nil
        User.bufferUser = nil
        
        if userScreenname == nil {
            user = User.currentUser!
            populateSubviews()
        } else {
            
            TwitterClient.sharedInstance.getUserByScreenname(userScreenname!, success: { user in
                User.bufferUser = user
                NSNotificationCenter.defaultCenter().postNotificationName(AppInfo.notifications.ProfileConfigureView, object: nil)
            })
        }
    }
    
    private func populateSubviews() {
        User.bufferUser = user 
        NSNotificationCenter.defaultCenter().postNotificationName(AppInfo.notifications.ProfileConfigureSubviews, object: nil)
        
        reloadData()
        
        let profileImageUrl = user.profileUrl
        let backgroundImageUrl = user.backgroundImageURL
        
        profileImageView.setImageWithURL(profileImageUrl!)
        if let backgroundImageUrl = backgroundImageUrl {
            backgroundImageView.setImageWithURL(NSURL(string: backgroundImageUrl)!)
            backgroundImageView.contentMode = user.hasBannerImage ? .Redraw : .ScaleAspectFill
        }
        profileImageView.clipsToBounds = true
        [profileImageView, profileImageSuperview].forEach { $0.layer.cornerRadius = 5 }
        
        if user.screenname != User.currentUser?.screenname {
            let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(closeProfileModal))
            closeModalButton.userInteractionEnabled = true
            closeModalButton.addGestureRecognizer(tapGestureRecognizer2)
            closeModalButton.hidden = false
        } else {
            closeModalButton.hidden = true
        }
    }
    
    // MARK: - Internal Methods
    func closeProfileModal() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func reloadData(append: Bool = false) {
        guard user != nil else {
            return
        }
        
        TwitterClient.sharedInstance.user_timeline(user, maxId: lastTweetId, success: reloadCompletion(append), failure: { error in
            print(error.localizedDescription)
        })
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        guard segue.identifier == "toDetails" else {
            return
        }
        
        (segue.destinationViewController as! DetailsViewController).closeNavBarOnDisappear = true
    }
    
}
