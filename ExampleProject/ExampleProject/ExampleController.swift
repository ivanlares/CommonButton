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
    @IBOutlet weak var shadowButton: CommonButton!
    
    var indicatorButton: CommonButton = {
        
        let button = CommonButton.borderedButton(borderColor: .lightGray, backgroundColor: .white, textColor: .lightGray)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Bordered", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.regular)
        button.cornerStyle = .round

        return button
    }()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return .portrait
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureIBButtons()
        addIndicatorButtonProgramatically()
    }
    
    /// configures interface builder buttons
    private func configureIBButtons() {
        
        roundButton.cornerStyle = .round
        clipedButton.cornerStyle = .cliped
        clipedButton.setIndicator(style: .white)
        clipedButton.touchUpInsideAction = {
            self.clipedButton.startAnimating()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.indicatorAnimationTime, execute: {
                self.clipedButton.stopAnimating()
            })
        }
        shadowButton.cornerStyle = .cliped
        shadowButton.setDefaultShadow()
    }
    
    /// adds and configures indicatorButton
    private func addIndicatorButtonProgramatically() {
        
        view.addSubview(indicatorButton)
        // constrin button 
        indicatorButton.heightAnchor.constraint(equalToConstant: indicatorButton.intrinsicContentSize.height).isActive = true
        indicatorButton.widthAnchor.constraint(equalToConstant: indicatorButton.intrinsicContentSize.width + CommonButton.Constants.widthPadding).isActive = true
        indicatorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorButton.topAnchor.constraint(equalTo: shadowButton.bottomAnchor, constant: (UIDevice.current.userInterfaceIdiom == .pad) ? 60 : 50).isActive = true
    
        /// setup activity indicator demo
        indicatorButton.touchUpInsideAction = {
            
            self.indicatorButton.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + Constants.indicatorAnimationTime, execute: {
                self.indicatorButton.stopAnimating()
            })
        }
    }
}

extension ExampleViewController {
    
    struct Constants {
        
        static let indicatorAnimationTime: TimeInterval = 1
        
        private init() {}
    }
}


