//
//  Extensions.swift
//  Beer
//
//  Created by Anastasia on 19.10.2022.
//

import Foundation
import SwiftUI

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

extension Color {
    static let mainColor = Color("MainColor")
    static let yellowColor = Color("YellowColor")
}

extension Image {
    static let viewFinder = Image(systemName: "location.fill.viewfinder")
    static let triangleFill = Image(systemName: "triangle.fill")
    static let systemNamePersonFill = "person.fill"
    static let systemNameShareplay = "shareplay"
    static let systemNamePersonGroupFill = "person.3.fill"
    static let beerIllustration = Image("beer-illustration")
    static let pivoRetroPoster = Image("pivo-retro-poster")
    static let ooopsIcon = Image("ooops-icon")
}

