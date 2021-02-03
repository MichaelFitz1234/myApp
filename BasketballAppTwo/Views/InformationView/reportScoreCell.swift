//
//  reportScoreCell.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/7/21.
//

import UIKit

class reportScoreCell: UITableViewCell {
    let myImg = UIImageView()
    let myImg2 = UIImageView()
    let pointingImage = UIImageView()
    let myLabel = UILabel()
    let myLabel2 = UILabel()
    let myLabel3 = UILabel()
    let gameScore = UILabel()
    let img = UIImage(systemName: "arrow.right")
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        img?.withTintColor(.gray)
        pointingImage.image = img
        myImg.backgroundColor = .gray
        myImg.image?.withRenderingMode(.alwaysOriginal)
        myImg.contentMode = .scaleAspectFill
        myImg.layer.masksToBounds = true
        myImg.layer.cornerRadius = 20
        let backgroundView = UIView()
        addSubview(pointingImage)
        addSubview(myImg)
        addSubview(backgroundView)
        backgroundView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        backgroundView.backgroundColor = .lightGray
        backgroundView.layer.cornerRadius = 10
        pointingImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: backgroundView.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 8), size: .init(width: 18, height: 18))
        myImg.anchor(top: topAnchor, leading: backgroundView.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 15, left: 10, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        addSubview(myImg2)
        myImg2.backgroundColor = .gray
        myImg2.image?.withRenderingMode(.alwaysOriginal)
        myImg2.contentMode = .scaleAspectFill
        myImg2.layer.masksToBounds = true
        myImg2.layer.cornerRadius = 20
        myImg2.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: backgroundView.trailingAnchor,padding: .init(top: 15, left: 0, bottom: 0, right: 18), size: .init(width: 40, height: 40))
        myImg.backgroundColor = .gray
        myImg2.backgroundColor = .gray
    
        addSubview(myLabel)
        addSubview(myLabel2)
        addSubview(myLabel3)
        myLabel.anchor(top: backgroundView.topAnchor, leading: myImg.trailingAnchor, bottom: nil, trailing: myImg2.leadingAnchor,padding: .init(top: 12, left: 0, bottom: 0, right: 0))
        myLabel.textColor = .white
        myLabel.adjustsFontSizeToFitWidth = true
        myLabel.textAlignment = .center
//        myLabel2.anchor(top: backgroundView.topAnchor, leading: nil, bottom: nil, trailing: myImg2.leadingAnchor,padding: .init(top: 12, left: 0, bottom: 0, right: 2))
//        myLabel2.textColor = .white
//        myLabel3.anchor(top: backgroundView.topAnchor, leading: myLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 14, left: 10, bottom: 0, right: 0))
//        myLabel3.text = "Vs."
//        myLabel3.textColor = .white
        addSubview(gameScore)
        gameScore.anchor(top: myLabel.bottomAnchor, leading: myLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 5, left: 55, bottom: 0, right: 0))
        // set the text from the data model
        // set label Attribute
        sendSubviewToBack(backgroundView)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
