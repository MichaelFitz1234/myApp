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
}
class plusButtonHitViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, AddMsgCellProtocl{
    var delegate: createAMapChallenge?
    let myButton = UIButton()
    let myDatePicker = UIDatePicker()
    func reportScoreHit(uid: String) {
        let messagesView = ReportAScore()
        messagesView.modalPresentationStyle = .fullScreen
        messagesView.modalPresentationStyle = .fullScreen
        let transition = CATransition()
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
        messagesView.uid = uidMsg
        messagesView.modalPresentationStyle = .fullScreen
        let transition = CATransition()
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
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: ScreenWidth/2.5, bottom: 0, right: 0))
                setupView()
            case 1:
                view.addSubview(Friends)
                Friends.text = "Friends"
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: ScreenWidth, bottom: 0, right: 0))
                setupView()
            case 2:
                view.addSubview(Friends)
                Friends.text = "Following"
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: ScreenWidth, bottom: 0, right: 0))
                setupView()
            case 3:
                view.addSubview(Friends)
                Friends.text = "Global Leaderboard"
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: ScreenWidth/1.7, bottom: 0, right: 0))
                setupView()
            case 4:
                view.addSubview(Friends)
                Friends.text = "Friends"
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: ScreenWidth, bottom: 0, right: 0))
                setupView()
            case 5:
                view.addSubview(Friends)
                Friends.text = "Friends"
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: ScreenWidth, bottom: 0, right: 0))
                setupView()
            case 6:
                view.addSubview(Friends)
                Friends.text = "Create Challenge"
                myButton.setTitle("Next", for: .normal)
                myButton.setTitleColor(.systemBlue, for: .normal)
                myButton.addTarget(self, action: #selector(NextHit), for: .touchUpInside)
                view.addSubview(myButton)
                myButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 5, bottom: 0, right: 0),size: .init(width: 70, height: 30))
                myButton.titleLabel?.adjustsFontSizeToFitWidth = true
                Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: ScreenWidth/1.5, bottom: 0, right: 0))
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
    
    
    var fullMessageData = [PlayerShort]()
    var filteredData = [PlayerShort]()
    fileprivate let searchBar = UISearchBar()
    fileprivate lazy var screenSize = UIScreen.main.bounds
    fileprivate lazy var ScreenWidth = (screenSize.width)/2.7
    fileprivate lazy var ScreenHeight = screenSize.height
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
            messagesView.uid = uidMsg
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
            messagesView.uid = filteredData[indexPath.row].uid
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
                cell.setupLayout(messageType: 7)
            }else{
                cell.RankingLabel.text = "Rank \(indexPath.row-1)"
                cell.RankingLabel.textColor = .systemGray2
                cell.setupLayout(messageType: messageType)
                cell.delegate = self
                cell.selectionStyle = .none
                cell.myLabel.text = filteredData[indexPath.row-1].Username
                let imgPath = filteredData[indexPath.row-1].profileImageUrl
                cell.uid = filteredData[indexPath.row-1].uid
                let storageRef = Storage.storage().reference(withPath: imgPath)
                storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
                    if let error = error{
                        print("Got an error fetching data: \(error.localizedDescription)")
                        return
                    }else{
                        if let data = data{
                            cell.myImg.image = UIImage(data: data)
                        }
                    }
                }
            }
        }else{
            cell.RankingLabel.text = "Rank \(indexPath.row)"
            cell.RankingLabel.textColor = .systemGray2
            cell.setupLayout(messageType: messageType)
            cell.delegate = self
            cell.myLabel.text = filteredData[indexPath.row].Username
            let imgPath = filteredData[indexPath.row].profileImageUrl
            cell.uid = filteredData[indexPath.row].uid
            let storageRef = Storage.storage().reference(withPath: imgPath)
            storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
                if let error = error{
                    print("Got an error fetching data: \(error.localizedDescription)")
                    return
                }else{
                    if let data = data{
                        cell.myImg.image = UIImage(data: data)
                    }
                }
            }
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        mytblView.register(AddMessageCell.self, forCellReuseIdentifier: "id")
        mytblView.dataSource = self
        mytblView.delegate = self
        searchUsersFromFirestore()
        filteredData = fullMessageData
    }
    fileprivate func searchUsersFromFirestore(){
        var inputFirebase = "Friends"
        if(messageType == 0){
            inputFirebase = "Followers"
        }else if(messageType == 1){
            inputFirebase = "Friends"
        }else if(messageType == 2){
            inputFirebase = "Following"
        }else if(messageType == 3){
            inputFirebase = "users"
        }else if(messageType == 4){
            inputFirebase = "Friends"
        }else if(messageType == 5){
            inputFirebase = "Friends"
        }else if(messageType == 6){
            inputFirebase = "Friends"
        }
        
        let currentUsr = Auth.auth().currentUser?.uid
        var query = Firestore.firestore().collection("users").document(currentUsr ?? "").collection("\(inputFirebase)").order(by: "timestamp", descending: true)
        if messageType == 3 {
            query = Firestore.firestore().collection("users")
        }
        query.getDocuments { (snapshot, err) in
            if let err = err{
                print("this is the", err)
                return
            }else{
                snapshot?.documents.forEach({ (documentSnapshot) in
                    let myUserInfo = documentSnapshot.data()
                    let user = PlayerShort(dictionary: myUserInfo)
                    if self.messageType == 4{
                        if user.lastMsg == "" || user.lastMsg == nil {
                            self.fullMessageData.append(user)
                        }
                        
                    }else{
                        self.fullMessageData.append(user)
                    }
                })
                self.filteredData = self.fullMessageData
                self.mytblView.reloadData()
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
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        self.filteredData = self.fullMessageData
        self.mytblView.reloadData()
        searchBar.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            filteredData = fullMessageData
        }else{
            filteredData = []
            fullMessageData.forEach { (person) in
                if(person.Username.range(of: searchText, options: .caseInsensitive) != nil){
                    filteredData.append(person)
                }
            }
        }
        mytblView.reloadData()
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
        view.addSubview(searchBar)
        if(messageType == 6){
            searchBar.anchor(top: myDatePicker.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        }else{
            searchBar.anchor(top: Friends.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        }
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "message friend"
        view.addSubview(mytblView)
        mytblView.anchor(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}
