//  homePage.swift
//  BasketballAppTwo
//  Created by Michael Fitzgerald on 11/13/20.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import SDWebImage
import JGProgressHUD

class homePage: UIViewController, CardViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    var data: [String] = []
    var filteredData: [String]!
    let tblview = UITableView()
    let searchBarView = UISearchBar()
    var searchedIsClear = true
    fileprivate var myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUsrInfo()
        setUpLayout()
        getUsersFromFiresbase()
        searchBarView.delegate = self
        tblview.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        tblview.dataSource = self
        tblview.delegate = self
        searchUsersFromFirestore()
        filteredData = data
    }
    var myUser:User!
    func getMyUser() -> User{
        return myUser
    }
    func currentUsrInfo(){
        let currentUsrId = Auth.auth().currentUser?.uid ?? ""
        let db2 = Firestore.firestore().collection("users").document(currentUsrId)
        db2.getDocument { (snapshot, error) in
            let myUserInfo = snapshot?.data()
            let user = User(dictionary: myUserInfo!)
            self.myUser = user
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            view.addSubview(tblview)
            self.tblview.separatorStyle = UITableViewCell.SeparatorStyle.none
            tblview.anchor(top: searchBarView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
            view.bringSubviewToFront(tblview)
          
        searchBar.setShowsCancelButton(true, animated: true)
        //searchBarView.showsCancelButton = true
    }
    fileprivate func searchUsersFromFirestore(){
        let query = Firestore.firestore().collection("Usernames")
        query.getDocuments { (snapshot, err) in
            if let err = err{
              print("this is the", err)
              return
            }else{
                snapshot?.documents.forEach({ (documentSnapshot) in
                    let myUserInfo = documentSnapshot.data()
                    let user = shortUsr(dictionary: myUserInfo)
                    let string = user.Username as String? ?? ""
                    self.data.append(string)
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let registeringHUD = JGProgressHUD(style: .dark)
        registeringHUD.textLabel.text = "Fetching User"
        registeringHUD.show(in: self.view)
        let usrname = filteredData[indexPath.row]
        let query = Firestore.firestore().collection("Usernames").document("\(usrname)")
        query.getDocument { (documentSnapshot, error) in
            let uid = documentSnapshot?.get("uid")
            let docRef = Firestore.firestore().collection("users").document("\(uid ?? "")")
            docRef.getDocument { (documentSnapshot, error) in
                let myUserInfo = documentSnapshot?.data()
                let user = User(dictionary: myUserInfo!)
                let cardDeck = self.CardViewFromUser(user: user)
                self.tblview.removeFromSuperview()
                self.searchBarView.setShowsCancelButton(false, animated: true)
                self.searchBarView.text = ""
                self.searchBarView.endEditing(true)
                self.insertUsr(Card: cardDeck)
                //self.cardDeckHead?.removxeFromSuperview()
                self.myView.addSubview(self.cardDeckHead ?? self.fillerUIView)
                self.cardDeckHead?.fillSuperview()
                self.cardDeckHead?.delegate = self
                registeringHUD.dismiss()
           }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myImg = UIImageView()
        let myLabel = UILabel()
        myLabel.backgroundColor = .white
        myImg.backgroundColor = .gray
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as UITableViewCell
        let query = Firestore.firestore().collection("Usernames").document("\(filteredData[indexPath.row])")
        query.getDocument { (documentSnapshot, error) in
            let imgPath = documentSnapshot?.get("imagePath")
            let storageRef = Storage.storage().reference(withPath: imgPath as! String)
            storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
            if let error = error{
            print("Got an error fetching data: \(error.localizedDescription)")
                return
                }else{
            if let data = data{
                myImg.image = UIImage(data: data)
                myImg.image?.withRenderingMode(.alwaysOriginal)
                myImg.contentMode = .scaleAspectFill
                return
                        }
                    }
                }
        }
        myImg.layer.masksToBounds = true
        myImg.layer.cornerRadius = 20
        cell.addSubview(myImg)
        cell.addSubview(myLabel)
        myImg.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        myLabel.anchor(top: cell.topAnchor, leading: myImg.trailingAnchor, bottom: cell.bottomAnchor, trailing: cell.trailingAnchor, padding: .init(top: 10, left: 4, bottom: 0, right: 0))
        myLabel.text = filteredData[indexPath.row]
        myLabel.textColor = .systemGray2
        myLabel.font = .systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 10))
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        // Remove focus from the search bar.
        tblview.removeFromSuperview()
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //searchBarView.showsCancelButton = true
        if (searchText.isEmpty == false){
            view.addSubview(tblview)
            self.tblview.separatorStyle = UITableViewCell.SeparatorStyle.none
            tblview.anchor(top: searchBarView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
            view.bringSubviewToFront(tblview)
            filteredData = data.filter({(dataString: String) -> Bool in
                 return dataString.range(of: searchText, options: .caseInsensitive) != nil
            })
        }  else if (searchText.isEmpty == true){
           filteredData = []
        }
        tblview.reloadData()
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
    fileprivate func insertUsr(Card: CardView){
        let tempNode = cardDeckHead
        cardDeckHead = Card
        cardDeckHead?.nextCard = tempNode?.nextCard
        tempNode?.nextCard = Card
        cardDeckHead?.previousCard = tempNode
        tempNode?.previousCard?.removeFromSuperview()
        //cardDeckHead?.previousCard = cardDeckHead?.previousCard?.previousCard
    }
    let fillerUIView = UIView()
    let dummycard = CardView()
    var users = [User]()
    fileprivate func CardViewFromUser(user: User) -> CardView{
        let cardDeckView = CardView()
        cardDeckView.uid = user.uid ?? ""
        cardDeckView.UsrName = user.Username ?? ""
        cardDeckView.locationUsername.text = "\(user.Username ?? "")  \(21) \n 22 miles away"
        cardDeckView.Elo.text = " \(user.Elo ?? 5) \n Some Ranking"
        cardDeckView.imageUrl = user.imageUrl ?? ""
        return cardDeckView
    }
    func didTapMoreInfo(){
        let myController = UserInformation()
        present(myController, animated: true)
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
        view.addSubview(searchBarView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 85, left: 13, bottom: 15, right: 13)
        overallStackView.bringSubviewToFront(myView)
        searchBarView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        searchBarView.searchBarStyle = .minimal
        searchBarView.placeholder = "search for friends"
        }
    }

    

