//
//  TabButton.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

open class TabButton: UIButton {
    enum TurnType {
        case off, on
        /**
         this method turn On/Off high Light status
         */
        mutating func turn() {
            switch self {
            case .off: self = .on
            case .on: self = .off
            }
        }
    }
    
    var turnType: TurnType = .off {
        willSet {
            titleLabel?.font = newValue == .on ? UIFont.boldSystemFont(ofSize: 17) : UIFont.systemFont(ofSize: 16)
            setTitleColor(newValue == .on ? highLightedColor ?? .black : normalColor ?? .gray, for: .normal)
        }
    }
    
    var highLightedColor: UIColor?
    var normalColor: UIColor?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

