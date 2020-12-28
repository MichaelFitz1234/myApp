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
class plusButtonHitViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate  {
    var fullMessageData = [PlayerShort]()
    var filteredData = [PlayerShort]()
    fileprivate let searchBar = UISearchBar()
    fileprivate lazy var screenSize = UIScreen.main.bounds
    fileprivate lazy var ScreenWidth = (screenSize.width)/2.7
    fileprivate lazy var ScreenHeight = screenSize.height
    fileprivate let mytblView = UITableView()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! AddMessageCell
        cell.selectionStyle = .none
        cell.myLabel.text = filteredData[indexPath.row].Username
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
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        searchBar.delegate = self
        mytblView.register(AddMessageCell.self, forCellReuseIdentifier: "id")
        mytblView.dataSource = self
        mytblView.delegate = self
        searchUsersFromFirestore()
        filteredData = fullMessageData
    }
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
                    if user.lastMsg == "" || user.lastMsg == nil {
                        self.fullMessageData.append(user)
                    }
                })
                self.filteredData = self.fullMessageData
                self.mytblView.reloadData()
            }
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
    fileprivate func setupView(){
        let Friends = UITextField()
        view.addSubview(Friends)
        Friends.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: ScreenWidth, bottom: 0, right: 0))
        Friends.backgroundColor = .systemGray6
        view.backgroundColor = .systemGray6
        searchBar.backgroundColor = .white
        Friends.text = "Friends"
        Friends.font = .boldSystemFont(ofSize: 25)
        view.addSubview(searchBar)
        searchBar.anchor(top: Friends.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "message friend"
        view.addSubview(mytblView)
        mytblView.anchor(top: searchBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}
