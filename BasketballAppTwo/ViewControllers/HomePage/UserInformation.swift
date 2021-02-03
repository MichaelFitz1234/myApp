//  UserInformation.swift
//  BasketballAppTwo
//  Created by Michael Fitzgerald on 12/5/20.
import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
class UserInformation: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    let navigationBar = UIView()
    let navBarText = UILabel()
    let leftPicture = InformationLeftImage(image: nil)
    let rightText = InformationRight()
    let myTable = UITableView()
    var homeUsrImage = UIImage()
    var CurrentUsr:User?
    var currentImg = UIImage()
    var myArrayOfElements = [GameScore]()
    fileprivate lazy var screenSize = UIScreen.main.bounds
    fileprivate lazy var ScreenWidth = screenSize.width-80
    var myUsr:String = "" {
        didSet{
            getGamesFB()
            Firestore.firestore().collection("Users").document(myUsr).getDocument{ (snapshot, error) in
                let data = snapshot?.data()
                let myUsr = User(dictionary: data ?? ["":""])
                self.CurrentUsr = myUsr
                self.leftPicture.ELo.text = String(myUsr.Elo ?? 0)
                self.leftPicture.Username.text = myUsr.Username
                let storageRef = Storage.storage().reference(withPath: myUsr.imageUrl ?? "")
                storageRef.getData(maxSize: 4*1024*1024) { [self] (data, error) in
                if let error = error{
                print("Got an error fetching data: \(error.localizedDescription)")
                    return
                    }else{
                if let data = data{
                    currentImg = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "Image")
                    self.leftPicture.image = currentImg
                    self.myTable.reloadData()
                            }
                        }
                    }
            }
        }
       
    }

    func getGamesFB(){
        let myRef = Firestore.firestore().collection("Scores").document(myUsr).collection("GameScores").order(by: "timestamp")
            myRef.getDocuments{ (snapshot, error) in
                snapshot?.documents.forEach({ (documentSnapshot) in
                let myData = documentSnapshot.data()
                let myScoreDoc = GameScore(dictionary: myData)
                self.myArrayOfElements.append(myScoreDoc)
            })
        }
    }
    lazy var myScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.contentInsetAdjustmentBehavior = .never
        sv.delegate = self
        return sv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let bottomDivider = UIView()
        let myLabel = UITextField()
        let bottomDivider1 = UIView()
        view.addSubview(navigationBar)
        view.addSubview(bottomDivider)
        view.addSubview(leftPicture)
        view.addSubview(rightText)
        view.addSubview(myLabel)
        view.addSubview(myTable)
        self.myTable.register(reportScoreCell.self, forCellReuseIdentifier: "cell")
        myTable.delegate = self
        myTable.dataSource = self
        myTable.separatorStyle = .none
        view.backgroundColor = .white
        navigationBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        navigationBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        navigationBar.backgroundColor = .systemGray6
        navigationBar.addSubview(navBarText)
        navBarText.anchor(top: navigationBar.topAnchor, leading: navigationBar.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: ScreenWidth/2, bottom: 0, right: 0))
        navBarText.text = "Player Details"
        navBarText.textColor = .black
        navBarText.font = .systemFont(ofSize: 15, weight: .bold)
        bottomDivider.anchor(top: nil, leading: view.leadingAnchor, bottom: navigationBar.bottomAnchor, trailing: view.trailingAnchor)
        bottomDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider.backgroundColor = .systemGray3
        leftPicture.anchor(top: navigationBar.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 3, left: 0, bottom: 0, right: 0))
        leftPicture.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55).isActive = true
        leftPicture.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        rightText.anchor(top: navigationBar.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor)
        rightText.backgroundColor = .white
        rightText.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        rightText.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        myLabel.anchor(top: leftPicture.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 10, bottom: 16, right: 10))
        myLabel.text = "Games:"
        myTable.anchor(top: myLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        myTable.backgroundColor = .white
        view.addSubview(bottomDivider1)
        bottomDivider1.anchor(top: nil, leading: view.leadingAnchor, bottom: myLabel.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 4, left: 10, bottom: 0, right: 10))
        bottomDivider1.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider1.backgroundColor = .systemGray6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myArrayOfElements.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (self.myTable.dequeueReusableCell(withIdentifier: "cell") as! reportScoreCell?)!
        cell.selectionStyle = .none
        cell.myImg.image = self.currentImg
        let a1 = String(myArrayOfElements[indexPath.section].gamesP2 ?? 0)
        let a2 = String(myArrayOfElements[indexPath.section].gamesP1 ?? 0)
        var myMutableString = NSMutableAttributedString()
        if (myArrayOfElements[indexPath.section].gamesP1 ?? 0 < myArrayOfElements[indexPath.section].gamesP2 ?? 0){
            let myString:NSString = "Games: \(a1)-\(a2) W" as NSString
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSRange(location:11,length:1))
        }else {
            let myString:NSString = "Games: \(a1)-\(a2) L" as NSString
            myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:11,length:1))
        }
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:10))
        cell.gameScore.attributedText = myMutableString
        Firestore.firestore().collection("Users").document(myArrayOfElements[indexPath.section].player1 ?? "").getDocument{ (snapshot, error) in
        let data = snapshot?.data()
        let myUsr = User(dictionary: data ?? ["":""])
        cell.myLabel.text = "\(String((self.CurrentUsr?.Username) ?? "")) Vs. \(myUsr.Username ?? "") \(Int(myUsr.Elo ?? 0))"
        //Create Cell Username Elo
        let storageRef = Storage.storage().reference(withPath: myUsr.imageUrl ?? "")
        storageRef.getData(maxSize: 4*1024*1024) { [weak self] (data, error) in
        if let error = error{
        print("Got an error fetching data: \(error.localizedDescription)")
                return
            }else{
        if let data = data{
            let img = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "Image")
            cell.myImg2.image = img
                        }
                    }
                }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messagesView = ViewScore()
        messagesView.uid = myArrayOfElements[indexPath.section].player2 ?? ""
        messagesView.myGame =  myArrayOfElements[indexPath.section]
        messagesView.userUID = myArrayOfElements[indexPath.section].player1 ?? ""
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
}
