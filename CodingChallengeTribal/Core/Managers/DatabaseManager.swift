//
//  DatabaseManager.swift
//  CodingChallengeTribal
//
//  Created by Gabriel Rico on 15/2/21.
//

import UIKit
import RealmSwift
import Realm

class DatabaseManager: NSObject {
    
    //MARK: - Variables
    
    static let shared = DatabaseManager()
    private var databaseThread: DMThread!
    var realm: Realm {
        return try! Realm()
    }
    
    //MARK: - Override Functions
    
    private override init() {
        super.init()
        databaseThread = DMThread(start: true, queue: nil)
    }
    
    //MARK: - Public Functions
    
    public func perfrmOnDatabaseThread(_ block: @escaping ()->()) {
        databaseThread.enqueue {
            block()
        }
    }
    
    public func emptyQueue() {
        databaseThread.emptyQueue()
    }
}

class RealmManager {

    private let NotificationError = Notification.Name.init(rawValue: "Realm")

    let realm:Realm = DatabaseManager.shared.realm

    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            post(error)
        }
    }

    func create<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            post(error)
        }
    }

    func read<T: Object>(_ object: T.Type) -> Results<T> {
        let result = realm.objects(object.self)
        return result
    }

    func update<T: Object>(_ object: T, with dictionary: [String: Any]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }

    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }

    func post(_ error: Error) {
        NotificationCenter.default.post(name: NotificationError, object: error)
    }

    func observeRealErrors(in viewController: UIViewController, complation: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NotificationError, object: viewController, queue: nil) { (notification) in
            complation(notification.object as? Error)
        }
    }

    func stopObserveRealErrors(in viewController: UIViewController) {
        NotificationCenter.default.removeObserver(viewController, name: NotificationError, object: nil)
    }
}
