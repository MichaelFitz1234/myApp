//  SocialPage.swift
//  BasketballAppTwo
//  Created by Michael Fitzgerald on 12/28/20.

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
class SocialPage: UIViewController, UIScrollViewDelegate, FollowersPageProtocol{
    var count = 0
    func makeFullScreen(myViewControllers: UIViewController) {
        present(myViewControllers, animated: true, completion: nil)
    }
    func makeBigger(MessageType: Int) {
        switch MessageType {
        case 0:
            FollowersLarge.isHidden = false
            scrollViewContainer.insertArrangedSubview(FollowersLarge, at: 3)
            scrollViewContainer.removeArrangedSubview(Followers)
        case 1:
            FriendsViewLarge.isHidden = false
            scrollViewContainer.insertArrangedSubview(FriendsViewLarge, at: 2)
            scrollViewContainer.removeArrangedSubview(FriendsView)
        case 2:
            FollowingLarge.isHidden = false
            scrollViewContainer.insertArrangedSubview(FollowingLarge, at: 4)
            scrollViewContainer.removeArrangedSubview(Following)
        case 3:
            GlobalLarge.isHidden = false
            scrollViewContainer.insertArrangedSubview(GlobalLarge, at: 5)
            scrollViewContainer.removeArrangedSubview(Global)
        default:
            print("sadddd")
        }
    
    }
    func makeSmaller(MessageType: Int){
        switch MessageType {
        case 0:
            scrollViewContainer.insertArrangedSubview(Followers, at: 3)
            scrollViewContainer.removeArrangedSubview(FollowersLarge)
            FollowersLarge.isHidden = true
        case 1:
            scrollViewContainer.insertArrangedSubview(FriendsView, at: 2)
            scrollViewContainer.removeArrangedSubview(FriendsViewLarge)
            FriendsViewLarge.isHidden = true
        case 2:
            scrollViewContainer.insertArrangedSubview(Following, at: 4)
            scrollViewContainer.removeArrangedSubview(FollowingLarge)
            FollowingLarge.isHidden = true
        case 3:
            scrollViewContainer.insertArrangedSubview(Global, at: 5)
            scrollViewContainer.removeArrangedSubview(GlobalLarge)
            GlobalLarge.isHidden = true
        default:
            print("sadddd")
        }
    }
    fileprivate func setupMyUserFromFirebase(){
        let myUser = Auth.auth().currentUser?.uid ?? ""
        let docRef = Firestore.firestore().collection("users").document(myUser)
        docRef.getDocument { (snapshot, error) in
            let myImage = snapshot?.get("imagePath") as! String
            let storageRef = Storage.storage().reference(withPath: myImage)
            storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
            if let error = error{
            print("Got an error fetching data: \(error.localizedDescription)")
                return
                }else{
            if let data = data{
                self.NavigationView.PicImage = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "Image")
                        }
                    }
                }
        }
    }


    fileprivate func getUsersFromFirebase(type: Int){
        let myUser = Auth.auth().currentUser?.uid ?? ""
        let docRef = Firestore.firestore().collection("users").document(myUser)
        switch type {
        case 0:
            docRef.collection("Followers").getDocuments { (snapshot, error) in
                snapshot?.documents.forEach({ (document) in
                    let myData = document.data()
                    let User = PlayerShort(dictionary: myData)
                    let storageRef = Storage.storage().reference(withPath: User.profileImageUrl)
                    storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
                    if let error = error{
                    print("Got an error fetching data: \(error.localizedDescription)")
                        return
                        }else{
                    if let data = data{
                        let myImage = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "Image")
                        let myFriend = self.createViews(myFriend: User)
                        myFriend.myImage = myImage
                        myFriend.messageType1 = type
                        myFriend.setupLayout()
                        self.FollowersLarge.addViewFriend(friend: myFriend)
                                }
                            }
                        }
                })
             DispatchQueue.main.async {
                    self.FollowersLarge.MessageType = type
                    self.FollowersLarge.big = false
                    self.FollowersLarge.setupLayout2()
                    self.FollowersLarge.makeSmallOrBig = 1
                }
            }
        case 1:
            docRef.collection("Friends").getDocuments { (snapshot, error) in
                snapshot?.documents.forEach({ (document) in
                    let myData = document.data()
                    let User = PlayerShort(dictionary: myData)
                    let storageRef = Storage.storage().reference(withPath: User.profileImageUrl)
                    storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
                    if let error = error{
                    print("Got an error fetching data: \(error.localizedDescription)")
                        return
                        }else{
                    if let data = data{
                        let myImage = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "Image")
                        let myFriend = self.createViews(myFriend: User)
                        myFriend.myImage = myImage
                        myFriend.messageType1 = type
                        myFriend.setupLayout()
                        self.FriendsViewLarge.addViewFriend(friend: myFriend)
                                }
                            }
                        }
                })
             DispatchQueue.main.async {
                    self.FriendsViewLarge.MessageType = type
                    self.FriendsViewLarge.big = false
                    self.FriendsViewLarge.setupLayout2()
                    self.FriendsViewLarge.makeSmallOrBig = 1
                }
            }
        case 2:
            docRef.collection("Following").getDocuments { (snapshot, error) in
                snapshot?.documents.forEach({ (document) in
                    let myData = document.data()
                    let User = PlayerShort(dictionary: myData)
                    let storageRef = Storage.storage().reference(withPath: User.profileImageUrl)
                    storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
                    if let error = error{
                    print("Got an error fetching data: \(error.localizedDescription)")
                        return
                        }else{
                    if let data = data{
                        let myImage = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "Image")
                        let myFriend = self.createViews(myFriend: User)
                        myFriend.myImage = myImage
                        myFriend.messageType1 = type
                        myFriend.setupLayout()
                        self.FollowingLarge.addViewFriend(friend: myFriend)
                                }
                            }
                        }
                })
             DispatchQueue.main.async {
                    self.FollowingLarge.MessageType = type
                    self.FollowingLarge.big = false
                    self.FollowingLarge.setupLayout2()
                    self.FollowingLarge.makeSmallOrBig = 1
                }
            }
        case 3:
            Firestore.firestore().collection("users").getDocuments { (snapshot, error) in
                var Ranking = 1
                snapshot?.documents.forEach({ (document) in
                    let myData = document.data()
                    let User = PlayerShort(dictionary: myData)
                    let storageRef = Storage.storage().reference(withPath: User.profileImageUrl)
                    storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
                    if let error = error{
                    print("Got an error fetching data: \(error.localizedDescription)")
                        return
                        }else{
                    if let data = data{
                        let myImage = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "Image")
                        let myFriend = self.createViews(myFriend: User)
                        myFriend.myImage = myImage
                        myFriend.RankingValue = Ranking
                        myFriend.messageType1 = type
                        myFriend.setupLayout()
                        self.GlobalLarge.addViewFriend(friend: myFriend)
                        Ranking = Ranking + 1
                                }
                            }
                        }
                })
             DispatchQueue.main.async {
                    self.GlobalLarge.MessageType = type
                    self.GlobalLarge.big = false
                    self.GlobalLarge.setupLayout2()
                    self.GlobalLarge.makeSmallOrBig = 1
                }
            }
        default:
            print("sadness")
        }
    }
    func searchHit(MessageType: Int) {
        let controller = plusButtonHitViewController()
        controller.messageType = MessageType
        present(controller, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMyUserFromFirebase()
        getUsersFromFirebase(type: 0)
        getUsersFromFirebase(type: 1)
        getUsersFromFirebase(type: 2)
        getUsersFromFirebase(type: 3)
        scrollView.delegate = self
        FriendsView.delegate = self
        FriendsViewLarge.delegate = self
        Followers.delegate = self
        Following.delegate = self
        FollowingLarge.delegate = self
        Global.delegate = self
        GlobalLarge.delegate = self
        FollowersLarge.delegate = self
        setupView()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var newFrame = NavigationView.frame
        newFrame.origin.y = max(self.initialOffSet, scrollView.contentOffset.y)
        NavigationView.frame = newFrame
    }
    fileprivate func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(NavigationView)
        NavigationView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        scrollViewContainer.addArrangedSubview(NewRequests)
        scrollViewContainer.addArrangedSubview(FriendsView)
        scrollViewContainer.addArrangedSubview(Followers)
        scrollViewContainer.addArrangedSubview(Following)
        scrollViewContainer.addArrangedSubview(Global)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        initialOffSet = NavigationView.frame.origin.y
    }
    
    
    func createViews(myFriend: PlayerShort) -> Friends{
        let Friend = Friends()
        Friend.elo = myFriend.Username
        Friend.Username = myFriend.Username
        return Friend
    }
    var initialOffSet = CGFloat(0)
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let NavigationView = NavigationSocial()
    //this is used to show the friends
    let Followers: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.MessageType = 0
        myFollowersPage.makeSmallOrBig = 0
        myFollowersPage.setupLayout()
        return myFollowersPage
    }()
    let FollowersLarge = FollowersPage()
    
    let FriendsView: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.MessageType = 1
        myFollowersPage.makeSmallOrBig = 0
        myFollowersPage.setupLayout()
        return myFollowersPage
    }()
    let FriendsViewLarge = FollowersPage()
  
    let Following: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.MessageType = 2
        myFollowersPage.makeSmallOrBig = 0
        myFollowersPage.setupLayout()
        return myFollowersPage
    }()
    let FollowingLarge = FollowersPage()
    let Global: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.MessageType = 3
        myFollowersPage.makeSmallOrBig = 0
        myFollowersPage.setupLayout()
        return myFollowersPage
    }()
    let GlobalLarge = FollowersPage()
    let NewRequests: UIView = NotificationsSocialPage()
}
