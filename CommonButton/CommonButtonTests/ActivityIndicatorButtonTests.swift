//
//  ActivityIndicatorButtonTests.swift
//  CommonButtonTests
//
//  Created by ivan lares on 7/16/18.
//  Copyright © 2018 ivan lares. All rights reserved.
//

import XCTest
@testable import CommonButton

class ActivityIndicatorButtonTests: XCTestCase {
    
    // test buttonState property
    func testIndicatorState() {
        
        let button = ActivityIndicatorButton()
        
        button.startAnimating()
        XCTAssertEqual(button.buttonState
            , .loading)
        
        button.stopAnimating()
        XCTAssertEqual(button.buttonState
            , .normal)
    }
    
    // Should disable user interaction when animating
    func testButtonInteraction() {
        
        let button = ActivityIndicatorButton()
        
        button.startAnimating()
        XCTAssertFalse(button.isUserInteractionEnabled)
        
        button.stopAnimating()
        XCTAssertTrue(button.isUserInteractionEnabled)
    }
    
    func testIndicatorStyleSetter() {
        
        let button = ActivityIndicatorButton()
        
        button.setIndicator(style: .gray)
        
        XCTAssertEqual(UIActivityIndicatorViewStyle.gray, button.getIndicatorStyle())
        
        button.setIndicator(style: .whiteLarge)
        XCTAssertEqual(UIActivityIndicatorViewStyle.whiteLarge, button.getIndicatorStyle())
    }
    
    func testIndicatorColorSetter() {
        
        let button = ActivityIndicatorButton()
        
        button.setIndicator(color: .red)
        XCTAssertEqual(.red, button.getIndicatorColor())
        
        button.setIndicator(color: .blue)
        XCTAssertEqual(.blue, button.getIndicatorColor())
    }
}
