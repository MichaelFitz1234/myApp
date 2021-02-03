//
//  InAppMessaging.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/7/20.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
class InAppMessaging: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    var returnedUid = ""
    let mainView = UIView()
    let searchBar = UISearchBar()
    let tblview = UITableView()
    var myData = [lastMsg]()
    var filteredData = [lastMsg]()
    fileprivate func searchUsersFromFirestore(){
        let query = Firestore.firestore().collection("Messages").document(Auth.auth().currentUser?.uid ?? "").collection("Social").whereField("hasLastMsg", isEqualTo: true).order(by: "timestamp",descending: true).limit(to: 7)
        query.addSnapshotListener({ (snapshot2, error) in
            self.filteredData = [lastMsg]()
            snapshot2?.documents.forEach({ (snapshot2) in
                let myDataUsr = snapshot2.data()
                let Usrs = lastMsg(dictionary: myDataUsr)
                self.filteredData.append(Usrs)
            })
            self.myData = self.filteredData
            self.tblview.reloadData()
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    fileprivate func searchUsers(text: String) -> Query{
        let db = Firestore.firestore().collection("Messages").document(Auth.auth().currentUser?.uid ?? "").collection("Social").whereField("searchIndex", arrayContains: text).whereField("hasLastMsg", isEqualTo: true).limit(to: 5)
        return db
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
    messagesView.uid = uidMsg ?? ""
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
        let date2 = filteredData[indexPath.row].timestamp
        let date1 = date2?.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: (date1 ?? Date()))
        cell.myLabel.text = filteredData[indexPath.row].username
        cell.selectionStyle = .none
        cell.timeStamp.text = localDate
        cell.recentMsgs.text = filteredData[indexPath.row].lastMsg
        cell.myImgPath = filteredData[indexPath.row].imageUrl ?? ""
        return cell
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        //searchBarView.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.text = nil
       searchBar.setShowsCancelButton(false, animated: true)
        filteredData = myData
       self.tblview.reloadData()
       searchBar.endEditing(true)
   }
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchText.isEmpty == false){
            var tempArray = [lastMsg]()
            let query = searchUsers(text: searchText)
            query.getDocuments { [self] (snapshot, error) in
                snapshot?.documents.forEach({ (snapshot) in
                    let myData = snapshot.data()
                    let user = lastMsg(dictionary: myData)
                    tempArray.append(user)
                })
                self.filteredData = tempArray
                tblview.reloadData()
            }
        } else {
            filteredData = myData
            self.tblview.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchUsersFromFirestore()
        setupView()
        searchBar.delegate = self
        tblview.register(ContactsCell.self, forCellReuseIdentifier: "id")
        tblview.dataSource = self
        tblview.delegate = self
    }
    @objc fileprivate func addHit(){
        let controller = plusButtonHitViewController()
        controller.messageType = 4
        present(controller, animated: true, completion: nil)
    }
    fileprivate func setupView() {
        let messagesLabel = UILabel()
        let addButton = UIButton()
        let addImg = UIImage(systemName: "plus")
        view.addSubview(mainView)
        mainView.addSubview(addButton)
        mainView.addSubview(messagesLabel)
        mainView.addSubview(searchBar)
        view.addSubview(tblview)
        mainView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        mainView.backgroundColor = .white
        mainView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        messagesLabel.text = "Messages"
        messagesLabel.font = .boldSystemFont(ofSize: 25)
        messagesLabel.anchor(top: nil, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 10, bottom: 50, right: 0))
        addButton.addTarget(self, action: #selector(addHit), for: .touchUpInside)
        addImg?.withTintColor(.blue)
        addButton.setImage(addImg, for: .normal)
        addButton.anchor(top: nil, leading: nil, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 45, right: 15), size: .init(width: 45, height: 45))
        searchBar.anchor(top: messagesLabel.bottomAnchor, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor, padding: .init(top: 4, left: 5, bottom: 0, right: 8))
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Search"
        tblview.anchor(top: mainView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
}
