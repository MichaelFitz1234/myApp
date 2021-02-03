//  SocialPage.swift
//  BasketballAppTwo
//  Created by Michael Fitzgerald on 12/28/20.

import UIKit
import FirebaseFirestore
import FirebaseAuth
class SocialPage: UIViewController, UIScrollViewDelegate, FollowersPageProtocol, NavigationSocialDelegate{
    var currentUser: User?
    func reportScoreH(uid: String) {
        let messagesView = ReportAScore()
        let transition = CATransition()
        messagesView.uid = uid
        messagesView.setupMyUserFromFirebase()
        messagesView.modalPresentationStyle = .fullScreen
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(messagesView, animated: false, completion: nil)
    }
    func editProfileHit() {
        let messagesView = EditSettings()
        present(messagesView, animated: true, completion: nil)
    }
    func reportAScore() {
        let messagesView = plusButtonHitViewController()
        messagesView.messageType = 5
        present(messagesView, animated: true, completion: nil)
    }
    
    func messageButtonHit(uid: String) {
        let messagesView = Messages()
        let uidMsg = uid
        let transition = CATransition()
        messagesView.uid = uidMsg
        messagesView.shouldScroll = false
        messagesView.modalPresentationStyle = .fullScreen
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(messagesView, animated: false, completion: nil)
    }
    func makeFullScreen(myViewControllers: UIViewController) {
        present(myViewControllers, animated: true, completion: nil)
    }
    
