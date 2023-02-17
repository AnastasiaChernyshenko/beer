//
//  FirebaseManager.swift
//  Beer
//
//  Created by Anastasia on 20.10.2022.
//

import Foundation
import Firebase

final class FirebaseManager {
    static let shared = FirebaseManager()
    
    let auth = Auth.auth()
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signInUser(userEmail: String, userPassword: String, onSuccess: (() -> Void)?, onError: ((Error?) -> Void )?) {
        auth.signIn(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                onError?(error)
                return
            }
            switch authResult {
            case .none:
                onError?(UserErrors.signInError)
            case .some:
                onSuccess?()
            }
        }
    }
    
    func signUpUser(userEmail: String, userPassword: String, onSuccess: (() -> Void)?, onError: ((Error?) -> Void )?) {
        auth.createUser(withEmail: userEmail, password: userPassword) { authResult, error in
            guard error == nil else {
                onError?(error)
                return
            }
            switch authResult {
            case .none:
                onError?(UserErrors.signUpError)
            case .some:
                onSuccess?()
            }
        }
    }
    
    func signOutUser(onSuccess: (() -> Void)?, onError: ((Error?) -> Void )?) {
        do {
            try auth.signOut()
            onSuccess?()
        } catch {
            onError?(error)
        }
    }
}