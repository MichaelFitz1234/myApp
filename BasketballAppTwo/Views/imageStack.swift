//
//  imageStack.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/12/20.
//

import UIKit

class imageStack: UIView {
    let profileImageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "lady4c"))
    let usernameLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.2550676465, green: 0.2552897036, blue: 0.2551020384, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = "Lebron James"
        return label
    }()
    let spaceFromTop = 20
    let spaceFromLeft = 20
    let size = 20
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        profileImageView.image?.withRenderingMode(.alwaysOriginal)
        profileImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 20, bottom: 0, right: 0), size: .init(width: 80, height: 80))
       addSubview(usernameLabel)
       usernameLabel.anchor(top: topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 70, left: 10, bottom: 0, right: 0))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    }

