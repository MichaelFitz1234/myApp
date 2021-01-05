//  MapsController.swift
//  BasketballAppTwo
//  Created by Michael  on 12/30/20.

import UIKit
import MapKit
class MapsController: UIViewController, MKMapViewDelegate{
    let ReportScore = UIButton()
    let createChallenge = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
    }
    fileprivate func setupLayout(){
        let mapView = MKMapView()
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.height
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.center = view.center
        view.addSubview(mapView)
    }
}
