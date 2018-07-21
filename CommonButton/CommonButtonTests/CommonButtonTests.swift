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
        
        let button = CommonButton(type: .custom)
        
        var isButtonTouched = false
        button.touchUpInsideAction = {
            
            isButtonTouched = true
        }
        button.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(isButtonTouched)
    }

    func testCornerStyle() {
        
        let button = CommonButton(type: .custom)
        
        button.cornerStyle = .cliped
        XCTAssertEqual(button.cornerStyle, .cliped)
        
        button.cornerStyle = .custom
        XCTAssertEqual(button.cornerStyle, .custom)
    }
    
    func testBorderConfiguration() {
        
        let button = CommonButton(type: .custom)
        
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
        
        let button = CommonButton(type: .custom)
        
        // test default value
        XCTAssertEqual(button.touchRectMarginExtension, 0)
        
        // test boundarys
        button.touchRectMarginExtension = 1
        XCTAssertEqual(button.touchRectMarginExtension, 1)
        
        button.touchRectMarginExtension = -1
        XCTAssertEqual(button.touchRectMarginExtension, -1)
    }
    
    func testDimming() {
        
        let button = CommonButton(type: .custom)
    
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
    
    func testShadow() {
        
        let button = CommonButton(type: .custom)
        
        // default should be nil
        XCTAssertNil(button.shadowConfiguration)
        
        let expectedColors = [UIColor.red, .clear, .blue, nil]
        let expectedOpacities = [Float(0), 1.0, nil, -1.0]
        let expectedOffsets = [nil, CGSize.zero, CGSize(width: -1, height: -1), CGSize(width: 1, height: 1)]
        let expectedRadii = [CGFloat(0), -1, 1, nil]
        let expectedPaths = [
            nil,
            CGPath(rect: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)), transform: nil),
            CGPath(rect: CGRect(origin: .zero, size: CGSize(width: 30, height: 20)), transform: nil),
            CGPath(roundedRect: CGRect(origin: .zero, size: CGSize(width: 44, height: 33)), cornerWidth: 10, cornerHeight: 10, transform: nil)
        ]
        let testCount = 4
        
        for index in stride(from: 0, to: testCount, by: 1) {
            
            let shadowConfiguration = CommonButton.ShadowConfiguration(shadowColor: expectedColors[index], shadowOpacity: expectedOpacities[index], shadowOffset: expectedOffsets[index], shadowRadius: expectedRadii[index], shadowPath: expectedPaths[index])
            
            XCTAssertEqual(expectedColors[index], shadowConfiguration.shadowColor)
            XCTAssertEqual(expectedOpacities[index], shadowConfiguration.shadowOpacity)
            XCTAssertEqual(expectedOffsets[index], shadowConfiguration.shadowOffset)
            XCTAssertEqual(expectedRadii[index], shadowConfiguration.shadowRadius)
            XCTAssertEqual(expectedPaths[index], shadowConfiguration.shadowPath)
        }
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
            XCTAssertEqual(button.titleColor(for: .normal), expectedTextColors[index])
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
            XCTAssertEqual(button.titleColor(for: .normal), expectedTextColors[index])
        }
    }
    
    func testShadowDefaultSetter() {
        
        let button = CommonButton(type: .custom)
        
        // test default values according to docs
        //Color = lightGray, opacity = 1, offset = 0, radius = 10, path = nil
        button.setDefaultShadow()
        
        XCTAssertEqual(button.shadowConfiguration?.shadowColor, .lightGray)
        XCTAssertEqual(button.shadowConfiguration?.shadowOpacity, 1)
        XCTAssertEqual(button.shadowConfiguration?.shadowRadius, 10)
        XCTAssertEqual(button.shadowConfiguration?.shadowPath, nil)
    }
}
