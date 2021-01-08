//
//  InfoRight2.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/7/21.
//

import UIKit

class InfoRight2: UIView {
    let Record = UITextField()
    let HeighestRecordedwin = UITextField()
    let Height = UITextField()
    let Age = UITextField()
    let Description = UITextField()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(Record)
        Record.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 0, right: 0))
        Record.heightAnchor.constraint(equalToConstant: 20).isActive = true
        Record.font = .systemFont(ofSize: 15)
        Record.textColor = .systemBlue
        Record.placeholder = "Record W/L: 20-10"
        addSubview(HeighestRecordedwin)
        HeighestRecordedwin.anchor(top: Record.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 0))
        HeighestRecordedwin.heightAnchor.constraint(equalToConstant: 20).isActive = true
        HeighestRecordedwin.font = .systemFont(ofSize: 15)
        HeighestRecordedwin.textColor = .systemBlue
        HeighestRecordedwin.placeholder = "Signature Win: 1200"
        addSubview(Height)
        Height.anchor(top: HeighestRecordedwin.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 0))
        Height.heightAnchor.constraint(equalToConstant: 20).isActive = true
        Height.font = .systemFont(ofSize: 15)
        Height.textColor = .black
        Height.placeholder = "Height: 6ft"
        addSubview(Age)
        Age.anchor(top: Height.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 0))
        Age.heightAnchor.constraint(equalToConstant: 20).isActive = true
        Age.font = .systemFont(ofSize: 15)
        Age.textColor = .systemBlue
        Age.text = "Age: 19"
        addSubview(Description)
        Description.anchor(top: Age.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 0))
        //Age.heightAnchor.constraint(equalToConstant: 80).isActive = true
        Description.font = .systemFont(ofSize: 15)
        Description.textColor = .systemBlue
//        Description.lineBreakMode = .byWordWrapping
//        Description.numberOfLines = 0
        Description.placeholder = "Playstyle: Agressive baseline player who loves to drive to the basket. Good three point shooter can sometime make if from deep"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
