//
//  FullPlayerView.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/1/21.
//

import UIKit

class FullPlayerView: UIViewController {
    //var myView = UIView()
    var playCard:UIView = UIView(){
        didSet {
            view.addSubview(playCard)
            playCard.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding:.init(top: 175, left: 50, bottom: 175, right: 40))
            let backButton = UIButton(type: .system)
            view.addSubview(backButton)
            backButton.anchor(top: nil, leading: playCard.leadingAnchor, bottom: playCard.topAnchor, trailing: nil,padding: .init(top: 0, left: 5, bottom: 0, right: 0))
            backButton.setTitle("Back", for: .normal)
            backButton.titleLabel?.textColor = .systemBlue
            backButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
            backButton.addTarget(self, action: #selector(tappedOutside), for: .touchUpInside)
            let whiteView = UIView()
            view.addSubview(whiteView)
            whiteView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding:.init(top: 144, left: 30, bottom: 144, right: 30))
            whiteView.backgroundColor = .white
            whiteView.layer.cornerRadius = 12
            let leftView = UIView()
            view.addSubview(leftView)
            leftView.anchor(top: whiteView.topAnchor, leading: view.leadingAnchor, bottom: whiteView.bottomAnchor, trailing: whiteView.leadingAnchor)
            let topView = UIView()
            view.addSubview(topView)
            topView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: whiteView.topAnchor, trailing: view.trailingAnchor)
            let rightView = UIView()
            view.addSubview(rightView)
            rightView.anchor(top: whiteView.topAnchor, leading: whiteView.trailingAnchor, bottom: whiteView.bottomAnchor, trailing: view.trailingAnchor)
            let bottomView = UIView()
            view.addSubview(bottomView)
            bottomView.anchor(top: whiteView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
            view.sendSubviewToBack(whiteView)
            let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedOutside))
            let gesture1:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedOutside))
            let gesture2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedOutside))
            let gesture3:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedOutside))
            leftView.isUserInteractionEnabled = true
            leftView.addGestureRecognizer(gesture2)
            rightView.isUserInteractionEnabled = true
            rightView.addGestureRecognizer(gesture3)
            topView.isUserInteractionEnabled = true
            topView.addGestureRecognizer(gesture1)
            bottomView.isUserInteractionEnabled = true
            bottomView.addGestureRecognizer(gesture)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @objc fileprivate func tappedOutside(){
        self.dismiss(animated: true) {
            
        }
    }

}
