//
//  UserErrors.swift
//  Beer
//
//  Created by mac on 16.02.2023.
//

import Foundation

enum UserErrors: Error {
    case signInError
    case signUpError
    case cantGetUserData
    case cantGetFBUser
}

extension UserErrors: CustomStringConvertible {
    public var description: String {
        switch self {
        case .signInError:
            return "Failed to login"
        case .signUpError:
            return "Could not create account"
        case .cantGetUserData:
            return "Sorry, can't receive your account information"
        case .cantGetFBUser:
            return "Sorry, FB user isn't found"
        }
    }
}
