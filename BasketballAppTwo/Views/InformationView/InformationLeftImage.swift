//
//  InformationLeftImage.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/5/20.
//

import UIKit

class InformationLeftImage: UIImageView {
    let Username = UILabel()
    let ELo = UILabel()
    override init(image: UIImage?) {
        super.init(image: image)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupLayout(){
        image = #imageLiteral(resourceName: "BballPlayer").withRenderingMode(.alwaysOriginal)
        contentMode = .scaleToFill
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = true
        addSubview(Username)
        Username.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 10, bottom: 0, right: 0))
        Username.heightAnchor.constraint(equalToConstant: 18).isActive = true
        Username.text = "Michael"
        Username.font = .systemFont(ofSize: 18, weight: .bold)
        Username.textColor = .white
        addSubview(ELo)
        ELo.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 10, right: 0))
        ELo.heightAnchor.constraint(equalToConstant: 18).isActive = true
        ELo.text = "1200"
        ELo.font = .systemFont(ofSize: 18, weight: .bold)
        ELo.textColor = .white

    }
}
