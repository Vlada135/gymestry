//
//  RealmManager.swift
//  Gymestry
//
//  Created by Владислава on 1.10.23.
//

import Foundation
import RealmSwift

final class RealmManager<T: Object> {
    private let realm = try? Realm()
    
    func read() -> [T] {
        guard let realm else { return []}
        return Array(realm.objects(T.self))
    }
    
    func write(_ object: T) {
        try? realm?.write({
            realm?.add(object)
        })
    }
    
    func update(realmBlock: ((Realm) -> Void)?) {
        guard let realm else { return }
        realmBlock?(realm)
    }
    
    func delete(_ object: T) {
        try? realm?.write({
            realm?.delete(object)
        })
    }
}
