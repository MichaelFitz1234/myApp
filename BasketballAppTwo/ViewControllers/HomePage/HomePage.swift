//  homePage.swift
//  BasketballAppTwo
//  Created by Michael Fitzgerald on 11/13/20.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth
import JGProgressHUD
import CoreLocation
import GeoFire
class HomePage: UIViewController, CardViewDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, CLLocationManagerDelegate {
    func msgHit(uid: String) {
        let messagesView = Messages()
        messagesView.shouldScroll = false
        let uidMsg = uid
        let transition = CATransition()
        messagesView.uid = uidMsg
        messagesView.modalPresentationStyle = .fullScreen
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(messagesView, animated: false, completion: nil)
    }
    
    func reportScoreHit(uid: String) {
        let messagesView = ReportAScore()
        messagesView.uid = uid
        messagesView.setupMyUserFromFirebase()
        messagesView.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(messagesView, animated: false, completion: nil)
    }
    
    func unfriendHit(uid: String){
        let db = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Social").document(uid)
        let db2 = Firestore.firestore().collection("Users").document(uid).collection("Social").document(Auth.auth().currentUser?.uid ?? "")
        db.updateData(["relationship" : "follower"])
        db2.updateData(["relationship" : "following"])
        Firestore.firestore().collection("Messages").document(Auth.auth().currentUser?.uid ?? "").collection("Social").document(uid).delete()
    }
    func friendHit(uid: String, username: String, imagePath: String) {
        let db = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Social").document(uid)
        let db2 = Firestore.firestore().collection("Users").document(uid).collection("Social").document(Auth.auth().currentUser?.uid ?? "")
        db.updateData(["relationship" : "friend"])
        db2.updateData(["relationship" : "friend"])
        let username2 = createIndex(title: username)
        Firestore.firestore().collection("Messages").document(Auth.auth().currentUser?.uid ?? "").collection("Social").document(uid).setData(["uid":uid,"searchIndex" : username2, "username": username, "imagePath" : imagePath, "hasLastMsg": false, "lastMsg": ""])
        Firestore.firestore().collection("Messages").document(uid).collection("Social").document(Auth.auth().currentUser?.uid ?? "").setData(["uid":Auth.auth().currentUser?.uid ?? "","searchIndex" : username2, "username": username, "imagePath" : imagePath, "hasLastMsg": false, "lastMsg": ""])
    }
    func unfollowHit(unFollow: Int, uid: String, username: String, imagePath: String) {
        let db = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Social").document(uid)
        let db2 = Firestore.firestore().collection("Users").document(uid).collection("Social").document(Auth.auth().currentUser?.uid ?? "")
        let date = Date()
        if unFollow == 0{
            let username2 = createIndex(title: username)
            db.setData(["uid" : uid, "searchIndex" : username2, "username": username, "imagePath" : imagePath, "relationship": "following", "hasLastMsg": false, "timestamp": date])
            db2.setData(["uid" : Auth.auth().currentUser?.uid ?? "", "searchIndex" : username2, "username": username, "imagePath" : imagePath, "relationship": "follower", "hasLastMsg": false, "timestamp": date])
        }else{
            db.delete()
            db2.delete()
        }
    }
    func followHit(followOrNot: Int, uid: String, username: String, imagePath: String) {
        let db = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Social").document(uid)
        let db2 = Firestore.firestore().collection("Users").document(uid).collection("Social").document(Auth.auth().currentUser?.uid ?? "")
        let date = Date()
        if followOrNot == 0{
            let username2 = createIndex(title: username)
            db.setData(["uid" : uid, "searchIndex" : username2, "username": username, "imagePath" : imagePath, "relationship": "following", "hasLastMsg": false, "timestamp": date])
            db2.setData(["uid" : Auth.auth().currentUser?.uid ?? "", "searchIndex" : username2, "username": username, "imagePath" : imagePath, "relationship": "follower", "hasLastMsg": false, "timestamp": date])
        }else{
            db.delete()
            db2.delete()
        }
    }
    func didTapMoreInfo(uid: String){
        let myController = UserInformation()
        myController.myUsr = uid
        present(myController, animated: true)
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
            self.myView.addSubview(self.cardDeckHead?.nextCard ?? self.dummycard)
            self.myView.addSubview(self.cardDeckHead?.previousCard ?? self.dummycard)
            self.myView.sendSubviewToBack(self.cardDeckHead?.nextCard ?? self.dummycard)
            self.myView.sendSubviewToBack(self.cardDeckHead?.previousCard ?? self.dummycard)
            self.cardDeckHead?.nextCard?.fillSuperview()
            self.cardDeckHead?.previousCard?.fillSuperview()
        }
        CATransaction.commit()
    }
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
            self.myView.addSubview(self.cardDeckHead?.nextCard ?? self.dummycard)
            self.myView.addSubview(self.cardDeckHead?.previousCard ?? self.dummycard)
            self.myView.sendSubviewToBack(self.cardDeckHead?.previousCard ?? self.dummycard)
            self.myView.sendSubviewToBack(self.cardDeckHead?.nextCard ?? self.dummycard)
            self.cardDeckHead?.previousCard?.fillSuperview()
            self.cardDeckHead?.nextCard?.fillSuperview()
        }
        CATransaction.commit()
    }
    var documentIndex = 0
    var inDocumentIndex = 0
    var currentUsrCount = 0
    var followFriendFollowing = [String]()
    var listOfMyDocuments = [QueryDocumentSnapshot]()
    //This is for nill coelesing
    let fillerUIView = UIView()
    //this is used for nil values
    let dummycard = CardView()
    var users = [User]()
    fileprivate lazy var screenSize = UIScreen.main.bounds
    fileprivate lazy var ScreenWidth = ((screenSize.width)+20)
    var filteredData = [User]()
    let tblview = UITableView()
    let searchBarView = UISearchBar()
    var searchedIsClear = true
    fileprivate var myView = UIView()
    var myUser:User?
    var lastAddedPointer: CardView?
    var cardDeckHead: CardView?
    var nextCardInstantiation: CardView?
    var locationManager = CLLocationManager()
    var lon: Double?
    var lat: Double?
    var location:CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        searchBarView.delegate = self
        tblview.register(SearchForUsers.self, forCellReuseIdentifier: "searchCell")
        tblview.dataSource = self
        tblview.delegate = self
        setUpLayout()
    }
    fileprivate func createIndex(title: String) -> [String] {
        var searchableIndex = [String]()
        let myLength = title.count
        for index in 1...myLength{
            let myString = String(title.prefix(index))
            searchableIndex.append(myString)
        }
        return searchableIndex
    }
    fileprivate func getRelationships(){
    let db = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Social")
        db.getDocuments { (documents, error) in
            documents?.documents.forEach({ (snapshotTwo) in
                let tempArray = snapshotTwo.get("uid") as? Array<String>
                tempArray?.forEach({ (myBody) in
                    self.followFriendFollowing.append(myBody)
                })
            })
        }
    }
    fileprivate func searchUsers(text: String) -> Query{
        let db = Firestore.firestore().collection("Users").whereField("searchIndex", arrayContains: text).limit(to: 7)
        return db
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        lon = locValue.longitude
        lat = locValue.latitude
        location = locValue
        geoQuery(lat: lat ?? 0, lon: lon ?? 0, radius: 121)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            view.addSubview(tblview)
            self.tblview.separatorStyle = UITableViewCell.SeparatorStyle.none
            tblview.anchor(top: searchBarView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
            view.bringSubviewToFront(tblview)
            searchBar.setShowsCancelButton(true, animated: true)
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
            let userToBeAdded = filteredData[indexPath.row]
            let cardDeck = CardView()
                cardDeck.userProperties = userToBeAdded
            let db = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Social").whereField("uid", isEqualTo: userToBeAdded.uid ?? "")
            db.getDocuments { (snapshot, error) in
            //get the users social relationship
            if snapshot?.isEmpty == true{
            self.tblview.removeFromSuperview()
            self.searchBarView.setShowsCancelButton(false, animated: true)
            self.searchBarView.text = ""
            self.searchBarView.endEditing(true)
            self.insertUsr(Card: cardDeck)
            self.cardDeckHead?.removeFromSuperview()
            self.myView.addSubview(self.cardDeckHead ?? self.fillerUIView)
            self.cardDeckHead?.fillSuperview()
            self.cardDeckHead?.delegate = self
            registeringHUD.dismiss()
            }else{
                snapshot?.documents.forEach({ (snapshot) in
                    let relationship = snapshot.get("relationship") as? String
                    cardDeck.relationship = relationship
                    self.tblview.removeFromSuperview()
                    self.searchBarView.setShowsCancelButton(false, animated: true)
                    self.searchBarView.text = ""
                    self.searchBarView.endEditing(true)
                    self.insertUsr(Card: cardDeck)
                    self.cardDeckHead?.removeFromSuperview()
                    self.myView.addSubview(self.cardDeckHead ?? self.fillerUIView)
                    self.cardDeckHead?.fillSuperview()
                    self.cardDeckHead?.delegate = self
                    registeringHUD.dismiss()
                })
            }
        }
    }
    //this should be a custom table view cell not the generic one
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchForUsers
        cell.myLabel.text = filteredData[indexPath.row].Username
        cell.myPath = filteredData[indexPath.row].imageUrl
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredData = []
        tblview.reloadData()
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        tblview.removeFromSuperview()
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty == false){
            var tempArray = [User]()
            let query = searchUsers(text: searchText)
            query.getDocuments { [self] (snapshot, error) in
                snapshot?.documents.forEach({ (snapshot) in
                    let myData = snapshot.data()
                    let user = User(dictionary: myData)
                    tempArray.append(user)
                })
                self.filteredData = tempArray
                tblview.reloadData()
            }
        }else if searchText.isEmpty == true{
            filteredData = []
            tblview.reloadData()
        }
    }
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
    }
    //this is the initial GeoQuery
    func geoQuery(lat: Double, lon: Double, radius: Double) {
        let db = Firestore.firestore()
        var queriesCount = 0
        let center = CLLocationCoordinate2D(latitude: lat, longitude: lon )
        let radiusInKilometers: Double = radius * 1000
        let queryBounds = GFUtils.queryBounds(forLocation: center, withRadius: radiusInKilometers)
        let queries = queryBounds.compactMap { (any) -> Query? in
            guard let bound = any as? GFGeoQueryBounds else { return nil }
            return db.collection("GeoPoint")
                .order(by: "geohash")
                .start(at: [bound.startValue])
                .end(at: [bound.endValue])
        }
        let myTotal =  queries.count
        func getDocumentsCompletion(snapshot: QuerySnapshot?, error: Error?) {
            guard let documents = snapshot?.documents else {
                print("Unable to fetch snapshot data. \(String(describing: error))")
                return
            }
            documents.forEach { (document) in
                listOfMyDocuments.append(document)
            }
            if queriesCount < myTotal{
                queriesCount = queriesCount+1
            }
            if queriesCount == myTotal{
                myInitialViewQuery()
            }
            
        }
        queries.forEach { (query) in
            query.getDocuments(completion: getDocumentsCompletion)
        }
    }
    fileprivate func myInitialViewQuery(){
        let myDoc = listOfMyDocuments[documentIndex]
        let data = myDoc.get("userIds") as? Array<String> ?? [""]
        while(inDocumentIndex < data.count - 1){
            let user12 = data[self.inDocumentIndex]
            self.checkIfValidEntry(user: user12) { (myValue) in
                if myValue == true{
                    Firestore.firestore().collection("Users").document(user12).getDocument { (querySnapshot, error) in
                        let myUserInfo = querySnapshot?.data()
                        let user2 = User(dictionary: myUserInfo ?? ["":""])
                        let myLat = user2.location?.latitude ?? 0.0
                        let myLon = user2.location?.longitude ?? 0.0
                        let center1 = CLLocation(latitude: self.lat ?? 0, longitude: self.lon ?? 0)
                        let location2 = CLLocation(latitude: myLat, longitude: myLon)
                        let distance = GFUtils.distance(from: center1, to: location2) * 0.621371
                        let cardDeckView = CardView()
                        cardDeckView.distance = Int(round(distance/1000))
                        cardDeckView.userProperties = user2
                        self.addUser(CardView: cardDeckView)
                        self.firstCardCreated()
                    }
                }else{
                    }
                }
            inDocumentIndex = inDocumentIndex + 1
        }
    }
    fileprivate func checkIfValidEntry(user: String, completion: @escaping(_ isTrue: Bool)->()){
        let query = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Social").whereField("uid", isEqualTo: user)
        query.getDocuments { (query, error) in
            if(query?.isEmpty == true){
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    fileprivate func firstCardCreated(){
        self.myView.addSubview(self.cardDeckHead ?? self.fillerUIView)
        self.myView.sendSubviewToBack(self.cardDeckHead ?? self.fillerUIView)
        self.cardDeckHead?.fillSuperview()
        self.cardDeckHead?.delegate = self
        self.cardDeckHead?.nextCardSetup()
        self.myView.addSubview(self.cardDeckHead?.nextCard ?? self.dummycard)
        self.myView.sendSubviewToBack(self.cardDeckHead?.nextCard ?? self.dummycard)
        self.cardDeckHead?.nextCard?.fillSuperview()
    }
    fileprivate func setUpLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [myView])
        view.addSubview(overallStackView)
        view.addSubview(searchBarView)
        overallStackView.axis = .vertical
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 85, left: 13, bottom: 15, right: 13)
        overallStackView.bringSubviewToFront(myView)
        searchBarView.autocapitalizationType = .none
        searchBarView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        searchBarView.searchBarStyle = .minimal
        searchBarView.placeholder = "search for friends"
        }
    }

    

