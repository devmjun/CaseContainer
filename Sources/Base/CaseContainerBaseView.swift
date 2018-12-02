//
//  CaseContainerBaseView.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

public protocol CaseContainerBaseViewType {
    associatedtype ViewController: CaseContainerBaseViewContollerType
    // weak var vc: ViewController! { get }
    // https://github.com/apple/swift-evolution/blob/master/proposals/0186-remove-ownership-keyword-support-in-protocols.md
    init(controllBy viewController: ViewController)
}

open class CaseContainerBaseView<ViewController: CaseContainerBaseViewContollerType>: UIView, CaseContainerBaseViewType, PreservationType {
    weak public var vc: ViewController!
    
    required public init(controllBy viewController: ViewController) {
        vc = viewController
        super.init(frame: UIScreen.main.bounds)
        restorationIdentifier = unUniqueIdentifier
        setupUI()
        setupBinding()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     when you use this method, you must override this method
     */
    func setupUI() {
        
    }
    
    /**
     when you use this method, you must override this method
     */
    func setupBinding() {
        
    }
    
}

