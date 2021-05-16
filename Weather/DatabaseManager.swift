//
//  DatabaseManager.swift
//  Weather
//
//  Created by Ashirvad Jena on 15/05/21.
//

import RealmSwift

public class DatabaseManager {
    
    var realm: Realm {
        do {
            let realm = try Realm()
            return realm
        } catch {
            debugPrint(error.localizedDescription)
        }
        return self.realm
    }
    
    func write(writeClosure: () -> Void) {
        do {
            try realm.write {
                writeClosure()
            }
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func removeAllData() {
        write {
            realm.deleteAll()
        }
    }
}
