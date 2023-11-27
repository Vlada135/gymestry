//
//  Sporteat.swift
//  Gymestry
//
//  Created by Владислава on 23.11.23.
//

import Foundation
import UIKit

struct Sporteat: Editable {
    
    var id: String?
    let sporteat: String
    let sporteatImage: String
    let description: String?
    let categorySelect: Bool
    let idCategory: String?
    
    var asDict: [String: Any] {
        var dict = [String: Any]()
        dict["sporteat"] = sporteat
        dict["sporteatImage"] = sporteatImage
        dict["description"] = description
        dict["categorySelect"] = categorySelect
        dict["idCategory"] = idCategory
        return dict
    }
    
    init(
        id: String? = nil,
        sporteat: String,
        sporteatImage: String,
        description: String? = nil,
        categorySelect: Bool,
        idCategory: String? = nil
    ) {
        self.id = id
        self.sporteat = sporteat
        self.sporteatImage = sporteatImage
        self.description = description
        self.categorySelect = categorySelect
        self.idCategory = idCategory
    }
    
    init(key: String, dict: [String: Any]) throws {
        guard let sporteat = dict["sporteat"] as? String,
              let sporteatImage = dict["sporteatImage"] as? String,
              let categorySelect = dict["categorySelect"] as? Bool
        else {
            let error = "Parsing contact error"
            print("[Contact parser] \(error)")
            throw error
        }
        self.id = key
        self.sporteat = sporteat
        self.sporteatImage = sporteatImage
        self.description = dict["description"] as? String
        self.categorySelect = categorySelect
        self.idCategory = dict["idCategory"] as? String
        
    }
}

