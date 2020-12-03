//
//  homePage.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 11/13/20.
//

import UIKit
import Firebase
import SDWebImage
import JGProgressHUD

class homePage: UIViewController, CardViewDelegate {
    let searchBarView = UIView()
    fileprivate var myView = UIView()
   //let users = [User(name: "Michael", age: 25, Elo: 1200, imageName: #imageLiteral(resourceName: "BballPlayer")), User(name: "Rachael", age: 33, Elo: 1100, imageName: #imageLiteral(resourceName: "shootingImageInitialPage")), User(name: "Eli", age: 22, Elo: 1500, imageName: #imageLiteral(resourceName: "shootingImageInitialPage")), User(name: "Kelly", age: 22, Elo: 1500, imageName: #imageLiteral(resourceName: "Image-1")),User(name: "Lady", age: 22, Elo: 1500, imageName: #imageLiteral(resourceName: "bbal1"))]
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLayout()
        getUsersFromFiresbase()
    }
    var lastAddedPointer: CardView?
    var cardDeckHead: CardView?
    var nextCardInstantiation: CardView?
    var tempTwo: CardView?
    fileprivate func addUser(CardView : CardView){
       let myNewNode = CardView
        if cardDeckHead == nil{
            cardDeckHead = myNewNode
            lastAddedPointer = myNewNode
            lastAddedPointer?.nextCard = nil
        }else{
            lastAddedPointer?.nextCard = myNewNode
            lastAddedPointer = myNewNode
            lastAddedPointer?.nextCard = nil
        }
    }
    let fillerUIView = UIView()
    let dummycard = CardView()
    var users = [User]()
    
    fileprivate func CardViewFromUser(user: User) -> CardView{
        let myDate = NSDate()
        let cardDeckView = CardView()
        cardDeckView.locationUsername.text = "\(user.Username ?? "")  \(user.age ?? myDate) \n 22 miles away"
        cardDeckView.Elo.text = " \(user.Elo ?? 5) \n Some Ranking"
        cardDeckView.imageUrl = user.imageUrl ?? ""
        return cardDeckView
    }
    fileprivate func getUsersFromFiresbase(){
        let query = Firestore.firestore().collection("users")
        query.getDocuments { (snapshot, err) in
            if let err = err{
              print("this is the", err)
              return
            }else{
                let registeringHUD = JGProgressHUD(style: .dark)
                registeringHUD.textLabel.text = "Fetching Users"
                registeringHUD.show(in: self.view)
                snapshot?.documents.forEach({ (documentSnapshot) in
                    let myUserInfo = documentSnapshot.data()
                    let user = User(dictionary: myUserInfo)
                    let cardDeckView = self.CardViewFromUser(user: user)
                    self.addUser(CardView: cardDeckView)
                })
                self.myView.addSubview(self.cardDeckHead ?? self.fillerUIView)
                self.myView.sendSubviewToBack(self.cardDeckHead ?? self.fillerUIView)
                self.cardDeckHead?.fillSuperview()
                self.cardDeckHead?.delegate = self
                self.cardDeckHead?.nextCardSetup()
                self.myView.addSubview(self.cardDeckHead?.nextCard ?? self.dummycard)
                self.myView.sendSubviewToBack(self.cardDeckHead?.nextCard ?? self.dummycard)
                self.cardDeckHead?.nextCard?.fillSuperview()
                registeringHUD.dismiss()
            }
        }
       
    }

    func protocolForGettingTarget() -> CardView {
        return nextCardInstantiation!
    }
    fileprivate lazy var screenSize = UIScreen.main.bounds
    fileprivate lazy var ScreenWidth = ((screenSize.width)+20)
    func nextCardRight(translation: CGFloat) {
        let duration = 0.3
        let translationAnimation = CABasicAnimation(keyPath: "position.x")
        translationAnimation.toValue = -ScreenWidth
        translationAnimation.duration = duration
        translationAnimation.fillMode = .forwards
        translationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        translationAnimation.isRemovedOnCompletion = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            self.cardDeckHead?.nextCard?.transform = .identity
        })
        cardDeckHead?.layer.add(translationAnimation, forKey: "translation")
        CATransaction.setCompletionBlock {
            let temp = self.cardDeckHead
            temp?.transform = .identity
            self.cardDeckHead?.removeFromSuperview()
            self.cardDeckHead = self.cardDeckHead?.nextCard
            //self.cardDeckHead?.previousCard?.lastCardSetup()
            self.cardDeckHead?.delegate = self
            self.cardDeckHead?.nextCardSetup()
            temp?.lastCardSetup()
            self.cardDeckHead?.previousCard = temp
            self.myView.addSubview(self.cardDeckHead!.nextCard ?? self.dummycard)
            self.myView.addSubview(self.cardDeckHead!.previousCard ?? self.dummycard)
            self.myView.sendSubviewToBack(self.cardDeckHead?.previousCard ?? self.dummycard)
            self.myView.sendSubviewToBack(self.cardDeckHead?.nextCard ?? self.dummycard)
            self.cardDeckHead?.previousCard?.fillSuperview()
            self.cardDeckHead?.nextCard?.fillSuperview()
        }
        CATransaction.commit()
    }
   
    func nextCardLeft(translation: CGFloat) {
        let duration = 0.3
        let translationAnimation = CABasicAnimation(keyPath: "position.x")
        translationAnimation.toValue = 700
        translationAnimation.duration = duration
        translationAnimation.fillMode = .forwards
        translationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        translationAnimation.isRemovedOnCompletion = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            self.cardDeckHead?.previousCard?.transform = .identity
        })
        cardDeckHead?.layer.add(translationAnimation, forKey: "translation")
        CATransaction.setCompletionBlock {
            let temp = self.cardDeckHead
            temp?.transform = .identity
            self.cardDeckHead?.removeFromSuperview()
            self.cardDeckHead = self.cardDeckHead?.previousCard
            //self.cardDeckHead?.previousCard?.lastCardSetup()
            self.cardDeckHead?.delegate = self
            temp?.nextCardSetup()
            self.cardDeckHead?.nextCard = temp
            self.cardDeckHead?.lastCardSetup()
            self.myView.addSubview(self.cardDeckHead!.nextCard ?? self.dummycard)
            self.myView.addSubview(self.cardDeckHead!.previousCard ?? self.dummycard)
            self.myView.sendSubviewToBack(self.cardDeckHead?.nextCard ?? self.dummycard)
            self.myView.sendSubviewToBack(self.cardDeckHead?.previousCard ?? self.dummycard)
            self.cardDeckHead?.nextCard?.fillSuperview()
            self.cardDeckHead?.previousCard?.fillSuperview()

        }
        CATransaction.commit()
    }
    
    let paddingSides = 11.5
    fileprivate func setUpLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [myView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        //searchBarView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: ScreenWidth, height: 200))
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 85, left: 13, bottom: 15, right: 13)
        overallStackView.bringSubviewToFront(myView)
        }
    }
