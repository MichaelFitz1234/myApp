//
//  SearchForUsers.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/24/21.
//

import UIKit
import FirebaseStorage
class SearchForUsers: UITableViewCell {
    //this creates the cell for the search
    var myPath: String?{
        didSet{
            let storageRef = Storage.storage().reference(withPath: myPath ?? "")
            storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
                if let error = error{
                    print("Got an error fetching data: \(error.localizedDescription)")
                    return
                }else{
                    if let data = data{
                        self.myImg.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    let myImg = UIImageView()
    let myLabel = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        myLabel.backgroundColor = .white
        myImg.backgroundColor = .gray
        myImg.image?.withRenderingMode(.alwaysOriginal)
        myImg.contentMode = .scaleAspectFill
        myImg.layer.masksToBounds = true
        myImg.layer.cornerRadius = 20
        addSubview(myImg)
        addSubview(myLabel)
        myImg.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        myLabel.anchor(top: topAnchor, leading: myImg.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 4, bottom: 0, right: 0))
        myLabel.textColor = .systemGray2
        myLabel.font = .systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 10))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
