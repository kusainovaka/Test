//
//  LocationVIewController.swift
//  Test
//
//  Created by Kamila on 11.02.2019.
//  Copyright © 2019 Kamila Kusainova. All rights reserved.
//

import UIKit
import CoreLocation

class LocationVIewController: UIViewController {
    
    var locationManager: CLLocationManager
    var userLocation: CLLocation?
    
    init(locationProvider: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
    func requestUserLocation() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension LocationVIewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
        manager.stopUpdatingLocation()
    }
}
