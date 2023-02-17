//
//  BeerApp.swift
//  Beer
//
//  Created by Anastasia on 18.10.2022.
//

import SwiftUI
import Firebase

@main
struct BeerApp: App {
    // MARK: - Internal properties
    @StateObject var userStateViewModel = UserStateViewModel()
    
    // MARK: - Initialization
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ApplicationSwitcher()
            }
            .navigationViewStyle(.stack)
            .environmentObject(userStateViewModel)
        }
    }
}

struct ApplicationSwitcher: View {
    // MARK: - Internal properties
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        if vm.isLoggedIn {
            HomeView().environmentObject(vm)
        } else {
            ContentView().environmentObject(vm)
        }
    }
}
