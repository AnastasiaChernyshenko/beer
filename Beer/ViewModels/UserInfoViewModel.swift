//
//  UserInfoViewModel.swift
//  Beer
//
//  Created by mac on 15.02.2023.
//

import Foundation
import UIKit

final class UserInfoViewModel: ObservableObject {
    
    var selectedUser: UserInfo
    
    init(selectedUser: UserInfo) {
        self.selectedUser = selectedUser
    }
    
    func addUserToHistory() {
        let name = selectedUser.name.first + " " + selectedUser.name.last
        let buddy = DrinkingBuddy(
            name: name,
            email: selectedUser.email,
            picture: selectedUser.picture.large
        )
        DatabaseManager.shared.addDrinkingBuddy(buddy)
    }
    
    func openInGoogleMaps() {
        guard let lat = Double(selectedUser.location.coordinates.latitude),
              let long = Double(selectedUser.location.coordinates.longitude) else { return }
        
        if let url = URL(string: "comgooglemaps://"),
           UIApplication.shared.canOpenURL(url) {
            if let url = URL(string: "comgooglemaps-x-callback://?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                UIApplication.shared.open(url, options: [:])
            }
        } else {
            if let urlDestination = URL.init(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=driving") {
                UIApplication.shared.open(urlDestination)
            }
        }
    }
}
