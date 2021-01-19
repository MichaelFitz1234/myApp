//
//  ViewScore.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/10/21.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
class ViewScore: UIViewController {
    let numberValue = UILabel()
    let stackView = UIStackView()
    let screenSize: CGRect = UIScreen.main.bounds
    let currentUsrImg = UIImageView()
    let nextUsrImg = UIImageView()
    var uid = ""
    var userUID = ""
    var username1 = ""
    var username2 = ""
    var currentUsr1 = ""
    var p1Elo = 0
    var p2Elo = 0
    var myGame = GameScore(dictionary: ["":""])
    lazy var screenWidth = screenSize.width
     func setupMyUserFromFirebase(){
        let myUser = uid
        let docRef = Firestore.firestore().collection("users").document(myUser)
        docRef.getDocument { (snapshot, error) in
            let myImage = snapshot?.get("imagePath") as! String
            let myData = snapshot?.get("username") as! String
            //self.p2Elo = snapshot?.get("currElo") as! Int
            self.username2 = myData
            let storageRef = Storage.storage().reference(withPath: myImage)
            storageRef.getData(maxSize: 4*1024*1024) { [self] (data, error) in
            if let error = error{
            print("Got an error fetching data: \(error.localizedDescription)")
                return
                }else{
            if let data = data{
                self.currentUsrImg.image = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "Image")
                createInitialValue(myGameScore: myGame)
                        }
                    }
                }
        }
        let myUser2 = userUID
        self.currentUsr1 = myUser2
        let docRef2 = Firestore.firestore().collection("users").document(myUser2)
        docRef2.getDocument { (snapshot, error) in
            let myImage = snapshot?.get("imagePath") as! String
            let myData = snapshot?.get("username") as! String
            //self.p1Elo = snapshot?.get("currElo") as! Int
            self.username1 = myData
            let storageRef = Storage.storage().reference(withPath: myImage)
            storageRef.getData(maxSize: 4*1024*1024) { [self] (data, error) in
            if let error = error{
            print("Got an error fetching data: \(error.localizedDescription)")
                return
                }else{
            if let data = data{
                self.nextUsrImg.image = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "Image")
                        }
                    }
                }
        }
    }
    func setupLayout() {
        let navigationView = UIView()
        view.backgroundColor = .white
        view.addSubview(navigationView)
        navigationView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        navigationView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        let myView2 = UIView()
        view.addSubview(myView2)
        myView2.anchor(top: nil, leading: view.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: view.trailingAnchor)
        myView2.heightAnchor.constraint(equalToConstant: 3).isActive = true
        myView2.backgroundColor = .systemGray6
        let myImg = UIImage(systemName: "arrow.left")
        let backArrow = UIButton()
        backArrow.setImage(myImg, for: .normal)
        backArrow.addTarget(self, action: #selector(backHit), for: .touchUpInside)
        navigationView.addSubview(backArrow)
        backArrow.anchor(top: nil, leading: view.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 15, bottom: 35, right: 0),size: .init(width: 20, height: 20))
        navigationView.addSubview(currentUsrImg)
        currentUsrImg.image?.withRenderingMode(.alwaysOriginal)
        currentUsrImg.layer.cornerRadius = 20
        navigationView.addSubview(nextUsrImg)
        currentUsrImg.anchor(top: nil, leading: view.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: screenWidth/3, bottom: 30, right: 0), size: .init(width: 40, height: 40))
        let myLabel = UILabel()
        navigationView.addSubview(myLabel)
        myLabel.text = "Vs."
        myLabel.anchor(top: nil, leading: currentUsrImg.trailingAnchor, bottom: navigationView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 13, bottom: 35, right: 0))
        nextUsrImg.image?.withRenderingMode(.alwaysOriginal)
        nextUsrImg.contentMode = .scaleAspectFill
        nextUsrImg.layer.cornerRadius = 20
        nextUsrImg.anchor(top: nil, leading: myLabel.trailingAnchor, bottom: navigationView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 30, right: 0),size: .init(width: 40, height: 40))
        nextUsrImg.backgroundColor = .gray
        let numberOfGames = UILabel()
        numberOfGames.text = "Number of game played:"
        view.addSubview(numberOfGames)
        numberOfGames.anchor(top: navigationView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: screenWidth/4, bottom: 0, right: 0))
        view.addSubview(numberValue)
        numberValue.anchor(top: numberOfGames.bottomAnchor, leading: nil, bottom: nil, trailing: numberOfGames.trailingAnchor,padding: .init(top: 3, left: 0, bottom: 0, right: 80))
        numberValue.text = String(myGame.Player1Score?.count ?? 1)
        stackView.axis = .vertical
        stackView.isUserInteractionEnabled = true
        let Scrollview = UIScrollView()
        view.addSubview(Scrollview)
        Scrollview.isUserInteractionEnabled = true
        Scrollview.anchor(top: numberOfGames.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        Scrollview.addSubview(stackView)
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.anchor(top: Scrollview.topAnchor, leading: Scrollview.leadingAnchor, bottom: Scrollview.bottomAnchor, trailing: Scrollview.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    func createInitialValue(myGameScore: GameScore){
     var myCount = 0
        myGameScore.Player1Score?.forEach({ (score) in
            let reportCell = viewScoreStackCell()
            reportCell.username.text = username2
            reportCell.username2.text = username1
            reportCell.scoreValue = count
            reportCell.score1.text = String(score)
            reportCell.score2.text = String(myGameScore.Playet2Score?[myCount] ?? 0)
            reportCell.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
            reportCell.isUserInteractionEnabled = true
            myCount = myCount+1
            reportCell.setupLayout()
            count = count + 1
            stackView.addArrangedSubview(reportCell)
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nextUsrImg.clipsToBounds = true
        currentUsrImg.clipsToBounds = true
        setupLayout()
    }
    var count = 1
    var previousNumberValue = 1
    @objc fileprivate func backHit(){
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false) {
          
        }
    }
}
