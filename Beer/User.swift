//
//  User.swift
//  Beer
//
//  Created by mac on 23.11.2022.
//

import Foundation
import SwiftUI

struct UserResponse: Decodable {
    let results: [UserInfo]
}

class UserInfo: Identifiable, Decodable, ObservableObject, Equatable {
    static func == (lhs: UserInfo, rhs: UserInfo) -> Bool {
        return lhs.email == rhs.email
    }

    let name: NameInfo
    let location: LocationInfo
    let picture: PictureInfo
    let email: String
}

struct NameInfo: Decodable {
    let first: String
    let last: String
}

struct LocationInfo: Decodable {
    let coordinates: Coordinates
}

struct Coordinates: Decodable {
    let latitude: String
    let longitude: String
}

struct PictureInfo: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct User: Codable {
    let name: String
    let email: String
    var drinkingBuddys: [DrinkingBuddy]?
}

struct DrinkingBuddy: Codable {
    let name: String
    let email: String
    let picture: String
}
