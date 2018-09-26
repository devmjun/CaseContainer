//
//  UIView+Anchor.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

extension UIView {
    func topAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    func leadingAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    func bottomAnchor(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    func trailingAnchor(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }
    
    func widthAnchor(constant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func heightAnchor(constant: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    func dimensionAnchors(width widthConstant: CGFloat, height heightConstant: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        return self
    }
    
    func dimensionAnchors(size: CGSize) -> Self {
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        return self
    }
    
    /**
     Don't forget useing it when you develop programmatically UI
     */
    func activateAnchors() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}


