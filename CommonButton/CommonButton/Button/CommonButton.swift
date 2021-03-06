//
//  CommonButton.swift
//  CommonButton
//
//  Created by ivan lares on 7/13/18.
//  Copyright © 2018 ivan lares. All rights reserved.
//

import Foundation

/**
 This class inherits from ActivityIndicatorButton and adds additional functionality.
 */
@IBDesignable
open class CommonButton: ActivityIndicatorButton {
    
    // MARK: Closure Actions
    
    /// Button action to be performed when button is touched up inside
    public var touchUpInsideAction: (() -> ())?
    
    // MARK: Corner Style
    
    /// Set if you want class to automatically style corners
    ///
    /// default is .custom which does nothing
    public var cornerStyle: CornerStyle = .custom{
        
        didSet {
            
            set(cornerStyle: cornerStyle)
        }
    }
    
    // MARK: Border Configuration
    
    /// Set this value if you want to configure the border
    public var borderConfiguration: BorderConfiguration? = nil {
        
        didSet {
            setBorder(with: borderConfiguration)
        }
    }
    
    // MARK: Shadow Configuration
    
    /**
     Sets shadow if not nil.
     
     The default shadowColor is an opaque black color
     
     The default shadowOpacity is 0.0
     
     The default shadowOffset is (0.0, -3.0)
     
     The default shadowRadius is 3.0
     
     The default shadowPath is nil
    */
    public var shadowConfiguration: ShadowConfiguration? = nil {
        
        didSet {
            setShadow(with: shadowConfiguration)
        }
    }
    
    // MARK: Touch Rect margin extension
    
    /// Margin used to extend the touch rect.
    /// default is 0
    @IBInspectable
    public var touchRectMarginExtension: CGFloat = 0
    
    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        let area = self.bounds.insetBy(dx: -touchRectMarginExtension, dy: -touchRectMarginExtension)
        
        return area.contains(point)
    }
    
    // MARK: Dimming Button
    
    /// Button will be dimmed when it's highlighted or disabled
    ///
    /// The default is true
    @IBInspectable
    var shouldDim: Bool = true
    
    override open var isHighlighted: Bool {
        
        didSet{
            if shouldDim {
                alpha = isHighlighted ? 0.3 : 1.0
            }
        }
    }
    
    override open var isEnabled: Bool {
        
        didSet{
            if shouldDim {
                alpha = isEnabled ? 1.0 : 0.3
            }
        }
    }
    
    // MARK: Initializers
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        
        addTargetActions()
    }
    
    // MARK: Static Factory Methods
    
    /// Returns a bordered style button
    //
    /// Corner style is round by default
    /// Border width is set to suggested value by default
    /// Text color sets the text color for the button in the normal UIControl state
    public static func borderedButton(borderColor: UIColor, borderWidth: CGFloat = Constants.suggestedBorderWidth, cornerStyle: CornerStyle = .round, backgroundColor: UIColor, textColor: UIColor) -> CommonButton{
        
        let button = CommonButton(type: .custom)
        let borderConfiguration = BorderConfiguration(width: borderWidth, color: borderColor)
        button.borderConfiguration = borderConfiguration
        button.cornerStyle = cornerStyle
        button.backgroundColor = backgroundColor
        button.setTitleColor(textColor, for: .normal)
        
        return button
    }
    
    /// Returns an instance of CommonButton, with the provided corner style.
    ///
    /// Text color sets the text color for the button in the normal UIControl state
    public static func button(withCornerStyle cornerStyle: CornerStyle, backgroundColor: UIColor? = nil, textColor: UIColor? = nil) -> CommonButton {
        
        let button = CommonButton(type: .custom)
        button.cornerStyle = cornerStyle
        button.backgroundColor = backgroundColor
        if let textColor = textColor {
            
            button.setTitleColor(textColor, for: .normal)
        }
        
        return button
    }
    
    // MARK: Configuration methods

    /// Sets shadowConfiguration to a recommended value
    ///
    /// Color = lightGray, opacity = 1, offset = 0, radius = 10, path = nil
    public func setDefaultShadow() {
        
        let shadowConfiguration = CommonButton.ShadowConfiguration(shadowColor: .lightGray, shadowOpacity: 1, shadowOffset: .zero, shadowRadius: 10, shadowPath: nil)
        self.shadowConfiguration = shadowConfiguration
    }
}

// MARK: - Layout

extension CommonButton {
    
    override open func layoutSubviews() {
        
        super.layoutSubviews()
        
        set(cornerStyle: cornerStyle)
        setBorder(with: borderConfiguration)
    }
    
    /// sets corner style
    private func set(cornerStyle: CornerStyle) {
        
        switch cornerStyle {
        case .cliped:
            layer.cornerRadius = Constants.Corner.clipRadius
        case .round: layer.cornerRadius = frame.height/2
        case .custom: break
        }
    }
    
    /**
     The default borderWidth is 0.0
     
     The default borderColor is an opaque black color
     */
    private func setBorder(with borderConfiguration: BorderConfiguration?) {
        
            layer.borderColor = borderConfiguration?.color?.cgColor
            layer.borderWidth = borderConfiguration?.width ?? 0.0
    }
    
    /**
     The default shadowColor is an opaque black color
     
     The default shadowOpacity is 0.0
     
     The default shadowOffset is (0.0, -3.0)
     
     The default shadowRadius is 3.0
     
     The default shadowPath is nil
     */
    private func setShadow(with shadowConfiguration: ShadowConfiguration?) {
        
        layer.shadowColor = shadowConfiguration?.shadowColor?.cgColor
        layer.shadowOpacity = shadowConfiguration?.shadowOpacity ?? 0.0
        layer.shadowOffset = shadowConfiguration?.shadowOffset ?? CGSize(width: 0.0, height: -3.0)
        layer.shadowRadius = shadowConfiguration?.shadowRadius ?? 3.0
        layer.shadowPath = shadowConfiguration?.shadowPath
    }
}

// MARK: - Target Action

extension CommonButton {
    
    private func addTargetActions() {
        
        addTarget(self, action: #selector(touchUpInside), for: UIControlEvents.touchUpInside)
    }
    
    @objc private func touchUpInside(){
        
        touchUpInsideAction?()
    }
}

// MARK: - Constants

extension CommonButton {
    
    public struct Constants {
        
        internal struct Corner {
            
            /// radius used when cliping corners
            static let clipRadius: CGFloat = (UIDevice.current.userInterfaceIdiom == .pad) ? 18 : 8
            
            private init() {}
        }
        
        /// value to use when setting width constraint programatically.
        /// This value can be added with intrinsicSize.width
        public static let widthPadding: CGFloat = (UIDevice.current.userInterfaceIdiom == .pad) ? 48 : 38
        
        /// Suggested value for border width
        public static let suggestedBorderWidth: CGFloat = 1.25
        
        private init() {}
    }
}
