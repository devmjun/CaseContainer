//
//  NarmalViewController.swift
//  Example
//
//  Created by minjuniMac on 29/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

class OrdinaryViewController: UIViewController {
    var v: UIView = UIView()
    var v1: UIView = UIView()
    var v2: UIView = UIView()
    var v3: UIView = UIView()
    var v4: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        v.backgroundColor = .red
        v1.backgroundColor = .orange
        v2.backgroundColor = .yellow
        v3.backgroundColor = .green
        v4.backgroundColor = .blue
        
        view.addSubview(v)
        view.addSubview(v1)
        view.addSubview(v2)
        view.addSubview(v3)
        view.addSubview(v4)
        
        let height = (UIScreen.mainHeight - UIApplication.shared.statusBarFrame.height) / 5
        
        v.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        v.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        v.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        v.heightAnchor.constraint(equalToConstant: height).isActive = true
        v.translatesAutoresizingMaskIntoConstraints = false
        
        v1.topAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
        v1.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        v1.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        v1.heightAnchor.constraint(equalToConstant: height).isActive = true
        v1.translatesAutoresizingMaskIntoConstraints = false
        
        v2.topAnchor.constraint(equalTo: v1.bottomAnchor).isActive = true
        v2.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        v2.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        v2.heightAnchor.constraint(equalToConstant: height).isActive = true
        v2.translatesAutoresizingMaskIntoConstraints = false
        
        v3.topAnchor.constraint(equalTo: v2.bottomAnchor).isActive = true
        v3.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        v3.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        v3.heightAnchor.constraint(equalToConstant: height).isActive = true
        v3.translatesAutoresizingMaskIntoConstraints = false
        
        v4.topAnchor.constraint(equalTo: v3.bottomAnchor).isActive = true
        v4.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        v4.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        v4.heightAnchor.constraint(equalToConstant: height).isActive = true
        v4.translatesAutoresizingMaskIntoConstraints = false
        

        
        
        
    }
}
