//
//  SignUpViewModel.swift
//  Beer
//
//  Created by mac on 15.02.2023.
//

import Foundation

final class SignUpViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    func updateSignUpButtonEnable() -> Bool {
        return !username.isEmpty && email.isValidEmail() && password.isValidPassword() && password == confirmPassword
    }
}
