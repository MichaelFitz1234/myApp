//
//  LoginOrSignUpViewController.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/6/21.
//

import UIKit

class LoginOrSignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        let ScreenWidth = screenSize.width
        let screenHeight = screenSize.height
        let andOneLabel = UILabel()
        let CreateAccount = UIButton(type: .system)
        let myView = UIImageView()
        let image = UIImage(imageLiteralResourceName: "shootingImage")
        let login = UIButton(type: .system)
        view.addSubview(login)
        login.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: nil,padding: .init(top: 10, left: 45, bottom: 30, right: 0),size: .init(width: 300, height: 70))
        login.setTitle("Login", for: .normal)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = .darkGray
        view.backgroundColor = .systemGray6
        view.addSubview(CreateAccount)
    
        CreateAccount.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: login.topAnchor, trailing: nil,padding: .init(top: 30, left: 45, bottom: 10, right: 0),size: .init(width: 300, height: 70))
        CreateAccount.setTitle("Create Accournt", for: .normal)
        CreateAccount.setTitleColor(.lightGray, for: .normal)
        CreateAccount.titleLabel?.font = .boldSystemFont(ofSize: 16)
        CreateAccount.backgroundColor = .systemGray6
        let oneOnone = UILabel()
        view.addSubview(oneOnone)
        oneOnone.anchor(top: nil, leading: view.leadingAnchor, bottom: CreateAccount.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 38, bottom: screenHeight/22, right: 0))
        oneOnone.text = "Your 1v1 Basketball Journey Begins Here"
        oneOnone.textColor = .lightGray
        myView.image = image
        myView.image?.withRenderingMode(.alwaysOriginal)
        view.addSubview(myView)
        view.sendSubviewToBack(myView)
        myView.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: oneOnone.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: ScreenWidth, height: screenHeight/2))
   
        view.addSubview(andOneLabel)
        andOneLabel.anchor(top: nil, leading: view.leadingAnchor, bottom: myView.topAnchor, trailing: view.trailingAnchor,padding: .init(top: 0, left: ScreenWidth/2.5 + 7, bottom: 0, right: 0))
        andOneLabel.text = "andOne"
        andOneLabel.font = .italicSystemFont(ofSize: 16)
        andOneLabel.textColor = .lightGray
        CreateAccount.addTarget(self, action: #selector(myAccount), for: .touchUpInside)
        login.addTarget(self, action: #selector(login1), for: .touchUpInside)

    }
    @objc func myAccount(){
        let messageView = SignUpPageSignUp()
        messageView.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(messageView, animated: false, completion: nil)
    }
    @objc func login1(){
        let messageView = LoginPageViewController()
        messageView.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(messageView, animated: false, completion: nil)
    }
    
    

}
