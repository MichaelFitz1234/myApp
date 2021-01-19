//
//  LoginOrSignUpViewController.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/6/21.
//

import UIKit
//MARK: create the delegate for the navigation controller
protocol firstPageProtocol {
    func myAccount()
    func login1()
}
class LoginOrSignUpViewController: UIViewController, UINavigationBarDelegate{
    //delegate that lives in the class
    var delegate: firstPageProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    //MARK: sets up layout and creates vasrs
    fileprivate func setupLayout() {
        //these are my varialbes used to create teh views
        let screenSize = UIScreen.main.bounds
        let ScreenWidth = screenSize.width
        let screenHeight = screenSize.height
        let andOneLabel = UILabel()
        let CreateAccount = UIButton(type: .system)
        let myView = UIImageView()
        let image = UIImage(imageLiteralResourceName: "shootingImage")
        let login = UIButton(type: .system)
        let oneOnone = UILabel()
        //creates the login views
        view.addSubview(login)
        view.addSubview(CreateAccount)
        view.addSubview(oneOnone)
        view.addSubview(myView)
        //targets sections
        CreateAccount.addTarget(self, action: #selector(myAccount), for: .touchUpInside)
        login.addTarget(self, action: #selector(login1), for: .touchUpInside)
        view.sendSubviewToBack(myView)
        //all other setup
        login.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil,padding: .init(top: 10, left: 45, bottom: 30, right: 0),size: .init(width: 300, height: 70))
        login.setTitle("Login", for: .normal)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = .darkGray
        view.backgroundColor = .systemGray6
        CreateAccount.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: login.topAnchor, trailing: nil,padding: .init(top: 30, left: 45, bottom: 10, right: 0),size: .init(width: 300, height: 70))
        CreateAccount.setTitle("Create Accournt", for: .normal)
        CreateAccount.setTitleColor(.lightGray, for: .normal)
        CreateAccount.titleLabel?.font = .boldSystemFont(ofSize: 16)
        CreateAccount.backgroundColor = .systemGray6
        oneOnone.anchor(top: nil, leading: view.leadingAnchor, bottom: CreateAccount.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 38, bottom: screenHeight/22, right: 0))
        oneOnone.text = "Your 1v1 Basketball Journey Begins Here"
        oneOnone.textColor = .lightGray
        myView.image = image
        myView.image?.withRenderingMode(.alwaysOriginal)
        myView.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: oneOnone.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: ScreenWidth, height: screenHeight/2))
        view.addSubview(andOneLabel)
        andOneLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: myView.topAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: ScreenWidth/2.5 + 7, bottom: 0, right: 0))
        andOneLabel.text = "andOne"
        andOneLabel.font = .italicSystemFont(ofSize: 16)
        andOneLabel.textColor = .lightGray

    }
    //MARK: this is the buttons sections
    //MARK: this goes to the account login
    @objc func myAccount(){
        self.delegate?.myAccount()
    }
    //MARK: Transition to login page
    @objc func login1(){
        self.delegate?.login1()
    }
}
