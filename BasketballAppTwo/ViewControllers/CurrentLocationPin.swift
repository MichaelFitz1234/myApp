//
//  CurrentLocationPin.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/12/21.
//

import UIKit
import MapKit
class CurrentLocationPin: MKAnnotationView {
    let view = UIButton()
   override init(annotation: MKAnnotation?,
         reuseIdentifier: String?){
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    centerOffset = CGPoint(x: 0, y: 0)
    canShowCallout = true
    setupUI()
   }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   private func setupUI() {
        backgroundColor = .clear
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        let myImg = UIImage(imageLiteralResourceName: "locationImg")
        view.setImage(myImg, for: .normal)
        addSubview(view)
        view.frame = bounds
      }
}
