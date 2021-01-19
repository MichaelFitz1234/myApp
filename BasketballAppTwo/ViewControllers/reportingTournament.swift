//
//  reportingTournament.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/13/21.
//

import UIKit
protocol reportingTourn {
    func myTournament()
}
class reportingTournament: UIViewController {
    fileprivate lazy var screenSize =   UIScreen.main.bounds
    fileprivate lazy var ScreenWidth =  screenSize.width
    fileprivate lazy var ScreenHeight = screenSize.height
    let myView = UIView()
    let centerPin = UIImageView()
    let myImage = UIImage(imageLiteralResourceName: "locationBlue")
    var delegate: reportingTourn?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myView)
        myView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        myView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        myView.backgroundColor = .systemGray6
        view.backgroundColor = .white
        let myText = UILabel()
        view.addSubview(myText)
        myText.text = "Select Tournament Type"
        myText.anchor(top: myView.topAnchor, leading: myView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: ScreenWidth/7, bottom: 0, right: 0))
        myText.font = .boldSystemFont(ofSize: 25)
        let privateChallenge = UIButton(type: .system)
        let publicChallenge = UIButton(type: .system)
        view.addSubview(privateChallenge)
        view.addSubview(publicChallenge)
        privateChallenge.anchor(top: myView.bottomAnchor, leading: myView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: ScreenHeight/5, left: ScreenWidth/8, bottom: 0, right: 0), size: .init(width: 300, height: 80))
        privateChallenge.backgroundColor = .systemGray4
        privateChallenge.layer.cornerRadius = 10
        publicChallenge.anchor(top: privateChallenge.bottomAnchor, leading: privateChallenge.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 300, height: 80))
        publicChallenge.backgroundColor = .systemGray4
        publicChallenge.layer.cornerRadius = 10
        privateChallenge.setTitle("Friends", for: .normal)
        publicChallenge.setTitle("Public", for: .normal)
        privateChallenge.setTitleColor(.white, for: .normal)
        privateChallenge.titleLabel?.font = .systemFont(ofSize: 18)
        publicChallenge.setTitleColor(.white, for: .normal)
        publicChallenge.titleLabel?.font = .systemFont(ofSize: 18)
        privateChallenge.addTarget(self, action: #selector(publicHit), for: .touchUpInside)
        publicChallenge.addTarget(self, action: #selector(privateHit), for: .touchUpInside)
    }
    @objc func privateHit(){
        let nextView = UIView()
        view.addSubview(nextView)
        nextView.anchor(top: myView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 100, left: 0, bottom: 0, right: 0))
        nextView.backgroundColor = .white
        let fiveBucks = UIButton(type: .system)
        let tenBucks = UIButton(type: .system)
        let fifteenBucks = UIButton(type: .system)
        view.addSubview(fiveBucks)
        view.addSubview(tenBucks)
        view.addSubview(fifteenBucks)
        fiveBucks.anchor(top: myView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: ScreenHeight/7, left: ScreenWidth/8, bottom: 0, right: 0), size: .init(width: 300, height: 80))
        fiveBucks.backgroundColor = .systemGray4
        fiveBucks.layer.cornerRadius = 10
        fiveBucks.setTitle("$5 entrence fee winner gets $30", for: .normal)
        fiveBucks.setTitleColor(.white, for: .normal)
        tenBucks.anchor(top: fiveBucks.bottomAnchor, leading: fiveBucks.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 300, height: 80))
        tenBucks.setTitle("$10 entrence fee winner gets $60", for: .normal)
        tenBucks.setTitleColor(.white, for: .normal)
        tenBucks.backgroundColor = .systemGray4
        tenBucks.layer.cornerRadius = 10
        fifteenBucks.anchor(top: tenBucks.bottomAnchor, leading: tenBucks.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 300, height: 80))
        fifteenBucks.setTitle("$15 entrence fee winner gets $90", for: .normal)
        fifteenBucks.setTitleColor(.white, for: .normal)
        fifteenBucks.backgroundColor = .systemGray4
        fifteenBucks.layer.cornerRadius = 10
        fiveBucks.addTarget(self, action: #selector(placePin), for: .touchUpInside)
        tenBucks.addTarget(self, action: #selector(placePin), for: .touchUpInside)
        fifteenBucks.addTarget(self, action: #selector(placePin), for: .touchUpInside)
    }
    @objc func placePin(){
        self.delegate?.myTournament()
        self.dismiss(animated: true) {
        }
    }
    
    @objc func publicHit(){
        let messagesView = plusButtonHitViewController()
        messagesView.messageType = 6
        present(messagesView, animated: true, completion: nil)
    }

}