    func makeBigger(MessageType: Int) {
        switch MessageType {
        case 0:
            FollowersLarge.isHidden = false
            Followers.isHidden = true
            scrollViewContainer.insertArrangedSubview(FollowersLarge, at: 3)
            scrollViewContainer.removeArrangedSubview(Followers)
        case 1:
            FriendsViewLarge.isHidden = false
            FriendsView.isHidden = true
            scrollViewContainer.insertArrangedSubview(FriendsViewLarge, at: 2)
            scrollViewContainer.removeArrangedSubview(FriendsView)
        case 2:
            FollowingLarge.isHidden = false
            Following.isHidden = true
            scrollViewContainer.insertArrangedSubview(FollowingLarge, at: 4)
            scrollViewContainer.removeArrangedSubview(Following)
        case 3:
            GlobalLarge.isHidden = false
            Global.isHidden = true
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
            Followers.isHidden = false
        case 1:
            scrollViewContainer.insertArrangedSubview(FriendsView, at: 2)
            scrollViewContainer.removeArrangedSubview(FriendsViewLarge)
            FriendsViewLarge.isHidden = true
            FriendsView.isHidden = false
        case 2:
            scrollViewContainer.insertArrangedSubview(Following, at: 4)
            scrollViewContainer.removeArrangedSubview(FollowingLarge)
            FollowingLarge.isHidden = true
            Following.isHidden = false
        case 3:
            scrollViewContainer.insertArrangedSubview(Global, at: 5)
            scrollViewContainer.removeArrangedSubview(GlobalLarge)
            GlobalLarge.isHidden = true
            Global.isHidden = false
        default:
            print("sadddd")
        }
    }
    fileprivate func setupMyUserFromFirebase(){
        let myUser = Auth.auth().currentUser?.uid ?? ""
        let docRef = Firestore.firestore().collection("Users").document(myUser)
        docRef.getDocument { (snapshot, error) in
            let dataUser = snapshot?.data()
            let currentUsr = User(dictionary: dataUser ?? ["":""])
            self.currentUser = currentUsr
            self.NavigationView.PicImage = currentUsr.imageUrl ?? ""
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
        getUsersFromFirebase(relationship: "friend") { (myArray) in
            let db = Firestore.firestore().collection("Users")
            myArray.forEach { (element) in
            db.document(element).getDocument { (snapshot, error) in
                let myData = snapshot?.data()
                let usr = User(dictionary: myData ?? ["": ""])
                let Friend = Friends()
                Friend.messageType1 = 1
                Friend.userProperties = usr
                self.FriendsViewLarge.addViewFriend(friend: Friend)
                }
            }
        }
        getUsersFromFirebase(relationship: "following") { (myArray) in
            let db = Firestore.firestore().collection("Users")
            myArray.forEach { (element) in
            db.document(element).getDocument { (snapshot, error) in
                let myData = snapshot?.data()
                let usr = User(dictionary: myData ?? ["": ""])
                let Friend = Friends()
                Friend.messageType1 = 2
                Friend.userProperties = usr
                self.FollowingLarge.addViewFriend(friend: Friend)
                }
            }
        }
        getUsersFromFirebase(relationship: "follower") { (myArray) in
            let db = Firestore.firestore().collection("Users")
            myArray.forEach { (element) in
            db.document(element).getDocument { (snapshot, error) in
                let myData = snapshot?.data()
                let usr = User(dictionary: myData ?? ["": ""])
                let Friend = Friends()
                Friend.messageType1 = 0
                Friend.userProperties = usr
                self.FollowersLarge.addViewFriend(friend: Friend)
                }
            }
        }
        getGlobal()
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
    fileprivate func getGlobal(){
        Firestore.firestore().collection("Users").order(by: "currElo").limit(to: 8).getDocuments { (snapshot, error) in
            snapshot?.documents.forEach({ (document) in
                let myData = document.data()
                let usr = User(dictionary: myData)
                let Friend = Friends()
                Friend.messageType1 = 3
                Friend.userProperties = usr
                self.GlobalLarge.addViewFriend(friend: Friend)
            })
        }
    }
    fileprivate func getUsersFromFirebase(relationship: String, completion: @escaping (Array<String>)->()){
        var myArray = Array<String>()
        let query =  Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Social").whereField("relationship", isEqualTo: relationship).limit(to: 7)
        query.addSnapshotListener { (snapshot, error) in
            myArray = Array<String>()
            snapshot?.documentChanges.forEach({ (doc) in
                if doc.type != .removed{
                myArray.append(doc.document.get("uid") as? String ?? "")
                }else{
                let temp = doc.document.get("uid") as? String ?? ""
                    if(relationship == "friend"){
                self.FriendsViewLarge.removeFriend(uid: temp)
                    }else if relationship == "following"{
                self.FollowingLarge.removeFriend(uid: temp)
                    }else if relationship == "follower"{
                self.FollowersLarge.removeFriend(uid: temp)
                    }
                }
            })
            completion(myArray)
        }
    }
    fileprivate func setupView() {
        view.backgroundColor = .white
        view.addSubview(NavigationView)
        NavigationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        NavigationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        NavigationView.delegate = self
        scrollViewContainer.addArrangedSubview(NewRequests)
        scrollViewContainer.addArrangedSubview(FriendsView)
        scrollViewContainer.addArrangedSubview(Followers)
        scrollViewContainer.addArrangedSubview(Following)
        scrollViewContainer.addArrangedSubview(Global)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: NavigationView.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
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
        myFollowersPage.height = CGFloat(60)
        myFollowersPage.MessageType = 0
        myFollowersPage.makeSmallOrBig = 0
        return myFollowersPage
    }()
    let FollowersLarge: FollowersPage = {
        let myFollowersLarge = FollowersPage()
        myFollowersLarge.MessageType = 0
        myFollowersLarge.big = false
        myFollowersLarge.makeSmallOrBig = 1
        return myFollowersLarge
    }()
    let FriendsView: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.height = CGFloat(60)
        myFollowersPage.MessageType = 1
        myFollowersPage.makeSmallOrBig = 0
        return myFollowersPage
    }()
    let FriendsViewLarge: FollowersPage = {
        let myFollowersLarge = FollowersPage()
        myFollowersLarge.MessageType = 1
        myFollowersLarge.big = false
        myFollowersLarge.makeSmallOrBig = 1
        return myFollowersLarge
    }()
    let Following: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.height = CGFloat(60)
        myFollowersPage.MessageType = 2
        myFollowersPage.makeSmallOrBig = 0
        return myFollowersPage
    }()
    let FollowingLarge: FollowersPage = {
        let myFollowersLarge = FollowersPage()
        myFollowersLarge.MessageType = 2
        myFollowersLarge.big = false
        myFollowersLarge.makeSmallOrBig = 1
        return myFollowersLarge
    }()
    let Global: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.height = CGFloat(60)
        myFollowersPage.MessageType = 3
        myFollowersPage.makeSmallOrBig = 0
        return myFollowersPage
    }()
    let GlobalLarge: FollowersPage = {
        let myFollowersLarge = FollowersPage()
        myFollowersLarge.MessageType = 3
        myFollowersLarge.big = false
        myFollowersLarge.makeSmallOrBig = 1
        return myFollowersLarge
    }()
    let NewRequests: UIView = NotificationsSocialPage()
}
