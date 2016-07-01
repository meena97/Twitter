//
//  InfiniteScrollActivityView.swift
//  Twitter1
//
//  Created by Meena Sengottuvelu on 6/26/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit

final class InfiniteScrollActivityView: UIView {
    
    // MARK: - Constants
    static let defaultHeight: CGFloat = 60.0
    
    // MARK: Private Properties
    private var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Lifecycle Methods
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupActivityIndicator()
    }
    
    override init(frame aRect: CGRect) {
        super.init(frame: aRect)
        setupActivityIndicator()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
    }
    
    // MARK: Private Methods
    private func setupActivityIndicator() {
        activityIndicatorView.activityIndicatorViewStyle = .Gray
        activityIndicatorView.hidesWhenStopped = true
        addSubview(activityIndicatorView)
    }
    
    // MARK: Public Methods
    internal func stopAnimating() {
        activityIndicatorView.stopAnimating()
        hidden = true
    }
    
    internal func startAnimating() {
        hidden = false
        activityIndicatorView.startAnimating()
    }
    
}
