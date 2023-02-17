//
//  SignInViewModel.swift
//  Beer
//
//  Created by mac on 15.02.2023.
//

import Foundation

final class SignInViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var email: String = ""
    @Published var password: String = ""

    // MARK: - Internal methods
    func updateSignInButtonEnable() -> Bool {
        return email.isValidEmail() && password.isValidPassword()
    }
}
