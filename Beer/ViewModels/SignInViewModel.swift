//
//  SignInViewModel.swift
//  Beer
//
//  Created by mac on 15.02.2023.
//

import Foundation

final class SignInViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""

    func updateSignInButtonEnable() -> Bool {
        return email.isValidEmail() && password.isValidPassword()
    }
}
