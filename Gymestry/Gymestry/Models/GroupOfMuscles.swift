//
//  GroupOfMuscles.swift
//  Gymestry
//
//  Created by Владислава on 5.11.23.
//

import Foundation
import UIKit

struct GroupOfMuscles: Editable {
    
    var id: String?
    let group: String
    let groupImage: String
    
    var asDict: [String: Any] {
        var dict = [String: Any]()
        dict["group"] = group
        dict["groupImage"] = groupImage
        return dict
    }
    
    init(
        id: String? = nil,
        group: String,
        groupImage: String
    ) {
        self.id = id
        self.group = group
        self.groupImage = groupImage
        
    }
    
    init(key: String, dict: [String: Any]) throws {
        guard let group = dict["group"] as? String,
              let groupImage = dict["groupImage"] as? String
        else {
            let error = "Parsing contact error"
            print("[Contact parser] \(error)")
            throw error
        }
        
        self.id = key
        self.group = group
        self.groupImage = groupImage
    }
}

extension String: Error {}

protocol Editable {
    var id: String? { get }
}

