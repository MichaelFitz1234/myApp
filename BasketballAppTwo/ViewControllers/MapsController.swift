//  MapsController.swift
//  BasketballAppTwo
//  Created by Michael  on 12/30/20.

import UIKit
import MapKit
import CoreLocation
class MapsController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate, UIGestureRecognizerDelegate{
    let ReportScore = UIButton()
    let createChallenge = UIButton()
    var mapView = MKMapView()
    var currentLocationStr = "Current location"
    let locationManager = CLLocationManager()
    //MARK:- ViewController LifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.register(myAnnotationView.self, forAnnotationViewWithReuseIdentifier: "myMap")
        self.locationManager.requestAlwaysAuthorization()

            self.locationManager.requestWhenInUseAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }

            mapView.delegate = self
            mapView.mapType = .standard
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true

            if let coor = mapView.userLocation.location?.coordinate{
                mapView.setCenter(coor, animated: true)
            }
        setupLayout()
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(MapsController.handleLongPress(gestureReconizer:)))
          lpgr.minimumPressDuration = 0.1
          lpgr.delaysTouchesBegan = true
          lpgr.delegate = self
          self.mapView.addGestureRecognizer(lpgr)
       
    }
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
        let touchLocation = gestureReconizer.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation,toCoordinateFrom: mapView)
        print("Tapped at lat: \(locationCoordinate.latitude) long: \(locationCoordinate.longitude)")
            let annotation = MKPointAnnotation()
        annotation.title = "title"
        annotation.subtitle = "subtitle"
        annotation.coordinate = CLLocationCoordinate2D(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        mapView.addAnnotation(annotation)
        return
      }
        if gestureReconizer.state != UIGestureRecognizer.State.began {
        return
      }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        mapView.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
            annotation.coordinate = locValue
            annotation.title = "title"
            annotation.subtitle = "subtitle"
            self.mapView.addAnnotation(annotation)

        //centerMap(locValue)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotatedView1 = mapView.dequeueReusableAnnotationView(withIdentifier: "myMap") as! myAnnotationView
        annotatedView1.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        return annotatedView1
    }
    fileprivate func setupLayout(){
        let myNavigation = NavigationSocialForMap()
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

