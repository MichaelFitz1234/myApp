//
//  MessagesCellTableViewCell.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/20/20.
//

import UIKit

class MessagesCellTableViewCell: UITableViewCell {
    let messageLabel = UILabel()
    let bubble = UIView()
    var constraint1: NSLayoutConstraint!
    var constraint2: NSLayoutConstraint!
    var isIncomming: Bool!{
        didSet{
            bubble.backgroundColor = isIncomming ? .systemGray6 : #colorLiteral(red: 0.2463077911, green: 0.5624732449, blue: 0.9200288955, alpha: 1)
            messageLabel.textColor = isIncomming ? .black : .white
            constraint1.isActive = isIncomming ? true : false
            constraint2.isActive = isIncomming ? false : true
            //constraint1.isActive = false
            //constraint2.isActive = true
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        bubble.backgroundColor = .systemGray6
        bubble.layer.cornerRadius = 9
        bubble.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bubble)
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        let constriants = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
                           messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
                           messageLabel.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: 0.55),
                           bubble.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
                           bubble.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -5),
                           bubble.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 10),
                           bubble.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(constriants)
        constraint1 = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        constraint1.isActive = true
        constraint2 = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        constraint2.isActive = false

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
