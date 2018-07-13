//
//  BorderConfiguration.swift
//  CommonButton
//
//  Created by ivan lares on 7/13/18.
//  Copyright © 2018 ivan lares. All rights reserved.
//

import UIKit

/**
    Model classes are put inside of CommonButton class in order to avoid namespacing bug
    https://bugs.swift.org/browse/SR-898
*/
extension CommonButton{
    
    public struct BorderConfiguration {
        
        var width: CGFloat
        var color: UIColor?
        
        public init(width: CGFloat, color: UIColor?) {
            
            self.width = width
            self.color = color
        }
    }
}
