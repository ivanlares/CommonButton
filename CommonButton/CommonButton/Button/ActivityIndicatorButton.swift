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
open class ActivityIndicatorButton: UIButton {
    
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
        
        isUserInteractionEnabled = false
        hideButtonViews(isHidden: true)
        _activityIndicator.startAnimating()
        _buttonState = .loading
    }
    
    /// stops animation and enables user interaction
    public func stopAnimating() {
        
        isUserInteractionEnabled = true
        hideButtonViews(isHidden: false)
        _activityIndicator.stopAnimating()
        _buttonState = .normal
    }
    
    public func setIndicator(style: UIActivityIndicatorViewStyle) {
        
        _activityIndicator.activityIndicatorViewStyle = style
    }
    
    public func getIndicatorStyle() -> UIActivityIndicatorViewStyle {
        
        return _activityIndicator.activityIndicatorViewStyle
    }
    
    public func setIndicator(color: UIColor) {
        
        _activityIndicator.color = color
    }
    
    public func getIndicatorColor() -> UIColor? {
        
        return _activityIndicator.color
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
        /// button is shown in it's normal state
        case normal
        /// activity indicator is shown
        case loading
    }
    
}
