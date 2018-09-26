//
//  CaseContainerBaseViewController.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//
import UIKit

public protocol CaseContainerBaseViewContollerType: class {
    var viewContorllers: [UIViewController] { get }
    var appearence: Appearence { get }
    init(maintain: [UIViewController], appearence: Appearence)
    init()
}

open class CaseContainerBaseViewController: UIViewController, CaseContainerBaseViewContollerType  {
    
    public var viewContorllers: [UIViewController]
    public var appearence: Appearence
    
    required public init(maintain: [UIViewController], appearence: Appearence) {
        self.viewContorllers = maintain
        self.appearence = appearence
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required public init() {
        self.viewContorllers = Array<UIViewController>()
        self.appearence = Appearence(
            headerViewHegiht: 150,
            tabScrollViewHeight: 44,
            indicatorColor: .green,
            tabButtonColor: (normal: .gray, highLight: .black))
        super.init(nibName: nil, bundle: nil)
    }
    
    
}


