//
//  ViewController.swift
//  ExampleProject
//
//  Created by ivan lares on 7/13/18.
//  Copyright © 2018 ivan lares. All rights reserved.
//

import UIKit
import CommonButton

class ExampleViewController: UIViewController {

    @IBOutlet weak var roundButton: CommonButton!
    @IBOutlet weak var clipedButton: CommonButton!
    
    var indicatorButton: CommonButton = {
        
        let button = CommonButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Indicator", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.regular)
        let borderConfiguration = CommonButton.BorderConfiguration(width: CommonButton.Constants.suggestedBorderWidth, color: .lightGray)
        button.borderConfiguration = borderConfiguration
        button.cornerStyle = .round
        
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // configure IB buttons
        roundButton.cornerStyle = .round
        clipedButton.cornerStyle = .cliped
        
        // add third button programatically
        addIndicatorButtonProgramatically()
    }
    
    /// adds and configures indicatorButton
    private func addIndicatorButtonProgramatically() {
        
        view.addSubview(indicatorButton)
        // constrin button 
        indicatorButton.heightAnchor.constraint(equalToConstant: indicatorButton.intrinsicContentSize.height).isActive = true
        indicatorButton.widthAnchor.constraint(equalToConstant: indicatorButton.intrinsicContentSize.width + CommonButton.Constants.widthPadding).isActive = true
        indicatorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorButton.topAnchor.constraint(equalTo: clipedButton.bottomAnchor, constant: (UIDevice.current.userInterfaceIdiom == .pad) ? 40 : 30).isActive = true
        
        /// setup activity indicator demo
        indicatorButton.touchUpInsideAction = {
            
            self.indicatorButton.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                self.indicatorButton.stopAnimating()
            })
        }
    }
}



