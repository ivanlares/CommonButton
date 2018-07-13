//
//  CornerStyle.swift
//  CommonButton
//
//  Created by ivan lares on 7/14/18.
//  Copyright © 2018 ivan lares. All rights reserved.
//

import Foundation

/**
    Model classes are put inside of CommonButton class in order to avoid namespacing bug
    https://bugs.swift.org/browse/SR-898
 */
extension CommonButton{
   
    public enum CornerStyle {
        
        /// Rectangular shape with clipped corners
        case cliped
        /// Fully rounded corners
        case round
        /// Use if you want to set the corner style yourself
        case custom
    }
}
