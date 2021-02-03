//
//  ContactsCell.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/25/20.
//

import UIKit
import FirebaseStorage
class ContactsCell: UITableViewCell {
    var myImgPath = ""{
        didSet{
            let storageRef = Storage.storage().reference(withPath: myImgPath)
            storageRef.getData(maxSize: 4*1024*1024) { [weak self](data, error) in
            if let error = error{
            print("Got an error fetching data: \(error.localizedDescription)")
                return
                }else{
            if let data = data{
                self?.myImg.image = UIImage(data: data)
                }
            }
        }
        }
    }
    let myImg = UIImageView()
    let myLabel = UILabel()
    let recentMsgs = UILabel()
    let timeStamp = UILabel()
    let pointingImage = UIImageView()
    let img = UIImage(systemName: "arrow.right")
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
        addSubview(recentMsgs)
        addSubview(timeStamp)
        myImg.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        recentMsgs.anchor(top: myLabel.bottomAnchor, leading: myImg.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 4, left: 3, bottom: 8, right: 0))
        recentMsgs.textColor = .gray
        recentMsgs.font = .systemFont(ofSize: 11, weight: UIFont.Weight(rawValue: 8))
        pointingImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 8), size: .init(width: 18, height: 18))
        timeStamp.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: pointingImage.leadingAnchor, padding: .init(top: 6, left: 0, bottom: 0, right: 2))
        timeStamp.font = .italicSystemFont(ofSize: 11)
        timeStamp.textColor = .gray
    
        myLabel.anchor(top: topAnchor, leading: myImg.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 11, left: 4, bottom: 0, right: 0))
        myLabel.textColor = .systemGray2
        myLabel.font = .systemFont(ofSize: 13, weight: UIFont.Weight(rawValue: 10))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
