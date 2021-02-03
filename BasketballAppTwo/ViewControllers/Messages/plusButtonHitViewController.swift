//
//  plusButtonHitViewController.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/27/20.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
protocol createAMapChallenge {
    func addToMap()
    //func msgButtonHit2()
}
class plusButtonHitViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate{
    var delegate: createAMapChallenge?
    let myButton = UIButton()
    let myDatePicker = UIDatePicker()
    func reportScoreHit(uid: String) {
        let messagesView = ReportAScore()
        let transition = CATransition()
        messagesView.modalPresentationStyle = .fullScreen
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(messagesView, animated: false, completion: nil)
    }
    func messageButtonHit(uid: String) {
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
    var messageType = 4{
        didSet {
            switch messageType {
            //this is the case for following usr
            case 0:
                view.addSubview(Friends)
                Friends.text = "Followers/Follow Requests"
                Friends.textAlignment = .center
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
                setupView()
            case 1:
                view.addSubview(Friends)
                Friends.text = "Friends"
                Friends.textAlignment = .center
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
                setupView()
            case 2:
                view.addSubview(Friends)
                Friends.text = "Following"
                Friends.textAlignment = .center
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
                setupView()
            case 3:
                view.addSubview(Friends)
                Friends.text = "Global Leaderboard"
                Friends.textAlignment = .center
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
                setupView()
            case 4:
                view.addSubview(Friends)
                Friends.text = "Friends"
                Friends.textAlignment = .center
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
                setupView()
            case 5:
                view.addSubview(Friends)
                Friends.text = "Friends"
                Friends.textAlignment = .center
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
                setupView()
            case 6:
                view.addSubview(Friends)
                Friends.text = "Create Challenge"
                Friends.textAlignment = .center
                myButton.setTitle("Next", for: .normal)
                myButton.setTitleColor(.systemBlue, for: .normal)
                myButton.addTarget(self, action: #selector(NextHit), for: .touchUpInside)
                view.addSubview(myButton)
                myButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 5, bottom: 0, right: 0),size: .init(width: 70, height: 30))
                myButton.titleLabel?.adjustsFontSizeToFitWidth = true
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
                view.addSubview(myDatePicker)
                myDatePicker.anchor(top: Friends.bottomAnchor, leading: nil, bottom: nil, trailing: myButton.trailingAnchor, padding: .init(top: 10, left: -10, bottom: 0, right: 0),size: .init(width: 200, height: 40))
                let SelectATime = UILabel()
                view.addSubview(SelectATime)
                SelectATime.anchor(top: myDatePicker.topAnchor, leading: nil, bottom: nil, trailing: myDatePicker.leadingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 4))
                SelectATime.text = "Time For Challenge:"
                SelectATime.numberOfLines = 0
                setupView()
            default:
                print("sad")
            }
        }
    }
    var dataFirst = [User]()
    var filteredData = [User]()
    fileprivate let searchBar = UISearchBar()
    fileprivate let mytblView = UITableView()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if messageType == 6{
            return filteredData.count+1
        }else{
            return filteredData.count
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if messageType == 4{
            let messagesView = Messages()
            messagesView.shouldScroll = false
            let uidMsg = filteredData[indexPath.row].uid
            messagesView.uid = uidMsg ?? ""
            messagesView.modalPresentationStyle = .fullScreen
            let transition = CATransition()
            transition.duration = 0.25
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            present(messagesView, animated: false, completion: nil)
        }else if(messageType == 5){
            let messagesView = ReportAScore()
            messagesView.uid = filteredData[indexPath.row].uid ?? ""
            messagesView.setupMyUserFromFirebase()
            messagesView.modalPresentationStyle = .fullScreen
            let transition = CATransition()
            transition.duration = 0.25
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
            view.window!.layer.add(transition, forKey: kCATransition)
            present(messagesView, animated: false, completion: nil)
        }else if(messageType == 6){
            if indexPath.row == 0{
                var myindex = indexPath
                for _ in 0...filteredData.count{
                    let currentCell = mytblView.cellForRow(at: myindex) as! AddMessageCell
                    if(currentCell.count % 2 == 0){
                        currentCell.count = currentCell.count + 1
                    }else{
                        currentCell.count = currentCell.count + 1
                    }
                    myindex.row = myindex.row + 1
                }
            }else{
                let currentCell = mytblView.cellForRow(at: indexPath) as! AddMessageCell
                if(currentCell.count % 2 == 0){
                    currentCell.count = currentCell.count + 1
                }else{
                    currentCell.count = currentCell.count + 1
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! AddMessageCell
        cell.selectionStyle = .none
        if messageType == 6{
            if indexPath.row == 0{
            }else{
            cell.RankingLabel.text = "Rank \(indexPath.row-1)"
            cell.RankingLabel.textColor = .systemGray2
            cell.selectionStyle = .none
            cell.myLabel.text = filteredData[indexPath.row-1].Username
            cell.imagePath = filteredData[indexPath.row-1].imageUrl ?? ""
            cell.uid = filteredData[indexPath.row-1].uid
            }
        }else{
            cell.RankingLabel.text = "Rank \(indexPath.row)"
            cell.RankingLabel.textColor = .systemGray2
            cell.myLabel.text = filteredData[indexPath.row].Username
            cell.imagePath = filteredData[indexPath.row].imageUrl ?? ""
            cell.uid = filteredData[indexPath.row].uid
        }
        cell.messageType = messageType
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        mytblView.register(AddMessageCell.self, forCellReuseIdentifier: "id")
        mytblView.dataSource = self
        mytblView.delegate = self
        searchUsersFromFirestore()
    }
    fileprivate func searchUsersFromFirestore(){
        var inputFirebase = "friend"
        if(messageType == 0){
            inputFirebase = "follower"
        }else if(messageType == 1){
            inputFirebase = "friend"
        }else if(messageType == 2){
            inputFirebase = "following"
        }else if(messageType == 3){
            inputFirebase = "users"
        }else if(messageType == 4){
            inputFirebase = "friend"
        }else if(messageType == 5){
            inputFirebase = "friend"
        }else if(messageType == 6){
            inputFirebase = "friend"
        }
        
        if(messageType == 4){
            let query = Firestore.firestore().collection("Messages").document(Auth.auth().currentUser?.uid ?? "").collection("Social").whereField("hasLastMsg", isEqualTo: false)
            query.addSnapshotListener {[weak self] (snapshot, error) in
                self?.filteredData = [User]()
                snapshot?.documents.forEach({ (snapshot2) in
                    let myDataUsr = snapshot2.data()
                    let Usrs = User(dictionary: myDataUsr)
                    self?.filteredData.append(Usrs)
                })
                self?.dataFirst = self?.filteredData ?? [User(dictionary: ["":""])]
                self?.mytblView.reloadData()
            }
        }else{
        let query = Firestore.firestore().collection("Messages").document(Auth.auth().currentUser?.uid ?? "").collection("Social").whereField("hasLastMsg", isEqualTo: true)
            query.addSnapshotListener {[weak self] (snapshot, error) in
                self?.filteredData = [User]()
                snapshot?.documents.forEach({ (snapshot2) in
                    let myDataUsr = snapshot2.data()
                    let Usrs = User(dictionary: myDataUsr)
                    self?.filteredData.append(Usrs)
                })
                self?.dataFirst = self?.filteredData ?? [User(dictionary: ["":""])]
                self?.mytblView.reloadData()
            }
        }
    }
    @objc fileprivate func NextHit(){
        self.delegate?.addToMap()
        self.dismiss(animated: true) {
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        //searchBarView.showsCancelButton = true
        filteredData = dataFirst
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        filteredData = dataFirst
        mytblView.reloadData()
        searchBar.endEditing(true)
    }
    fileprivate func searchUsers(text: String) -> Query{
        var inputFirebase = "friend"
        if(messageType == 0){
            inputFirebase = "follower"
        }else if(messageType == 1){
            inputFirebase = "friend"
        }else if(messageType == 2){
            inputFirebase = "following"
        }else if(messageType == 3){
            inputFirebase = "users"
        }else if(messageType == 4){
            inputFirebase = "friend"
        }else if(messageType == 5){
            inputFirebase = "friend"
        }else if(messageType == 6){
            inputFirebase = "friend"
        }
        if(messageType == 4){
            let db = Firestore.firestore().collection("Messages").document(Auth.auth().currentUser?.uid ?? "").collection("Social").whereField("hasLastMsg", isEqualTo: false).whereField("searchIndex", arrayContains: text)
            return db
        }else{
        let db = Firestore.firestore().collection("Users").document(Auth.auth().currentUser?.uid ?? "").collection("Social").whereField("relationship", isEqualTo: inputFirebase).whereField("searchIndex", arrayContains: text)
            return db
        }
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
                mytblView.reloadData()
            }
        }else if searchText.isEmpty == true{
            filteredData = dataFirst
            mytblView.reloadData()
        }
        }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    let Friends = UILabel()
    fileprivate func setupView(){
        Friends.backgroundColor = .systemGray6
        view.backgroundColor = .systemGray6
        searchBar.backgroundColor = .white
        Friends.font = .boldSystemFont(ofSize: 25)
        Friends.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(searchBar)
        if(messageType == 6){
            searchBar.anchor(top: myDatePicker.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        }else{
            searchBar.anchor(top: Friends.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        }
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "message friend"
        view.addSubview(mytblView)
        mytblView.anchor(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}
