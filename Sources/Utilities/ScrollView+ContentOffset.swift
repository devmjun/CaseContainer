//
//  ScrollView+ContentOffset.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/10/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

extension UIScrollView {
    func setContentOffset(x: CGFloat = 0, y: CGFloat = 0, animated: Bool = false) {
        setContentOffset(CGPoint(x: x, y: y), animated: animated)
    }
}
