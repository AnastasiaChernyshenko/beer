//
//  UserStateViewModel.swift
//  Beer
//
//  Created by Anastasia on 20.10.2022.
//

import Foundation

@MainActor
final class UserStateViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var drinkingBuddies = [DrinkingBuddy]()
    @Published var isLoggedIn = false
    @Published var isLoading = false
    @Published var errorText: String?
    @Published var isShowErrorView = false
    
    init() {
        isLoggedIn = FirebaseManager.shared.isSignedIn
    }
    
    func signOut() {
        isLoading = true
        FirebaseManager.shared.signOutUser(onSuccess: { [weak self] in
            self?.isLoggedIn = false
            self?.errorHandler(nil)
        }, onError: { [weak self] error in
            self?.errorHandler(error)
        })
    }

    func signInUser(userEmail: String, userPassword: String) {
        isLoading = true
        FirebaseManager.shared.signInUser(userEmail: userEmail, userPassword: userPassword, onSuccess: { [weak self] in
            self?.isLoggedIn = true
            self?.errorHandler(nil)
        }, onError: { [weak self] error in
            self?.errorHandler(error)
        })
    }

    func signUpUser(name: String, userEmail: String, userPassword: String) {
        isLoading = true
        FirebaseManager.shared.signUpUser(userEmail: userEmail, userPassword: userPassword, onSuccess: { [weak self] in
            DatabaseManager.shared.addUser(name: name, email: userEmail, onSuccess: {
                self?.isLoggedIn = true
                self?.errorHandler(nil)
            }, onError: { [weak self] error in
                self?.errorHandler(error)
            })
        }, onError: { [weak self] error in
            self?.errorHandler(error)
        })
    }
    
    func getUserData() {
        isLoading = true
        DatabaseManager.shared.getUserData { [weak self] user in
            self?.errorHandler(nil)
            self?.user = user
            self?.drinkingBuddies = user.drinkingBuddys ?? []
        } onError: { [weak self] error in
            self?.errorHandler(error)
        }
    }
}

private extension UserStateViewModel {
    func errorHandler(_ error: Error?) {
        isLoading = false
        errorText = error?.localizedDescription
        isShowErrorView = error != nil
    }
}
