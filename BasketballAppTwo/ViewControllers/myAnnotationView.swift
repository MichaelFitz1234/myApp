//
//  myAnnotationView.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/9/21.
//

import UIKit
import MapKit
class myAnnotationView: MKAnnotationView {
    let view = UIButton()
   override init(annotation: MKAnnotation?,
         reuseIdentifier: String?){
    super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    centerOffset = CGPoint(x: 0, y: -20)
    canShowCallout = true
    setupUI()
    view.addTarget(self, action: #selector(selectoHit), for: .touchUpInside)
    }
    @objc func selectoHit(){
        let extraView = UIView()
        extraView.backgroundColor = .white
        addSubview(extraView)
        extraView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: -5, left: -35, bottom: 0, right: 0), size: .init(width: 80, height: 50))
        let myButton = UIButton()
        extraView.addSubview(myButton)
        myButton.anchor(top: nil, leading: nil, bottom: extraView.bottomAnchor, trailing: extraView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 5),size: .init(width: 40, height: 10))
        myButton.setTitle("Accept Challenge", for: .normal)
        myButton.titleLabel?.adjustsFontSizeToFitWidth = true
        myButton.backgroundColor = .systemGray
        let userImage = UIImage(imageLiteralResourceName: "lady4c")
        userImage.withRenderingMode(.alwaysOriginal)
        let user2Image = UIImageView()
        addSubview(user2Image)
        user2Image.image = userImage
        user2Image.anchor(top: extraView.topAnchor, leading: extraView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 3, left: 3, bottom: 0, right: 0),size: .init(width: 30, height: 25))
        let myUsername = UILabel()
        addSubview(myUsername)
        myUsername.anchor(top: extraView.topAnchor, leading: user2Image.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: -13, left: 3, bottom: 0, right: 0),size: .init(width: 40, height: 30))
        myUsername.text = "Michael(1200)"
        //myUsername.sizeToFit()
        myUsername.adjustsFontSizeToFitWidth = true
        let secondUser = UILabel()
        addSubview(secondUser)
        secondUser.anchor(top: myUsername.bottomAnchor, leading: user2Image.trailingAnchor, bottom: myButton.topAnchor, trailing: extraView.trailingAnchor, padding: .init(top: -8, left: 4, bottom: 4, right: 0))
        secondUser.text = "   Date: 05/02/2001 \n    5:30"
        secondUser.numberOfLines = 0
        secondUser.adjustsFontSizeToFitWidth = true
    }
   private func setupUI() {
        backgroundColor = .clear
        view.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        let myImg = UIImage(systemName: "mappin")
        view.setImage(myImg, for: .normal)
        view.tintColor = .red
        addSubview(view)
        view.frame = bounds
      }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
