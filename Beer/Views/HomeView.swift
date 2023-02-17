//
//  HomeView.swift
//  Beer
//
//  Created by Anastasia on 19.10.2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: UserStateViewModel
    @State var currentTab = 0
    
    var body: some View {
        TabView(selection: $currentTab) {
            profileTab
            mapTab
            historyTab
        }.accentColor(.mainColor)
            .onAppear {
                vm.getUserData()
            }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserStateViewModel())
    }
}

private extension HomeView {
    var profileTab: some View {
        ProfileView().tabItem { Label(Constants.profile, systemImage: Image.systemNamePersonFill) }
            .tag(0)
            .onAppear() {
                self.currentTab = 0
            }
    }
    
    var mapTab: some View {
        SearchUsersMapView(vm: MapViewModel(), tabIndex: $currentTab).tabItem { Label(Constants.findSomeone, systemImage: Image.systemNameShareplay) }
            .tag(1)
            .onAppear() {
                self.currentTab = 1
            }
    }
    
    var historyTab: some View {
        HistoryView(viewModel: HistoryViewModel(drinkingBuddies: vm.drinkingBuddies)).tabItem { Label(Constants.history, systemImage: Image.systemNamePersonGroupFill) }
            .tag(2)
            .onAppear() {
                self.currentTab = 2
            }
    }
}
