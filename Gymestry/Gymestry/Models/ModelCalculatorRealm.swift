//
//  ModelCalculatorRealm.swift
//  Gymestry
//
//  Created by Владислава on 29.10.23.
//

import Foundation
import RealmSwift

class Parameters: Object {
    @Persisted var result: String
    
    convenience init(
        result: String
    ){
        self.init()
        self.result = result
    }
}

