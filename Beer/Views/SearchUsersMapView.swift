//
//  SearchUsersMapView.swift
//  Beer
//
//  Created by Anastasia on 19.10.2022.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct SearchUsersMapView: View {
    
    @ObservedObject var vm: MapViewModel
    @Binding var tabIndex: Int
    
    init(vm: MapViewModel, tabIndex: Binding<Int>) {
        self.vm = vm
        self._tabIndex = tabIndex
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            mapView
            VStack {
                Spacer()
                ZStack {
                    if vm.selectedUser != nil {
                        userPreviewView
                    }
                }
            }
        }.onAppear{
            vm.onAppear()
        }
        .sheet(item: $vm.shitUser) { user in
            UserInfoView(vm: UserInfoViewModel(selectedUser: user), tabIndex: $tabIndex)
        }
        .alert(vm.error?.localizedDescription ?? "common.error", isPresented: $vm.showUserError) {
            Button("common.ok", role: .cancel) {
                vm.showUserError = false
            }
        }
    }
}

struct SearchUsersMapView_Previews: PreviewProvider {
    static var previews: some View {
        SearchUsersMapView(vm: MapViewModel(), tabIndex: .constant(1))
    }
}

private extension SearchUsersMapView {
    var mapView: some View {
        Map(coordinateRegion: Binding(get: { vm.mapRegion }, set: { _ in }),
            interactionModes: .all,
            showsUserLocation: true,
            userTrackingMode: $vm.tracking,
            annotationItems: vm.users) { user in
            MapAnnotation(coordinate: vm.getLocationForUser(user)) {
                UserAnnotationView(imageURL: user.picture.thumbnail).scaleEffect(user == vm.selectedUser ? 1.0 : 0.7)
                    .onTapGesture(count: 1, perform: {
                        vm.selectedUser = user
                    })
            }
        }.ignoresSafeArea(edges: .top)
            .onAppear {
                vm.requestLocation()
            }
    }

    var userPreviewView: some View {
        UserPreviewView(vm: vm)
            .shadow(color: Color.black.opacity(0.3), radius: 20.0)
            .padding()
            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
}
