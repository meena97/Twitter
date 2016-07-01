//
//  TweetCompactCell.swift
//  Twitter1
//
//  Created by Meena Sengottuvelu on 6/26/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit

final class TweetCompactCell: TweetCell {
    
    // MARK: - Lifecycle Methods
    override func tweetSetConfigureSubviews() {
        super.tweetSetConfigureSubviews()
        
        retweetCountLabel.text = tweet.retweetCount > 0 ? String(tweet.retweetCount) : ""
        favoriteCountLabel.text = tweet.favoritesCount > 0 ? String(tweet.favoritesCount) : ""
        tweetAgeLabel.text = tweet.timestamp!.ago
    }
    
}
