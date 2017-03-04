//
//  FrontSquatCount.swift
//  FlatPig
//
//  Created by David Roddy on 3/2/17.
//  Copyright © 2017 David Roddy. All rights reserved.
//

import Foundation
import RealmSwift

class FrontSquatCount: Object {
    dynamic var date: Date = Date()
    dynamic var count: Int = Int(0)
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
}

