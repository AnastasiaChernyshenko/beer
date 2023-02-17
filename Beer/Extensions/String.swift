//
//  String.swift
//  Beer
//
//  Created by mac on 17.02.2023.
//

import Foundation

extension String {
    func isValidEmail()-> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegx)
        return passwordCheck.evaluate(with: password)
    }
    
    func updateEmail() -> String {
        return self.replacingOccurrences(of: ".", with: "-")
    }
}
