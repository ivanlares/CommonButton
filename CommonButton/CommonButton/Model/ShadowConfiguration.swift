//
//  ShadowConfiguration.swift
//  CommonButton
//
//  Created by ivan lares on 7/20/18.
//  Copyright © 2018 ivan lares. All rights reserved.
//

import UIKit

/**
 Model classes are put inside of CommonButton class in order to avoid namespacing bug
 https://bugs.swift.org/browse/SR-898
 */
extension CommonButton{

    public struct ShadowConfiguration {
        
        public var shadowColor: UIColor?
        public var shadowOpacity: Float?
        public var shadowOffset: CGSize?
        public var shadowRadius: CGFloat?
        public var shadowPath: CGPath?
        
        public init(shadowColor: UIColor?, shadowOpacity: Float?, shadowOffset: CGSize?, shadowRadius: CGFloat?, shadowPath: CGPath?) {
            
            self.shadowColor = shadowColor
            self.shadowOpacity = shadowOpacity
            self.shadowOffset = shadowOffset
            self.shadowRadius = shadowRadius
            self.shadowPath = shadowPath
        }
    }
}
