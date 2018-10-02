//
//  NarmalViewController.swift
//  Example
//
//  Created by minjuniMac on 29/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit
import CaseContainer
class OrdinaryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let height = (UIScreen.mainHeight - UIApplication.shared.statusBarFrame.height) / 3
        
        for index in 0..<3 {
            let rect = CGRect(
                x: 0, y: height * CGFloat(index),
                width: UIScreen.mainWidth, height: height)
            let colorView = UIView(frame: rect)
            view.addSubview(colorView)
            colorView.backgroundColor = UIColor.generateRandomColor()
        }
    }
}


