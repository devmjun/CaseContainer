//
//  UIScreen+bounds.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

extension UIScreen {
    static var mainBounds: CGRect { return UIScreen.main.bounds }
    static var mainWidth: CGFloat { return UIScreen.main.bounds.width }
    static var mainHeight: CGFloat { return UIScreen.main.bounds.height }
    static var mainSize: CGSize { return UIScreen.main.bounds.size }    
}

