//
//  PersonData.swift
//  Gymestry
//
//  Created by Владислава on 19.11.23.
//

import Foundation
import UIKit

struct PersonData {
    
    let name: String?
    let height: String?
    let age: String?
    let personImage: String?
    
    var asDict: [String: Any] {
        var dict = [String: Any]()
        dict["name"] = name
        dict["height"] = height
        dict["age"] = age
        dict["personImage"] = personImage
        return dict
    }
    
    init(
        name: String? = nil,
        height: String? = nil,
        weight: String? = nil,
        personImage: String? = nil
    ) {
        self.name = name
        self.height = height
        self.age = weight
        self.personImage = personImage
    }
    
    init(key: String, dict: [String: Any]) throws {
        self.name = dict["name"] as? String
        self.height = dict["height"] as? String
        self.age = dict["age"] as? String
        self.personImage = dict["personImage"] as? String
    }
}


