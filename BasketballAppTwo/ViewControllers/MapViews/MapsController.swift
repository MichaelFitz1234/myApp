//  MapsController.swift
//  BasketballAppTwo
//  Created by Michael  on 12/30/20.

import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore
import FirebaseAuth
class MapsController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate, UIGestureRecognizerDelegate, NavigationSocialDelegateMap, createAMapChallenge, reportingTourn{
    func myTournament() {
        view.addSubview(myView2)
        myView2.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        myView2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        myView2.backgroundColor = .white
        view.addSubview(centerPin)
        centerPin.image = myImage2
        centerPin.anchor(top: mapView.topAnchor, leading: mapView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: mapView.frame.height/2-92, left: mapView.frame.width/2-50, bottom: 0, right: 0))
        centerPin.heightAnchor.constraint(equalToConstant: 100).isActive = true
        centerPin.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    let myImage2 = UIImage(imageLiteralResourceName: "Trophie")
    let myView2 = createChallengeNav()
    let centerPin = UIImageView()
    let myImage = UIImage(imageLiteralResourceName: "locationYellow-1")
    func addToMap() {
        view.addSubview(myView2)
        myView2.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        myView2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        myView2.backgroundColor = .white
        view.addSubview(centerPin)
        centerPin.image = myImage
        centerPin.anchor(top: mapView.topAnchor, leading: mapView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: mapView.frame.height/2-92, left: mapView.frame.width/2-50, bottom: 0, right: 0))
        centerPin.heightAnchor.constraint(equalToConstant: 100).isActive = true
        centerPin.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    var zoomLevel: Double {
        return log2(360 * ((Double(mapView.frame.size.width) / 256) / mapView.region.span.longitudeDelta)) - 1
    }
    func CreateChallenge() {
        let messagesView = plusButtonHitViewController()
        messagesView.delegate = self
        messagesView.messageType = 6
        present(messagesView, animated: true, completion: nil)
    }
    
    func addATournament() {
        let messagesView = plusButtonHitViewController()
        messagesView.messageType = 5
        present(messagesView, animated: true, completion: nil)
    }
    
    func reportAScore() {
//        let messagesView = reportingTournament()
//        messagesView.delegate = self
//        present(messagesView, animated: true, completion: nil)
        let messagesView = Tournemaents()
        messagesView.modalPresentationStyle = .fullScreen
        present(messagesView, animated: true, completion: nil)
    }
    
    let ReportScore = UIButton()
    let createChallenge = UIButton()
    var mapView = MKMapView()
    var currentLocationStr = "Current location"
    let locationManager = CLLocationManager()
    //MARK:- ViewController LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsrFromFirebase()
        mapView.register(myAnnotationView.self, forAnnotationViewWithReuseIdentifier: "myMap")
        mapView.register(CurrentLocationPin.self, forAnnotationViewWithReuseIdentifier: "myMap2")
        
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
        let pinchGR = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        pinchGR.delegate = self
        self.mapView.addGestureRecognizer(pinchGR)
    }
    @objc func handlePinchGesture(_ sender: UIPinchGestureRecognizer) {
            if sender.state == .ended {
                for annotation in mapView.annotations {
                    if annotation is MKUserLocation {
                        continue
                    }
                    guard let annotationView = self.mapView.view(for: annotation) else { continue }
                    let scale = -1 * sqrt(1 - pow(zoomLevel / 20, 2.0)) + 1.4
                    annotationView.transform = CGAffineTransform(scaleX: CGFloat(scale), y: CGFloat(scale))
                }
            }
        }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
         return true
     }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        mapView.mapType = MKMapType.standard
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        identifer = "myMap"
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        self.mapView.addAnnotation(annotation)
    }
    var identifer = "myMap"
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotatedView1 = mapView.dequeueReusableAnnotationView(withIdentifier: identifer)

        return annotatedView1
    }
    let myNavigation = NavigationSocialForMap()
    fileprivate func getUsrFromFirebase(){
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").getDocument { (snapshot, error) in
            let myData = snapshot?.data()
            let usr = User(dictionary: myData ?? ["":""])
            self.myNavigation.PicImage = usr.imageUrl ?? ""
        }
    }
    fileprivate func setupLayout(){
        myNavigation.delegate = self
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
    


