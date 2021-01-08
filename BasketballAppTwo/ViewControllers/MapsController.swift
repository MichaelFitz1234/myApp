//  MapsController.swift
//  BasketballAppTwo
//  Created by Michael  on 12/30/20.

import UIKit
import MapKit
import CoreLocation
class MapsController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    let ReportScore = UIButton()
    let createChallenge = UIButton()
    var locationManager: CLLocationManager!
    var mapView = MKMapView()
    override func viewDidLoad() {
        super.viewDidLoad()
          locationManager = CLLocationManager()
          locationManager.delegate = self
          locationManager.desiredAccuracy = kCLLocationAccuracyBest
          locationManager.requestAlwaysAuthorization()
          locationManager.startUpdatingLocation()
    }
    override func viewDidAppear(_ animated: Bool) {
        setupLayout()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        {
            let location = locations.last! as CLLocation

            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

            self.mapView.setRegion(region, animated: true)
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    fileprivate func setupLayout(){
        
        let myNavigation = UIView()
        view.addSubview(myNavigation)
        myNavigation.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        myNavigation.heightAnchor.constraint(equalToConstant: 100).isActive = true
        myNavigation.backgroundColor = .white
        view.addSubview(mapView)
        mapView.anchor(top: myNavigation.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.center = view.center
        view.addSubview(mapView)
    }
}
