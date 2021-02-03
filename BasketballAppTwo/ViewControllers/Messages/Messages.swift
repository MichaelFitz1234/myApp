//
//  Messages.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/18/20.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
class Messages: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    var uid = "" {
    didSet {
        let db = Firestore.firestore().collection("Users").document(uid)
        db.getDocument { (snapshot, error) in
            let myUserInfo = snapshot?.data()
            let user = User(dictionary: myUserInfo ?? ["":""])
            self.userName.text = user.Username
            let imgPath = user.imageUrl
            let storageRef = Storage.storage().reference(withPath: imgPath!)
            storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
            if let error = error{
            print("Got an error fetching data: \(error.localizedDescription)")
                return
                }else{
            if let data = data{
                self.usrImage.image = UIImage(data: data)
                }
            }
        }
        }
        //something
        let db2 = Firestore.firestore().collection("Messages").document(Auth.auth().currentUser?.uid ?? "").collection("Social").document(uid).collection("UsrMessages").order(by: "timestamp")
        db2.addSnapshotListener { (snapshot, error) in
            self.textMessages = [ChatMessages]()
            snapshot?.documents.forEach({ (documentSnapshot) in
                let myUserInfo = documentSnapshot.data()
                let message = ChatMessages(dictionary: myUserInfo)
                self.textMessages.append(message)
            })
            self.mytblView.reloadData()
            self.scrollToBottom(animated: false)
        }

        }
    }
    var shouldScroll = true
    var height = CGFloat(0)
    let myUser = Auth.auth().currentUser?.uid
    var booleanFirstTime = false
    var textMessages = [ChatMessages]()
    let topNavigation = UIView()
    let backButton = UIButton()
    let usrImage = UIImageView()
    let userName = UILabel()
    let mytblView = UITableView()
    let txtField = UITextField()
    let sendButton = UILabel()
    fileprivate lazy var screenSize = UIScreen.main.bounds
    fileprivate lazy var ScreenWidth = (screenSize.width)/2
    fileprivate lazy var ScreenHeight = screenSize.height
    fileprivate var someTopAnchor: NSLayoutYAxisAnchor!
    override func viewDidLoad() {
        //var someTopAnchor!
        super.viewDidLoad()
        mytblView.register(MessagesCellTableViewCell.self, forCellReuseIdentifier: "id")
        mytblView.separatorStyle = .none
        mytblView.dataSource = self
        mytblView.delegate = self
        txtField.delegate = self
        setupLayout()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        sendButton.isUserInteractionEnabled = true
        sendButton.addGestureRecognizer(tap)
       //someTopAnchor = topNavigation.bottomAnchor
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        txtField.returnKeyType = .send
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtField.text == ""{
        //do nothing
        }else{
            let timeStamp = Date()
            let db = Firestore.firestore().collection("Messages").document(myUser ?? "").collection("Social").document(uid)
            db.collection("UsrMessages").document().setData(["timestamp" : timeStamp, "incoming": false, "Message": txtField.text!])
            let db2 = Firestore.firestore().collection("Messages").document(uid ).collection("Social").document(myUser ?? "")
            db2.collection("UsrMessages").document().setData(["timestamp" : timeStamp, "incoming": true, "Message": txtField.text!])
            txtField.text = ""
            mytblView.reloadData()
           scrollToBottom(animated: true)
        }
        return true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            height = keyboardHeight
            let lineView = UIView()
            let myView = UIView()
            let imageView = UIImageView()
            topNavigation.removeFromSuperview()
            mytblView.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: txtField.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
            mytblView.heightAnchor.constraint(equalToConstant: ScreenHeight-keyboardHeight-180).isActive = true
            view.addSubview(myView)
            myView.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: mytblView.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
            myView.heightAnchor.constraint(equalToConstant: 70).isActive = true
            myView.addSubview(lineView)
            lineView.anchor(top: nil, leading: myView.leadingAnchor, bottom: myView.bottomAnchor, trailing: myView.trailingAnchor)
            lineView.heightAnchor.constraint(equalToConstant: 4).isActive = true
            lineView.backgroundColor = .systemGray6
            imageView.image = usrImage.image
            myView.addSubview(imageView)
            imageView.anchor(top: nil, leading: nil, bottom: myView.bottomAnchor, trailing: myView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 17, right: ScreenWidth), size: .init(width: 40, height: 40))
            imageView.backgroundColor = .gray
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            imageView.image?.withRenderingMode(.alwaysOriginal)
            let point = CGPoint(x: 0, y: self.mytblView.contentSize.height + self.mytblView.contentInset.bottom - self.mytblView.frame.height+keyboardHeight)
                    if point.y >= 0{
                        self.mytblView.setContentOffset(point, animated: true)
                    }
        }
    }
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let timeStamp = Date()
        let db = Firestore.firestore().collection("Messages").document(myUser ?? "").collection("Social").document(uid)
        db.collection("UsrMessages").document().setData(["timestamp" : timeStamp, "incoming": false, "Message": txtField.text!])
        let db2 = Firestore.firestore().collection("Messages").document(uid ).collection("Social").document(myUser ?? "")
        db2.collection("UsrMessages").document().setData(["timestamp" : timeStamp, "incoming": true, "Message": txtField.text!])
        db.updateData(["lastMsg" : txtField.text!])
        db2.updateData(["lastMsg" : txtField.text!])
        db.updateData(["hasLastMsg" : true])
        db2.updateData(["hasLastMsg" : true])
        db.updateData(["timestamp" : timeStamp])
        db2.updateData(["timestamp" : timeStamp])
        txtField.text = ""
        mytblView.reloadData()
        scrollToBottom(animated: true)
  
    }
    func scrollToBottom(animated: Bool){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.textMessages.count-1, section: 0)
            if(self.shouldScroll == true){
                if indexPath.row != -1 {
            self.mytblView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
            }
        }
    }
    var BottomVal = 8
    fileprivate func setupLayout() {
        let lineView = UIView()
        let img = UIImage(systemName: "arrow.left")
        view.backgroundColor = .white
        view.addSubview(topNavigation)
        topNavigation.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        topNavigation.heightAnchor.constraint(equalToConstant: 130).isActive = true
        topNavigation.backgroundColor = .white
        topNavigation.addSubview(backButton)
        topNavigation.addSubview(usrImage)
        topNavigation.addSubview(userName)
        topNavigation.addSubview(lineView)
        lineView.anchor(top: nil, leading: topNavigation.leadingAnchor, bottom: topNavigation.bottomAnchor, trailing: topNavigation.trailingAnchor)
        lineView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        lineView.backgroundColor = .systemGray6
        backButton.setImage(img, for: .normal)
        backButton.anchor(top: nil, leading: topNavigation.leadingAnchor, bottom: topNavigation.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 5, bottom: 35, right: 0),size: .init(width: 50, height: 50))
        backButton.addTarget(self, action: #selector(Click), for: .touchUpInside)
        usrImage.anchor(top: nil, leading: nil, bottom: topNavigation.bottomAnchor, trailing: topNavigation.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 30, right: ScreenWidth), size: .init(width: 40, height: 40))
        usrImage.backgroundColor = .gray
        usrImage.layer.cornerRadius = 20
        usrImage.clipsToBounds = true
        usrImage.image?.withRenderingMode(.alwaysOriginal)
        userName.anchor(top: usrImage.bottomAnchor, leading: nil, bottom: nil, trailing: topNavigation.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 0, right: ScreenWidth-5))
        //userName.text = "MitzyFitz"
        userName.font = .systemFont(ofSize: 14)
        view.addSubview(mytblView)
        mytblView.anchor(top: topNavigation.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 75, right: 0))
        view.addSubview(txtField)
        txtField.anchor(top: mytblView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: CGFloat(BottomVal), left: 8, bottom: 0, right: 15))
        txtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        txtField.backgroundColor = .systemGray6
        txtField.placeholder = "Send Message"
        txtField.borderStyle = .roundedRect
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //topNavigation.removeFromSuperview()
        setupLayout()
        let point = CGPoint(x: 0, y: self.mytblView.contentSize.height + self.mytblView.contentInset.bottom - self.mytblView.frame.height)
              if point.y >= 0{
                  self.mytblView.setContentOffset(point, animated: true)
              }
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let point = CGPoint(x: 0, y: self.mytblView.contentSize.height + self.mytblView.contentInset.bottom - self.mytblView.frame.height)
                if point.y >= 0{
                    self.mytblView.setContentOffset(point, animated: true)
                }
        if(textField.text != ""){
        txtField.addSubview(sendButton)
            sendButton.anchor(top: nil, leading: nil, bottom: txtField.bottomAnchor, trailing: txtField.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 8, right: 4))
        sendButton.text = "Send"
        sendButton.textColor = #colorLiteral(red: 0.2632973031, green: 0.8260380993, blue: 1, alpha: 1)
        }else{
            sendButton.removeFromSuperview()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath) as! MessagesCellTableViewCell
        cell.selectionStyle = .none
        cell.messageLabel.text = textMessages[indexPath.row].message
        cell.isIncomming = textMessages[indexPath.row].incoming
        return cell
    }

    @objc fileprivate func Click(){
    self.dismiss(animated: false, completion: nil)
    let transition = CATransition()
    transition.duration = 0.2
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromLeft
    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
    view.window!.layer.add(transition, forKey: kCATransition)
    self.dismiss(animated: true, completion: nil)
    }
}
