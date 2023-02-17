//
//  HistoryViewModel.swift
//  Beer
//
//  Created by mac on 15.02.2023.
//

import Foundation

final class HistoryViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var drinkingBuddies: [DrinkingBuddy]
    @Published var errorText: String?
    @Published var isShowErrorView = false
    
    // MARK: - Initialization
    init(drinkingBuddies: [DrinkingBuddy]) {
        self.drinkingBuddies = drinkingBuddies
    }
}

extension HistoryViewModel {
    // MARK: - Internal methods
    func deleteDrinkingUserFromDB(atIndexSet: IndexSet) {
        DatabaseManager.shared.removeDrinkingBuddy(at: atIndexSet)
    }
}
