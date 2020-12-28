//
//  AddMessageCell.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/27/20.
//

import UIKit

class AddMessageCell: UITableViewCell {
    let myImg = UIImageView()
    let myLabel = UILabel()
    let pointingImage = UIImageView()
    let img = UIImage(systemName: "plus.message")
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        img?.withTintColor(.gray)
        pointingImage.image = img
        myLabel.backgroundColor = .white
        myImg.backgroundColor = .gray
        myImg.image?.withRenderingMode(.alwaysOriginal)
        myImg.contentMode = .scaleAspectFill
        myImg.layer.masksToBounds = true
        myImg.layer.cornerRadius = 20
        addSubview(myImg)
        addSubview(myLabel)
        addSubview(pointingImage)
        pointingImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 10, bottom: 0, right: 8), size: .init(width: 30, height: 30))
        myImg.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 12, left: 15, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        myLabel.anchor(top: topAnchor, leading: myImg.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 4, bottom: 0, right: 0))
        myLabel.textColor = .systemGray2
        myLabel.font = .systemFont(ofSize: 13, weight: UIFont.Weight(rawValue: 10))

}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        }
    }
