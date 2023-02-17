//
//  LocationManager.swift
//  Beer
//
//  Created by mac on 10.02.2023.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject {
    // MARK: - Internal properties
    static let shared = LocationManager()
    
    // MARK: - Private properties
    private var location: CLLocationCoordinate2D?
    private let manager = CLLocationManager()

    // MARK: - Initialization
    private override init() {
        super.init()
        
        setup()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        location = nil
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkPermission()
    }
}

extension LocationManager {
    // MARK: - Internal methods
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
    }
    
    func checkPermission() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
}

private extension LocationManager {
    // MARK: - Private properties
    func setup() {
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.delegate = self
        manager.startUpdatingLocation()
    }
}
