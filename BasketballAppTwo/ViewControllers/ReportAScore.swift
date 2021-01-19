//  ReportAScore.swift
//  BasketballAppTwo
//  Created by Michael  on 1/4/21.
import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
class ReportAScore: UIViewController {
    let numberOfGamesBar = UISlider()
    let numberValue = UILabel()
    let stackView = UIStackView()
    let screenSize: CGRect = UIScreen.main.bounds
    let currentUsrImg = UIImageView()
    let nextUsrImg = UIImageView()
    var uid = ""
    var username1 = ""
    var username2 = ""
    var currentUsr1 = ""
    var p1Elo:Int?
    var p2Elo:Int?
    lazy var screenWidth = screenSize.width
     func setupMyUserFromFirebase(){
        let myUser = uid
        let docRef = Firestore.firestore().collection("users").document(myUser)
        docRef.getDocument { (snapshot, error) in
            let myImage = snapshot?.get("imagePath") as! String
            let myData = snapshot?.get("username") as! String
            self.p2Elo = snapshot?.get("currElo") as! Int
            self.username2 = myData
            let storageRef = Storage.storage().reference(withPath: myImage)
            storageRef.getData(maxSize: 4*1024*1024) { [self] (data, error) in
            if let error = error{
            print("Got an error fetching data: \(error.localizedDescription)")
                return
                }else{
            if let data = data{
                self.nextUsrImg.image = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "Image")
                        }
                    }
                }
        }
        let myUser2 = Auth.auth().currentUser?.uid ?? ""
        self.currentUsr1 = myUser2
        let docRef2 = Firestore.firestore().collection("users").document(myUser2)
        docRef2.getDocument { (snapshot, error) in
            let myImage = snapshot?.get("imagePath") as! String
            let myData = snapshot?.get("username") as! String
            self.p1Elo = snapshot?.get("currElo") as! Int
            self.username1 = myData
            let storageRef = Storage.storage().reference(withPath: myImage)
            storageRef.getData(maxSize: 4*1024*1024) { [self] (data, error) in
            if let error = error{
            print("Got an error fetching data: \(error.localizedDescription)")
                return
                }else{
            if let data = data{
                self.currentUsrImg.image = UIImage(data: data) ?? UIImage(imageLiteralResourceName: "Image")
                self.createInitialValue()
                        }
                    }
                }
        }
    }
    func setupLayout() {
        let navigationView = UIView()
        view.backgroundColor = .white
        view.addSubview(navigationView)
        navigationView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        navigationView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        let myView2 = UIView()
        view.addSubview(myView2)
        myView2.anchor(top: nil, leading: view.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: view.trailingAnchor)
        myView2.heightAnchor.constraint(equalToConstant: 3).isActive = true
        myView2.backgroundColor = .systemGray6
        let myImg = UIImage(systemName: "arrow.left")
        let backArrow = UIButton()
        backArrow.setImage(myImg, for: .normal)
        backArrow.addTarget(self, action: #selector(backHit), for: .touchUpInside)
        navigationView.addSubview(backArrow)
        backArrow.anchor(top: nil, leading: view.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 15, bottom: 35, right: 0),size: .init(width: 20, height: 20))
        navigationView.addSubview(currentUsrImg)
        currentUsrImg.image?.withRenderingMode(.alwaysOriginal)
        currentUsrImg.layer.cornerRadius = 20
        navigationView.addSubview(nextUsrImg)
        currentUsrImg.anchor(top: nil, leading: view.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: screenWidth/3, bottom: 30, right: 0), size: .init(width: 40, height: 40))
        let myLabel = UILabel()
        navigationView.addSubview(myLabel)
        myLabel.text = "Vs."
        myLabel.anchor(top: nil, leading: currentUsrImg.trailingAnchor, bottom: navigationView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 13, bottom: 35, right: 0))
        nextUsrImg.image?.withRenderingMode(.alwaysOriginal)
        nextUsrImg.contentMode = .scaleAspectFill
        nextUsrImg.layer.cornerRadius = 20
        nextUsrImg.anchor(top: nil, leading: myLabel.trailingAnchor, bottom: navigationView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 30, right: 0),size: .init(width: 40, height: 40))
        
        nextUsrImg.backgroundColor = .gray
        let numberOfGames = UILabel()
        numberOfGames.text = "Number of game played:"
        view.addSubview(numberOfGames)
        numberOfGames.anchor(top: navigationView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: screenWidth/4, bottom: 0, right: 0))
        view.addSubview(numberValue)
        numberValue.anchor(top: numberOfGames.bottomAnchor, leading: nil, bottom: nil, trailing: numberOfGames.trailingAnchor,padding: .init(top: 3, left: 0, bottom: 0, right: 80))
        numberValue.text = "1"
        view.addSubview(numberOfGamesBar)
        numberOfGamesBar.anchor(top: numberValue.bottomAnchor, leading: numberOfGames.leadingAnchor, bottom: nil, trailing: numberOfGames.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        numberOfGamesBar.minimumValue = 1
        numberOfGamesBar.maximumValue = 10
        numberValue.text = String(Int(numberOfGamesBar.value))
        numberOfGamesBar.addTarget(self, action: #selector(hitSlider), for: .allEvents)
        stackView.axis = .vertical
        stackView.isUserInteractionEnabled = true
        let Scrollview = UIScrollView()
        Scrollview.isUserInteractionEnabled = true
        let submitButton = UIButton(type: .system)
        submitButton.tintColor = .white
        view.addSubview(submitButton)
        submitButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: screenWidth/3, bottom: 40, right: 0), size: .init(width: 130, height: 60))
        submitButton.layer.cornerRadius = 14
        submitButton.setTitle("Submit Score", for: .normal)
        submitButton.backgroundColor = .systemGray
        submitButton.titleLabel?.textColor = .white
        submitButton.addTarget(self, action: #selector(submitHit), for: .touchUpInside)
        view.addSubview(Scrollview)
        Scrollview.anchor(top: numberOfGamesBar.bottomAnchor, leading: view.leadingAnchor, bottom: submitButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        Scrollview.addSubview(stackView)
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.anchor(top: Scrollview.topAnchor, leading: Scrollview.leadingAnchor, bottom: Scrollview.bottomAnchor, trailing: Scrollview.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    func createInitialValue(){
        let reportCell = ReportScoreStackCell()
        reportCell.username.text = username1
        reportCell.username2.text = username2
        reportCell.setupLayout()
        reportCell.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
        reportCell.scoreValue = count
        reportCell.isUserInteractionEnabled = true
        stackView.addArrangedSubview(reportCell)
    }
    fileprivate func createElo(myArray: [Double]) -> [Double]{
        var Ra = myArray[0]
        var Rb = myArray[1]
        var Sa = myArray[2]
        var Sb = myArray[3]
        let total = Sa + Sb
        Sa = Sa / total
        Sb = Sb / total
        //let nGames = myArray[4]
        let myTempValue1 = (Rb-Ra)/400
        let myTempValue2 = (Ra-Rb)/400
        let Ea = 1/(1+pow(10,myTempValue1))
        let Eb = 1/(1+pow(10,myTempValue2))
        let k = 50.0
        Ra = Ra + k * (Sa-Ea)
        Rb = Rb + k * (Sb-Eb)
        let finalReturned = round(Ra)
        let finalReturned2 = round(Rb)
        return [finalReturned,finalReturned2]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nextUsrImg.clipsToBounds = true
        currentUsrImg.clipsToBounds = true
        setupLayout()
    }
    var count = 1
    var previousNumberValue = 1
    @objc fileprivate func submitHit(){
        let date = Date()
        var myArrayOfIntsp1 = [Int]()
        var myArrayOfIntsp2 = [Int]()
        var gamesForP1 = 0
        var gamesForP2 = 0
        var changingElo = Double(p1Elo ?? 0)
        var changingElo2 = Double(p2Elo ?? 0)
        stackView.subviews.forEach { (stackView) in
            let myStack = stackView as! ReportScoreStackCell
            let s1 = Double(Int(myStack.score1.text ?? "0") ?? 0)
            let s2 = Double(Int(myStack.score2.text ?? "0") ?? 0)
            let myVar = createElo(myArray: [changingElo,changingElo2,s1,s2])
            changingElo = myVar[0]
            changingElo2 = myVar[1]
            if s1 > s2 {
                gamesForP1 = gamesForP1 + 1
            }else if s2 > s1 {
                gamesForP2 = gamesForP2 + 1
            }else{
            }
            p1Elo = Int(changingElo)
            p2Elo = Int(changingElo2)
            myArrayOfIntsp1.append(Int(s1))
            myArrayOfIntsp2.append(Int(s2))
        }
        //this section is where the elo calcuation will happen
        Firestore.firestore().collection("scores").document(self.uid).collection("gameScores").document().setData(["player1" : currentUsr1, "player2": uid, "player1Score": myArrayOfIntsp1, "player2Score": myArrayOfIntsp2, "timestamp" : date, "gamesP1": gamesForP1, "gamesP2": gamesForP2])
        Firestore.firestore().collection("scores").document(self.currentUsr1).collection("gameScores").document().setData(["player1" : currentUsr1, "player2": uid, "player1Score": myArrayOfIntsp1, "player2Score": myArrayOfIntsp2, "timestamp" : date, "gamesP1": gamesForP1, "gamesP2": gamesForP2])
        Firestore.firestore().collection("elo").document(self.currentUsr1).collection("gameScores").document().setData(["Elo" : self.p1Elo ?? 0, "timestamp": date])
        Firestore.firestore().collection("elo").document(uid).collection("gameScores").document().setData(["Elo" : self.p2Elo ?? 0, "timestamp": date])
        Firestore.firestore().collection("users").document(currentUsr1).updateData(["currElo" : p1Elo ?? 0])
        Firestore.firestore().collection("users").document(uid).updateData(["currElo" : p2Elo ?? 0])

        let myController = myTabBarController()
        myController.modalPresentationStyle = .fullScreen
        myController.selectedIndex = 2
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(myController, animated: false) {
        }
    }
    @objc fileprivate func backHit(){
        let myController = myTabBarController()
        myController.modalPresentationStyle = .fullScreen
        myController.selectedIndex = 2
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(myController, animated: false) {
        }
    }
    @objc fileprivate func hitSlider(){
        numberValue.text = String(Int(numberOfGamesBar.value))
        if(Int(numberOfGamesBar.value) - previousNumberValue > 0){
            let difference = abs(Int(numberOfGamesBar.value) - previousNumberValue)
            for _ in 1...difference {
                let reportCell = ReportScoreStackCell()
                reportCell.username.text = username1
                reportCell.username2.text = username2
                reportCell.setupLayout()
                reportCell.widthAnchor.constraint(equalToConstant: screenWidth).isActive = true
                count = count + 1
                reportCell.scoreValue = count
                stackView.addArrangedSubview(reportCell)
            }
        }else if(Int(numberOfGamesBar.value) - previousNumberValue < 0){
            let difference = abs(Int(numberOfGamesBar.value) - previousNumberValue)
            for _ in 1...difference {
            count = count - 1
            stackView.subviews.last?.removeFromSuperview()
            }
        }
        previousNumberValue = Int(numberOfGamesBar.value)
    }
}
