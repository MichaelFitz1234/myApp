//
//  InAppMessaging.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/7/20.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
class InAppMessaging: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    var returnedUid = ""
    let mainView = UIView()
    let searchBar = UISearchBar()
    let tblview = UITableView()
    let lastMessages = ["hello how","something","wanna play tm","dummytxt","bad at thinking of ideas","really bad at thinking of dummy txt","fucking can't think of dummy txt", "fuck", "sometextmessage"]
    let timeStamps = ["2am", "1:30am", "yesterday","yesterday", "Dec 19th","Dec 18th","Dec 15th","Dec 15th", "Dec 14th","Dec 14th"]
    var fullMessageData = PlayerShort(dictionary: ["uid" : "Any"])
    var data: [String] = []
    var filteredData: [String]!
    fileprivate func searchUsersFromFirestore(){
        let currentUsr = Auth.auth().currentUser?.uid
        let query = Firestore.firestore().collection("users").document(currentUsr ?? "").collection("Friends")
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
                self.filteredData = self.data
                self.tblview.reloadData()
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
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let messagesView = Messages()
    let query = Firestore.firestore().collection("Usernames").document("\(filteredData[indexPath.row])")
        query.getDocument { (snapshot, err) in
            let uidMsg = snapshot?.get("uid") as! String
            messagesView.uid = uidMsg
        }
    messagesView.modalPresentationStyle = .fullScreen
    let transition = CATransition()
    transition.duration = 0.25
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromRight
    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
    view.window!.layer.add(transition, forKey: kCATransition)
    present(messagesView, animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myImg = UIImageView()
        let myLabel = UILabel()
        let recentMsgs = UILabel()
        let timeStamp = UILabel()
        let pointingImage = UIImageView()
        let img = UIImage(systemName: "arrow.right")
        img?.withTintColor(.gray)
        pointingImage.image = img
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
        cell.addSubview(pointingImage)
        cell.addSubview(recentMsgs)
        cell.addSubview(timeStamp)
        timeStamp.text = timeStamps[indexPath.row]
        recentMsgs.anchor(top: nil, leading: myImg.trailingAnchor, bottom: myImg.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 3, bottom: 8, right: 0))
        recentMsgs.text = lastMessages[indexPath.row]
        recentMsgs.textColor = .gray
        recentMsgs.font = .systemFont(ofSize: 11, weight: UIFont.Weight(rawValue: 8))
        pointingImage.anchor(top: cell.topAnchor, leading: nil, bottom: nil, trailing: cell.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 8), size: .init(width: 18, height: 18))
        timeStamp.anchor(top: cell.topAnchor, leading: nil, bottom: nil, trailing: pointingImage.leadingAnchor, padding: .init(top: 6, left: 0, bottom: 0, right: 2))
        timeStamp.font = .italicSystemFont(ofSize: 11)
        timeStamp.textColor = .gray
        myImg.anchor(top: cell.topAnchor, leading: cell.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 10, bottom: 0, right: 0), size: .init(width: 40, height: 40))
        myLabel.anchor(top: cell.topAnchor, leading: myImg.trailingAnchor, bottom: nil, trailing: cell.trailingAnchor, padding: .init(top: 9, left: 4, bottom: 0, right: 0))
        myLabel.text = filteredData[indexPath.row]
        myLabel.textColor = .systemGray2
        myLabel.font = .systemFont(ofSize: 13, weight: UIFont.Weight(rawValue: 10))
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        //searchBarView.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.text = nil
       searchBar.setShowsCancelButton(false, animated: true)
       searchBar.endEditing(true)
   }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter({(dataString: String) -> Bool in
            return dataString.range(of: searchText, options: .caseInsensitive) != nil
        })
        tblview.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        searchBar.delegate = self
        tblview.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        tblview.dataSource = self
        tblview.delegate = self
        searchUsersFromFirestore()
        filteredData = data
    }
    fileprivate func setupView() {
        view.addSubview(mainView)
        mainView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        mainView.backgroundColor = .white
        mainView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        let messagesLabel = UILabel()
        messagesLabel.text = "Messages"
        mainView.addSubview(messagesLabel)
        messagesLabel.font = .boldSystemFont(ofSize: 25)
        messagesLabel.anchor(top: nil, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 10, bottom: 50, right: 0))
        let addButton = UIButton()
        let addImg = UIImage(systemName: "plus")
        addImg?.withTintColor(.blue)
        addButton.setImage(addImg, for: .normal)
        mainView.addSubview(addButton)
        addButton.anchor(top: nil, leading: nil, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 45, right: 15), size: .init(width: 45, height: 45))
        mainView.addSubview(searchBar)
        searchBar.anchor(top: messagesLabel.bottomAnchor, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor, padding: .init(top: 4, left: 5, bottom: 0, right: 8))
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        view.addSubview(tblview)
        tblview.anchor(top: mainView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}
