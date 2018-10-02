//
//  Appearence.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

public struct Appearance {
    public let headerHeight: CGFloat
    public let tabScrollHegiht: CGFloat
    public let indicatorColor: UIColor
    public let tabColor: (normal: UIColor, highLight: UIColor)
    
    public init(
        headerViewHegiht: CGFloat,
        tabScrollViewHeight: CGFloat,
        indicatorColor: UIColor,
        tabButtonColor: (normal: UIColor, highLight: UIColor) ) {
        
        self.headerHeight = headerViewHegiht
        self.tabScrollHegiht = tabScrollViewHeight
        self.indicatorColor = indicatorColor
        self.tabColor = tabButtonColor   
    }
}

