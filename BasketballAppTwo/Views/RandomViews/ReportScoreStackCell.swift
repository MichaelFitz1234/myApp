//
//  ReportScoreStackCell.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/5/21.
//

import UIKit

class ReportScoreStackCell: UIView, UITextFieldDelegate {
    let score2 = UITextField()
    let score1 = UITextField()
    let game = UILabel()
    let username = UILabel()
    let username2 = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        score2.delegate = self
        score1.delegate = self
        score1.keyboardType = .numberPad
        score2.keyboardType = .numberPad
    }
    var scoreValue = 0{
        didSet{
          game.text = "Game \(scoreValue)"
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let screenSize = UIScreen.main.bounds
    func setupLayout(){
    heightAnchor.constraint(equalToConstant: 150).isActive = true
    let scoringLabel = UILabel()
    addSubview(scoringLabel)
    scoringLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
    scoringLabel.text = "Score:"
    addSubview(game)
    addSubview(username)
    username.anchor(top: scoringLabel.bottomAnchor, leading: scoringLabel.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 10, bottom: 0, right: 0))
    game.anchor(top: scoringLabel.topAnchor, leading: username.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 30, bottom: 0, right: 0))
    game.font = .boldSystemFont(ofSize: 16)
    addSubview(username2)
        username2.anchor(top: scoringLabel.bottomAnchor, leading: game.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 10, bottom: 0, right:0))
    addSubview(score1)
    score1.allowsEditingTextAttributes = true
    score1.isEnabled = true
    score1.anchor(top: username.bottomAnchor, leading: username.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0),size: .init(width: 40, height: 25))
    score1.backgroundColor = .systemGray5
    score1.layer.cornerRadius = 7
    addSubview(score2)
    score2.isEnabled = true
    score2.anchor(top: username2.bottomAnchor, leading: username2.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0),size: .init(width: 40, height: 25))
    score2.backgroundColor = .systemGray5
    score2.layer.cornerRadius = 7
    let divider = UIView()
    addSubview(divider)
    divider.anchor(top: score1.bottomAnchor, leading: username.leadingAnchor, bottom: nil, trailing: username2.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
    divider.heightAnchor.constraint(equalToConstant: 3).isActive = true
    divider.backgroundColor = .systemGray6
    }
 
}
