//
//  ProfileView.swift
//  Beer
//
//  Created by Anastasia on 18.10.2022.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    
    @EnvironmentObject var userState: UserStateViewModel
    @State private var showLogOutAlert = false
    
    var body: some View {
        Color.yellowColor
            .ignoresSafeArea()
            .overlay(
                VStack {
                    if !userState.isLoading {
                        image
                        userName
                        userEmail
                        logoutButton
                    } else {
                        ActivityIndicator()
                    }
                }
                    .alert(Constants.logoutConfirmation, isPresented: $showLogOutAlert) {
                        Button(Constants.cancel, role: .cancel) { }
                        Button(Constants.yes) {
                            userState.signOut()
                        }
                    }
            )
    }
    
    func signOutUser() {
        userState.signOut()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

private extension ProfileView {
    var image: some View {
        Image.beerIllustration
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 300, maxHeight: 300)
    }
    
    var userName: some View {
        Text(userState.user?.name ?? "" )
            .font(.title2)
            .fontWeight(.bold)
            .padding(.bottom, 15)
    }
    
    var userEmail: some View {
        Text(userState.user?.email ?? "" )
            .font(.subheadline)
            .padding(.bottom, 75)
    }
    
    var logoutButton: some View {
        Button(Constants.logout, action: {
            showLogOutAlert.toggle()
        })
        .tint(.red)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
    }
}
