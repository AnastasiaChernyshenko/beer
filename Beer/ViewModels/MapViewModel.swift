//
//  LocationViewModel.swift
//  Beer
//
//  Created by mac on 07.12.2022.
//

import Foundation
import _MapKit_SwiftUI
import SwiftUI
import Combine

private let kyivCenter = CLLocationCoordinate2D(latitude: 50.4489126, longitude: 30.5252008)

final class MapViewModel: ObservableObject {
    // MARK: - Published properties
    @Published var tracking: MapUserTrackingMode = .follow
    @Published var error: Swift.Error?
    @Published var showUserError = false
    @Published var showingUserDetailView = false
    @Published var users: [UserInfo] = []
    @Published var shitUser: UserInfo?
    @Published var selectedUser: UserInfo?
    
    // MARK: - Internal properties
    var mapRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: kyivCenter,
        span: MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
    )
    
    // MARK: - Private properties
    private var cancellables = Set<AnyCancellable>()
    private var locationManager = LocationManager.shared
    private let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
}

extension MapViewModel {
    // MARK: - Internal methods
    func onAppear() {
        guard users.isEmpty else { return }
        getUsers()
    }
    
    func showUserPreview() -> Bool {
        return showingUserDetailView && selectedUser != nil
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func nextButtonPressed() {
        guard let currentIndex = users.firstIndex(where: { $0 == selectedUser }) else { return }
        let nextIndex = currentIndex + 1
        guard users.indices.contains(nextIndex) else {
            guard let firstUser = users.first else { return }
            showNextUser(firstUser)
            return
        }
        let nextUser = users[nextIndex]
        showNextUser(nextUser)
    }
    
    func getLocationForUser(_ user: UserInfo? ) -> CLLocationCoordinate2D {
        if let user = user,
           let lat = Double(user.location.coordinates.latitude),
           let long = Double(user.location.coordinates.longitude) {
            return CLLocationCoordinate2D(latitude: lat, longitude: long)
        } else {
            return kyivCenter
        }
    }
    
    func showNextUser(_ user: UserInfo) {
        selectedUser = user
        updateMapRegionFor(user: user)
    }
}

private extension MapViewModel {
    // MARK: - Private methods
    func updateMapRegionFor(user: UserInfo) {
        mapRegion = MKCoordinateRegion(center: getLocationForUser(user), span: mapSpan)
    }
    
    func getUsers() {
        Network.shared.getUsers().sink { [weak self] completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                self?.error = error
                self?.showUserError = true
            }
        } receiveValue: { [weak self] users in
            self?.users = users
            if let firstUser = users.first {
                self?.showNextUser(firstUser)
            }
        }.store(in: &cancellables)
    }
}
