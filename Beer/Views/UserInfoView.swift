//
//  UserInfoView.swift
//  Beer
//
//  Created by mac on 03.12.2022.
//

import SwiftUI
import MapKit

struct UserInfoView: View {
    // MARK: - Internal properties
    @Binding var tabIndex: Int
    
    // MARK: - Private properties
    @ObservedObject private var vm: UserInfoViewModel
    
    // MARK: - Initialization
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
                .frame(maxWidth: 300.0, maxHeight: 300.0)
        },
                   placeholder: {
            ProgressView()
        })
        .cornerRadius(10.0)
        .padding(.bottom, 20.0)
    }
    
    var userEmail: some View {
        Text(vm.selectedUser.email)
            .font(.subheadline)
            .padding(.bottom, 75.0)
    }
    
    var userName: some View {
        Text(vm.selectedUser.name.first + " " + vm.selectedUser.name.last)
            .font(.title2)
            .fontWeight(.bold)
            .padding(.bottom, 15.0)
    }
    
    var addToHistotyButton: some View {
        Button {
            vm.addUserToHistory()
            tabIndex = 2
        } label: {
            Text("map.offer_drink")
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
            Text("map.in_google_maps")
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
