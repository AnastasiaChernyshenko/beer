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
                    .alert("authorization.log_out_confirm", isPresented: $showLogOutAlert) {
                        Button("common.cancel", role: .cancel) { }
                        Button("common.yes") {
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
            .frame(maxWidth: 300.0, maxHeight: 300.0)
    }
    
    var userName: some View {
        Text(userState.user?.name ?? "" )
            .font(.title2)
            .fontWeight(.bold)
            .padding(.bottom, 15.0)
    }
    
    var userEmail: some View {
        Text(userState.user?.email ?? "" )
            .font(.subheadline)
            .padding(.bottom, 75.0)
    }
    
    var logoutButton: some View {
        Button("authorization.log_out", action: {
            showLogOutAlert.toggle()
        })
        .tint(.red)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
    }
}
