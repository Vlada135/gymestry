//
//  Environment.swift
//  Gymestry
//
//  Created by Владислава on 10.10.23.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

struct Environment {
    static let ref = Database.database(url: "https://gymestry-a7556-default-rtdb.firebaseio.com/").reference()
    static let storage = Storage.storage(url: "gs://gymestry-a7556.appspot.com").reference()
}
