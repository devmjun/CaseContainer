//
//  Array+index.swift
//  CaseContainer
//
//  Created by minjuniMac on 25/09/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

extension Array {
    func at(_ index: Int?) -> Element? {
        if let index = index, index >= 0 && index < endIndex {
            return self[index]
        }else {
            return nil
        }
    }
}




