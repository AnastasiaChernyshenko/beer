//
//  HistoryViewModel.swift
//  Beer
//
//  Created by mac on 15.02.2023.
//

import Foundation

final class HistoryViewModel: ObservableObject {
    
    @Published var drinkingBuddies: [DrinkingBuddy]
    @Published var errorText: String?
    @Published var isShowErrorView = false
    
    init(drinkingBuddies: [DrinkingBuddy]) {
        self.drinkingBuddies = drinkingBuddies
    }
    
    func deleteDrinkingUserFromDB(atIndexSet: IndexSet) {
        DatabaseManager.shared.removeDrinkingBuddy(at: atIndexSet)
    }
}
