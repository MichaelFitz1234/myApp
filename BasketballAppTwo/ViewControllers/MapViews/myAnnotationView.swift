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
    centerOffset = CGPoint(x: 0, y: -40)
    canShowCallout = true
    setupUI()
    view.addTarget(self, action: #selector(selectoHit), for: .touchUpInside)
    }
    @objc func selectoHit(){
        let extraView = UIView()
        extraView.backgroundColor = .white
        addSubview(extraView)
        extraView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: -105, left: -23, bottom: 0, right: 0), size: .init(width: 140, height: 100))
        extraView.layer.borderColor = .init(gray: 80, alpha: 1)
        extraView.layer.borderWidth = 3
        extraView.layer.cornerRadius = 6
        let img = UIImage(systemName: "arrowtriangle.down.fill")
        let downArrowImgView = UIImageView()
        downArrowImgView.image = img
        addSubview(downArrowImgView)
        downArrowImgView.anchor(top: nil, leading: extraView.leadingAnchor, bottom: extraView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 46, bottom: -18, right: 0),size: .init(width: 50, height: 40))
        downArrowImgView.tintColor = .systemGray2
        let myBlackView = UIView()
        addSubview(myBlackView)
        myBlackView.anchor(top: extraView.topAnchor, leading: extraView.leadingAnchor, bottom: nil, trailing: extraView.trailingAnchor)
        myBlackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myBlackView.backgroundColor = .black
        myBlackView.layer.cornerRadius = 6
        myBlackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let playerImg = UIImageView()
        addSubview(playerImg)
        playerImg.anchor(top: extraView.topAnchor, leading: extraView.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 25, left: 55, bottom: 0, right: 0),size: .init(width: 30, height: 30))
        playerImg.backgroundColor = .gray
        playerImg.layer.cornerRadius = 15
        sendSubviewToBack(downArrowImgView)
        let acceptChallengeButton = UIButton()
        addSubview(acceptChallengeButton)
        acceptChallengeButton.anchor(top: nil, leading: nil, bottom: extraView.bottomAnchor, trailing: extraView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 5, right: 5),size: .init(width: 50, height: 25))
        acceptChallengeButton.addTarget(self, action: #selector(showTourni), for: .touchUpInside)
        acceptChallengeButton.setTitle("Accept", for: .normal)
        acceptChallengeButton.backgroundColor = .systemGray
        acceptChallengeButton.setTitleColor(.white, for: .normal)
        acceptChallengeButton.titleLabel?.adjustsFontSizeToFitWidth = true
        acceptChallengeButton.layer.cornerRadius = 3
        acceptChallengeButton.titleLabel?.fillSuperview(padding: .init(top: 1, left: 2, bottom: 0, right: 2))
        let DateLabel = UILabel()
        addSubview(DateLabel)
        DateLabel.anchor(top: nil, leading: extraView.leadingAnchor, bottom: extraView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 3, bottom: 1, right: 0),size: .init(width: 65, height: 45))
        DateLabel.text = "01/20/21 \nTime: 4:30"
        DateLabel.numberOfLines = 0
        DateLabel.textColor = .black
        DateLabel.adjustsFontSizeToFitWidth = true
        let myUsrName = UILabel()
        addSubview(myUsrName)
        myUsrName.anchor(top: extraView.topAnchor, leading: playerImg.leadingAnchor, bottom: playerImg.topAnchor, trailing: nil,padding: .init(top: 0, left: -10, bottom: 2, right: 0))
        myUsrName.widthAnchor.constraint(equalToConstant: 70).isActive = true
        myUsrName.text = "Michael(1200)"
        myUsrName.textColor = .white
        myUsrName.font = .boldSystemFont(ofSize: 12)
        myUsrName.adjustsFontSizeToFitWidth = true
    }
   private func setupUI() {
        backgroundColor = .clear
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        let myImg = UIImage(imageLiteralResourceName: "locationYellow-1")
        view.setImage(myImg, for: .normal)
        view.tintColor = .red
        addSubview(view)
        view.frame = bounds
      }
    @objc func showTourni(){
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
