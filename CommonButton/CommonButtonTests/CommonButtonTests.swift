//
//  CommonButtonTests.swift
//  CommonButtonTests
//
//  Created by ivan lares on 7/13/18.
//  Copyright © 2018 ivan lares. All rights reserved.
//

import XCTest
@testable import CommonButton

class CommonButtonTests: XCTestCase {
    
    // tests button's touch up inside closure
    // it should be called when button is touched up inside
    func testTouchUpInsideAction() {
        
        let button = CommonButton()
        
        var isButtonTouched = false
        button.touchUpInsideAction = {
            
            isButtonTouched = true
        }
        button.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(isButtonTouched)
    }

    func testCornerStyle() {
        
        let button = CommonButton()
        
        button.cornerStyle = .cliped
        XCTAssertEqual(button.cornerStyle, .cliped)
        
        button.cornerStyle = .custom
        XCTAssertEqual(button.cornerStyle, .custom)
    }
    
    func testBorderConfiguration() {
        
        let button = CommonButton()
        
        let expectedWidths: [CGFloat] = [1, 0, 2.3]
        let expectedColors: [UIColor?] = [.red, .blue, nil]
        let testCount = 3
        
        /// test all cases
        for index in stride(from: 0, to: testCount, by: 1) {
            
            button.borderConfiguration = CommonButton.BorderConfiguration(width: expectedWidths[index], color: expectedColors[index])
            XCTAssertEqual(expectedWidths[index], button.borderConfiguration?.width)
            XCTAssertEqual(expectedColors[index], button.borderConfiguration?.color)
        }
    }
    
    func testTouchRectMarginExtension() {
        
        let button = CommonButton()
        
        // test default value
        XCTAssertEqual(button.touchRectMarginExtension, 0)
        
        // test boundarys
        button.touchRectMarginExtension = 1
        XCTAssertEqual(button.touchRectMarginExtension, 1)
        
        button.touchRectMarginExtension = -1
        XCTAssertEqual(button.touchRectMarginExtension, -1)
    }
    
    func testDimming() {
        
        let button = CommonButton()
    
        // test default value
        // shouldDim should be true by default
        XCTAssertEqual(button.shouldDim, true)
    
        // button alpha should change
        button.isHighlighted = true
         XCTAssert(button.alpha != 1)
        button.isHighlighted = false
        XCTAssert(button.alpha == 1)
       
        button.isEnabled = false
        XCTAssert(button.alpha != 1)
        button.isEnabled = true
        XCTAssert(button.alpha == 1)
        
        // Button alpha should not change
        button.shouldDim = false
        
        button.isHighlighted = true
        XCTAssert(button.alpha == 1)
        button.isHighlighted = false
        XCTAssert(button.alpha == 1)
        
        button.isEnabled = false
        XCTAssert(button.alpha == 1)
        button.isEnabled = true
        XCTAssert(button.alpha == 1)
    }
    
    func testStaticBorderStyledFactoryMethod() {
        
        let expectedBorderColors: [UIColor] = [.clear, .blue, .lightGray]
        let expectedBackgroundColors: [UIColor] = [.black, .clear, .lightGray]
        let expectedTextColors: [UIColor] = [.green, .clear, .lightGray]
        let testCount = 3
        
        // test values set in factory method
        for index in stride(from: 0, to: testCount, by: 1) {
            
            let button = CommonButton.borderedButton(borderColor: expectedBorderColors[index], backgroundColor: expectedBackgroundColors[index], textColor: expectedTextColors[index])
            
            XCTAssertEqual(button.borderConfiguration?.color, expectedBorderColors[index])
            XCTAssertEqual(button.backgroundColor, expectedBackgroundColors[index])
            XCTAssertEqual(button.titleLabel?.textColor, expectedTextColors[index])
        }
    }
    
    func testStaticCornerStyledFactoryMethod() {
        
        let expectedCornerStyles: [CommonButton.CornerStyle] = [.round, .custom, .cliped]
        let expectedBackgroundColors: [UIColor] = [.black, .clear, .lightGray]
        let expectedTextColors: [UIColor] = [.green, .clear, .lightGray]
        let testCount = 3
        
        for index in stride(from: 0, to: testCount, by: 1) {
            
            let button = CommonButton.button(withCornerStyle: expectedCornerStyles[index], backgroundColor: expectedBackgroundColors[index], textColor: expectedTextColors[index])
            
            XCTAssertEqual(button.cornerStyle, expectedCornerStyles[index])
            XCTAssertEqual(button.backgroundColor, expectedBackgroundColors[index])
            XCTAssertEqual(button.titleLabel?.textColor, expectedTextColors[index])
        }
    }
}
