//
//  RealmManager.swift
//  YummyNews
//
//  Created by Hai IT. Hoang Minh on 28/08/2021.
//

import Foundation
import RealmSwift

enum RealmResult: Int {
    case failed = 0
    case success = 1
}

typealias RealmDataCallBack = (_ result: RealmResult) -> ()

protocol RealmManagerProtocol {
    func saveObjectToDatabase<T: Object>(with object: T, completion: RealmDataCallBack?)
    func saveArrayToDatabase<T: Object>(with objects: [T], completion: RealmDataCallBack?)
    func upsertArrayToDatabase<T: Object>(with objects: [T], completion: RealmDataCallBack?)
    func getObjects<T: Object>(from objectType: T.Type) -> Results<T>
    func getObjects<T: Object>(from objectType: T.Type, predicate: NSPredicate) -> Results<T>
    func getObject<T: Object>(type: T.Type, key: String) -> T?
    func update(block: () -> (), completion: RealmDataCallBack?)
    func deleteAllFromDatabase(completion: RealmDataCallBack?)
    func deleteObject<T: Object>(with objectType: T.Type, completion: RealmDataCallBack?)
}

class RealmManager: RealmManagerProtocol {
    static let shared = RealmManager()
    private var realm: Realm!
    
    init() {
        print("realm file URL: \(String(describing: Realm.Configuration.defaultConfiguration.fileURL))")
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 20,
            
            objectTypes: [
                
            ]
        )
        realm = try! Realm(configuration: config)
    }
    
    func getRealm() -> Realm {
        return realm
    }
    
    // MARK: - CRUD
    
    func saveObjectToDatabase<T: Object>(with object: T, completion: RealmDataCallBack?) {
        do {
            try realm.write {
                realm.add(object)
            }
            completion?(.success)
        } catch {
            completion?(.failed)
        }
    }
    
    func saveArrayToDatabase<T: Object>(with objects: [T], completion: RealmDataCallBack?) {
        do {
            try realm.write {
                realm.add(objects)
            }
            completion?(.success)
        } catch {
            completion?(.failed)
        }
    }
    
    func upsertArrayToDatabase<T: Object>(with objects: [T], completion: RealmDataCallBack?) {
        do {
            try realm.write {
                realm.add(objects, update: .modified)
            }
            completion?(.success)
        } catch {
            completion?(.failed)
        }
    }
    
    func getObjects<T: Object>(from objectType: T.Type) -> Results<T> {
        return realm.objects(objectType)
    }
    
    func getObjects<T: Object>(from objectType: T.Type, predicate: NSPredicate) -> Results<T> {
        return realm.objects(T.self).filter(predicate)
    }
    
    func getObject<T: Object>(type: T.Type, key: String) -> T? {
        return realm.object(ofType: type, forPrimaryKey: key)
    }
    
    func update(block: () -> (), completion: RealmDataCallBack?) {
        do {
            try realm.write {
                block()
            }
            completion?(.success)
        } catch {
            completion?(.failed)
        }
    }
    
    func deleteAllFromDatabase(completion: RealmDataCallBack?) {
        do {
            try realm.write {
                realm.deleteAll()
            }
            completion?(.success)
        } catch {
            completion?(.failed)
        }
    }
    
    func deleteObject<T: Object>(with objectType: T.Type, completion: RealmDataCallBack?) {
        do {
            try realm.write {
                let objects = realm.objects(objectType)
                realm.delete(objects)
            }
            completion?(.success)
        } catch {
            completion?(.failed)
        }
    }
    
}
