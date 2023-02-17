//
//  DatabaseManager.swift
//  Beer
//
//  Created by Anastasia on 20.10.2022.
//

import Foundation
import Firebase

final class DatabaseManager {
    // MARK: - Internal properties
    static var shared = DatabaseManager()
    
    // MARK: - Private properties
    private let database = Database.database().reference()
    private var currentUser: User?
}

extension DatabaseManager {
    // MARK: - Internal methods
    func addUser(name: String, email: String, onSuccess: (() -> Void)?, onError: ((Error?) -> Void )?) {
        guard  let fUser = FirebaseManager.shared.auth.currentUser else {
            onError?(UserErrors.cantGetFBUser)
            return
        }
        let user = User(name: name, email: email)
        do {
            let data = try JSONEncoder().encode(user)
            let json = try JSONSerialization.jsonObject(with: data)
            database.child(fUser.uid).setValue(json)
            onSuccess?()
        } catch {
            onError?(error)
        }
    }
    
    func getUserData(onSuccess: ((User) -> Void)?, onError: ((Error?) -> Void )?) {
        guard let user = FirebaseManager.shared.auth.currentUser else {
            onError?(UserErrors.cantGetFBUser)
            return }
        database.child(user.uid).observe(.value, with: { (snapshot) in
            do {
                let data = try JSONSerialization.data(withJSONObject: snapshot.value as Any, options: [])
                let user = try JSONDecoder().decode(User.self, from: data)
                self.currentUser = user
                onSuccess?(user)
            } catch {
                onError?(error)
            }
        })
    }
    
    func addDrinkingBuddy(_ drinkingBuddy: DrinkingBuddy)  {
        guard let user  = FirebaseManager.shared.auth.currentUser,
              var c = currentUser else {
            return }
        
        var newArray = c.drinkingBuddys ?? []
        newArray.insert(drinkingBuddy, at: 0)
        if c.drinkingBuddys?.isEmpty ?? true {
            c.drinkingBuddys = newArray
            guard let data = try? JSONEncoder().encode(c),
                  let json = try? JSONSerialization.jsonObject(with: data) else { return }
            database.child(user.uid).setValue(json)
        } else {
            guard let data = try? JSONEncoder().encode(newArray),
                  let json = try? JSONSerialization.jsonObject(with: data) else { return }
            database.child(user.uid).child("drinkingBuddys").setValue(json)
        }
    }
    
    func removeDrinkingBuddy(at indexSet: IndexSet)  {
        guard let user  = FirebaseManager.shared.auth.currentUser,
              let c = currentUser else {
            return
        }
        
        var newArray = c.drinkingBuddys ?? []
        newArray.remove(atOffsets: indexSet )
        
        guard let data = try? JSONEncoder().encode(newArray),
              let json = try? JSONSerialization.jsonObject(with: data) else { return }
        database.child(user.uid).child("drinkingBuddys").setValue(json)
    }
}
