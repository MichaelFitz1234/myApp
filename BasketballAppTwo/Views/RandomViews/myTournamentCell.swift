//
//  myTournamentCell.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/13/21.
//

import UIKit

class myTournamentCell: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        let line = UIView()
        addSubview(line)
        line.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor,padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        line.heightAnchor.constraint(equalToConstant: 3).isActive = true
        line.backgroundColor = .black
        let line2 = UIView()
        addSubview(line2)
        line2.anchor(top: line.bottomAnchor, leading: line.trailingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: -3, left: 0, bottom: 5, right: 5))
        line2.widthAnchor.constraint(equalToConstant: 3).isActive = true
        line2.backgroundColor = .black
        let line3 = UIView()
        addSubview(line3)
        line3.anchor(top: line2.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: line2.leadingAnchor, padding: .init(top: 0, left: 5, bottom: 0, right: -3))
        line3.heightAnchor.constraint(equalToConstant: 3).isActive = true
        line3.backgroundColor = .black
        let profilePic = UIImageView()
        addSubview(profilePic)
        profilePic.anchor(top: nil, leading: line.leadingAnchor, bottom: line.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 3, bottom: 5, right: 0),size: .init(width: 30, height: 30))
        profilePic.backgroundColor = .gray
        profilePic.layer.cornerRadius = 15
        profilePic.clipsToBounds = true
        profilePic.image?.withRenderingMode(.alwaysOriginal)
        profilePic.contentMode = .scaleAspectFill
        profilePic.backgroundColor = .gray
        let username1 = UILabel()
        addSubview(username1)
        username1.anchor(top: nil, leading: profilePic.trailingAnchor, bottom: profilePic.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 3, bottom: 2, right: 0), size: .init(width: 50, height: 30))
        username1.text = "Michael"
        username1.adjustsFontSizeToFitWidth = true
        let profilePic2 = UIImageView()
        addSubview(profilePic2)
        profilePic2.anchor(top: nil, leading: line3.leadingAnchor, bottom: line3.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 3, bottom: 5, right: 0),size: .init(width: 30, height: 30))
        profilePic2.backgroundColor = .gray
        profilePic2.layer.cornerRadius = 15
        profilePic2.clipsToBounds = true
        profilePic2.image?.withRenderingMode(.alwaysOriginal)
        profilePic2.contentMode = .scaleAspectFill
        profilePic2.backgroundColor = .gray
        let username2 = UILabel()
        addSubview(username2)
        username2.anchor(top: nil, leading: profilePic2.trailingAnchor, bottom: profilePic2.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 3, bottom: 2, right: 0), size: .init(width: 50, height: 30))
        username2.text = "Rachael"
        username2.adjustsFontSizeToFitWidth = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
