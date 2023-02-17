//
//  UserInfoView.swift
//  Beer
//
//  Created by mac on 03.12.2022.
//

import SwiftUI
import MapKit

struct UserInfoView: View {
    
    @ObservedObject private var vm: UserInfoViewModel
    @Binding var tabIndex: Int
    
    init(vm: UserInfoViewModel, tabIndex: Binding<Int>) {
        self.vm = vm
        self._tabIndex = tabIndex
    }
    
    var body: some View {
        Color.yellowColor
            .ignoresSafeArea()
            .overlay(
                VStack {
                    userImage
                    userName
                    userEmail
                    addToHistotyButton
                    openInGoogleMapsButton
                }
            )
    }
}

private extension UserInfoView {
    
    var userImage: some View {
        AsyncImage(url: URL(string: (vm.selectedUser.picture.large)),
                   content: { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 300, maxHeight: 300)
        },
                   placeholder: {
            ProgressView()
        })
        .cornerRadius(10)
        .padding(.bottom, 20)
    }
    
    var userEmail: some View {
        Text(vm.selectedUser.email)
            .font(.subheadline)
            .padding(.bottom, 75)
    }
    
    var userName: some View {
        Text(vm.selectedUser.name.first + " " + vm.selectedUser.name.last)
            .font(.title2)
            .fontWeight(.bold)
            .padding(.bottom, 15)
    }
    
    var addToHistotyButton: some View {
        Button {
            vm.addUserToHistory()
            tabIndex = 2
        } label: {
            Text(Constants.offerDrink)
                .font(.headline)
        }
        .tint(Color.mainColor)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
    }
    
    var openInGoogleMapsButton: some View {
        Button {
            vm.openInGoogleMaps()
        } label: {
            Text(Constants.openInGoogleMaps)
                .font(.headline)
        }
        .tint(Color.mainColor)
    }
}

//
//struct UserInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserInfoView()
//    }
//}
