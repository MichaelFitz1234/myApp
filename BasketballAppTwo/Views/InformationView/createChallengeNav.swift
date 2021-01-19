//
//  createChallengeNav.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/12/21.
//

import UIKit

class createChallengeNav: UIView {
    let cancel = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        let backLabel = UIButton()
        addSubview(backLabel)
        backLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 20, bottom: 0, right: 0),size: .init(width: 50, height: 30))
        backLabel.titleLabel?.font = .systemFont(ofSize: 15)
        backLabel.setTitle("Back", for: .normal)
        backLabel.setTitleColor(.systemBlue, for: .normal)
        addSubview(cancel)
        cancel.anchor(top: backLabel.bottomAnchor, leading: backLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 3, left: 8, bottom: 0, right: 0),size: .init(width: 50, height: 30))
        cancel.titleLabel?.font = .systemFont(ofSize: 15)
        cancel.setTitle("Cancel", for: .normal)
        cancel.setTitleColor(.systemBlue, for: .normal)
        let backLabel2 = UIButton()
        addSubview(backLabel2)
        backLabel2.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 25, left: 0, bottom: 0, right: 10),size: .init(width: 120, height: 50))
        backLabel2.titleLabel?.font = .systemFont(ofSize: 15)
        backLabel2.setTitle("Finish Challenge", for: .normal)
        backLabel2.setTitleColor(.systemBlue, for: .normal)
        let profilePic = UIImageView()
        addSubview(profilePic)
        profilePic.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: backLabel2.leadingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 50),size: .init(width: 50, height: 50))
        profilePic.backgroundColor = .gray
        profilePic.layer.cornerRadius = 25
        profilePic.clipsToBounds = true
        profilePic.image?.withRenderingMode(.alwaysOriginal)
        profilePic.contentMode = .scaleAspectFill
        profilePic.backgroundColor = .gray
        let img = UIImage(systemName: "arrow.left")
        let myArrowImg = UIImageView()
        addSubview(myArrowImg)
        myArrowImg.anchor(top: backLabel.topAnchor, leading: backLabel.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 7.5, left: -10, bottom: 0, right: 0), size: .init(width: 15, height: 15))
        myArrowImg.image = img
        let img2 = UIImage(systemName: "arrow.right")
        let myArrowImg2 = UIImageView()
        addSubview(myArrowImg2)
        myArrowImg2.anchor(top: backLabel2.bottomAnchor, leading: nil, bottom: nil, trailing: backLabel2.trailingAnchor, padding: .init(top: -15, left: 0, bottom: 0, right: 7), size: .init(width: 20, height: 20))
        myArrowImg2.image = img2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
