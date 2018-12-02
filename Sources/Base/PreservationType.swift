//
//  PreservationType.swift
//  CaseContainer
//
//  Created by Minjun Ju on 02/12/2018.
//  Copyright © 2018 mjun. All rights reserved.
//

import UIKit

protocol PreservationType {
    var unUniqueIdentifier: String { get }
}

extension PreservationType {
    var unUniqueIdentifier: String {
        return String(describing: type(of:self))
    }
}
