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
    var fullMessageData = [PlayerShort]()
    var filteredData = [PlayerShort]()
    fileprivate func searchUsersFromFirestore(){
        let currentUsr = Auth.auth().currentUser?.uid
        let query = Firestore.firestore().collection("users").document(currentUsr ?? "").collection("Friends").order(by: "timestamp", descending: true)
        query.getDocuments { (snapshot, err) in
            if let err = err{
              print("this is the", err)
              return
            }else{
                snapshot?.documents.forEach({ (documentSnapshot) in
                    let myUserInfo = documentSnapshot.data()
                    let user = PlayerShort(dictionary: myUserInfo)
                    if user.lastMsg != "" && user.lastMsg != nil {
                        self.fullMessageData.append(user)
                    }
                })
                self.filteredData = self.fullMessageData
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
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! ContactsCell
        cell.myLabel.text = filteredData[indexPath.row].Username
        cell.selectionStyle = .none
        let date2 = filteredData[indexPath.row].timestamp
        let date1 = date2?.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: (date1 ?? Date()))
        cell.timeStamp.text = localDate
        cell.recentMsgs.text = filteredData[indexPath.row].lastMsg
        let imgPath = filteredData[indexPath.row].profileImageUrl
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
        return cell
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        //searchBarView.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.text = nil
       searchBar.setShowsCancelButton(false, animated: true)
       self.filteredData = self.fullMessageData
       self.tblview.reloadData()
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
        tblview.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        searchBar.delegate = self
        tblview.register(ContactsCell.self, forCellReuseIdentifier: "id")
        tblview.dataSource = self
        tblview.delegate = self
        searchUsersFromFirestore()
        filteredData = fullMessageData
    }
    @objc fileprivate func addHit(){
        let controller = plusButtonHitViewController()
        controller.messageType = 4
        present(controller, animated: true, completion: nil)
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
        addButton.addTarget(self, action: #selector(addHit), for: .touchUpInside)
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
