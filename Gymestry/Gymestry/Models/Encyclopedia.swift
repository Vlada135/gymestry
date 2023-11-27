//
//  Encyclopedia.swift
//  Gymestry
//
//  Created by Владислава on 24.11.23.
//

import Foundation
import UIKit

struct Encyclopedia: Editable {
    
    var id: String?
    let title: String
    let encyclopediaImage: String
    let description: String?
    
    var asDict: [String: Any] {
        var dict = [String: Any]()
        dict["title"] = title
        dict["encyclopediaImage"] = encyclopediaImage
        dict["description"] = description
        return dict
    }
    
    init(
        id: String? = nil,
        title: String,
        encyclopediaImage: String,
        description: String? = nil
    ) {
        self.id = id
        self.title = title
        self.encyclopediaImage = encyclopediaImage
        self.description = description
    }
    
    init(key: String, dict: [String: Any]) throws {
        guard let title = dict["title"] as? String,
              let encyclopediaImage = dict["encyclopediaImage"] as? String
        else {
            let error = "Parsing contact error"
            print("[Contact parser] \(error)")
            throw error
        }
        self.id = key
        self.title = title
        self.encyclopediaImage = encyclopediaImage
        self.description = dict["description"] as? String
    }
}

