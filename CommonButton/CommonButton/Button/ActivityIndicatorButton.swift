//
//  ActivityIndicatorButton.swift
//  Spelling B
//
//  Created by ivan lares on 6/8/18.
//  Copyright © 2018 ivan lares. All rights reserved.
//

import UIKit

/**
 This is a normal UIButton with an added UIActivityIndicatorView and it's related methods.
 */ 
public class ActivityIndicatorButton: UIButton {
    
    private var _buttonState: ButtonState = .normal
    
    /// State of button
    ///
    /// .normal by default
    public var buttonState: ButtonState {
        return _buttonState
    }
    
    /// default indicator style is .gray
    private var _activityIndicator: UIActivityIndicatorView = {
        
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.activityIndicatorViewStyle = .gray
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        indicator.isUserInteractionEnabled = false
        
        return indicator
    }()
    
    var activityIndicator: UIActivityIndicatorView {
        
        return _activityIndicator
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        addSubviews()
        addConstraints()
    }
}

// MARK: - Indicator Methods

extension ActivityIndicatorButton {
    
    /// starts animation and disables user interaction
    public func startAnimating() {
        
        hideButtonViews(isHidden: true)
        isEnabled = false
        _activityIndicator.startAnimating()
    }
    
    /// stops animation and enables user interaction
    public func stopAnimating() {
        
        hideButtonViews(isHidden: false)
        isEnabled = true
        _activityIndicator.stopAnimating()
    }
    
    /// hides text and image for button
    private func hideButtonViews(isHidden: Bool) {
        
        titleLabel?.alpha = isHidden ? 0 : 1
        imageView?.alpha = isHidden ? 0 : 1
    }
}

// MARK: - Auto Layout

extension ActivityIndicatorButton {
    
    private func addSubviews() {
        
        addSubview(_activityIndicator)
    }
    
    private func addConstraints() {
        
        _activityIndicator.heightAnchor.constraint(
            equalToConstant: _activityIndicator.intrinsicContentSize.height).isActive = true
        _activityIndicator.widthAnchor.constraint(
            lessThanOrEqualToConstant: _activityIndicator.intrinsicContentSize.width).isActive = true
        _activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        _activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}

// MARK: - Internal Data types

extension ActivityIndicatorButton {
    
    public enum ButtonState {
        /// regular
        case normal
        /// activity indicator is shown
        case loading
    }
    
}
