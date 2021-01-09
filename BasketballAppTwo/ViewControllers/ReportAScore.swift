//
//  ReportAScore.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/4/21.
//
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
    lazy var screenWidth = screenSize.width
    
     func setupMyUserFromFirebase(){
        let myUser = uid
        let docRef = Firestore.firestore().collection("users").document(myUser)
        docRef.getDocument { (snapshot, error) in
            let myImage = snapshot?.get("imagePath") as! String
            let myData = snapshot?.get("username") as! String
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
    override func viewDidLoad() {
        super.viewDidLoad()
        nextUsrImg.clipsToBounds = true
        currentUsrImg.clipsToBounds = true
        setupLayout()
    }
    var count = 1
    var previousNumberValue = 1
    @objc fileprivate func submitHit(){
        var myArrayOfIntsp1 = [String]()
        var myArrayOfIntsp2 = [String]()
        stackView.subviews.forEach { (stackView) in
            let myStack = stackView as! ReportScoreStackCell
            let s1 = myStack.score1.text
            let s2 = myStack.score2.text
            myArrayOfIntsp1.append(s1 ?? "")
            myArrayOfIntsp2.append(s2 ?? "")
        }
        let db = Firestore.firestore().collection("scores").document(self.uid).collection(currentUsr1)
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
