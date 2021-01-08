//
//  LoginPageViewController.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/6/21.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
class LoginPageViewController: UIViewController {
    let myStackView = UIStackView()
    let andOne = UILabel()
    let email = UITextField()
    let password = UITextField()
    let emailImage = UIImageView()
    let passwordImage = UIImageView()
    let login = UIButton(type: .system)
    let myImage2 = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let screenSize = UIScreen.main.bounds
        let ScreenWidth = screenSize.width
        let screenHeight = screenSize.height
        let emailPersonImg = UIImage(systemName: "person.circle.fill")
        let passwordLockImg = UIImage(systemName: "lock")
        emailImage.image = emailPersonImg
        passwordImage.image = passwordLockImg
        view.addSubview(andOne)
        andOne.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 50, left: ScreenWidth/2.5, bottom: 0, right: 0))
        andOne.text = "andOne"
        andOne.font = .italicSystemFont(ofSize: 16)
        andOne.textColor = .lightGray
        let myImage = UIImage(imageLiteralResourceName: "myImageBball")
        myImage2.image = myImage
        view.addSubview(myImage2)
        myImage2.anchor(top: andOne.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: ScreenWidth/2.9, bottom: 0, right: 0), size: .init(width: 100, height: 100))
        view.addSubview(email)
        email.anchor(top: myImage2.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 25, left: 25, bottom: 0, right: 25))
        email.heightAnchor.constraint(equalToConstant: 35).isActive = true
        email.placeholder = "Email"
        email.layer.cornerRadius = 6
        email.layer.borderWidth = 2
        email.layer.borderColor = UIColor.darkGray.cgColor
        view.addSubview(password)
        password.anchor(top: email.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 20, left: 25, bottom: 0, right: 25))
        password.heightAnchor.constraint(equalToConstant: 35).isActive = true
        password.placeholder = "Password"
        password.layer.cornerRadius = 6
        password.layer.borderWidth = 2
        password.layer.borderColor = UIColor.darkGray.cgColor
        email.addSubview(emailImage)
        email.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: email.frame.height))
        email.leftViewMode = .always
        emailImage.anchor(top: email.topAnchor, leading: nil, bottom: email.bottomAnchor, trailing: email.trailingAnchor, padding: .init(top: 2, left: 0, bottom: 2, right: 2))
        emailImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        emailImage.tintColor = .black
        password.addSubview(passwordImage)
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: password.frame.height))
        password.leftViewMode = .always
        passwordImage.anchor(top: password.topAnchor, leading: nil, bottom: password.bottomAnchor, trailing: password.trailingAnchor,padding: .init(top: 2, left: 0, bottom: 2, right: 2))
        passwordImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        passwordImage.tintColor = .black
        view.sendSubviewToBack(password)
        view.sendSubviewToBack(email)
        view.addSubview(login)
        login.anchor(top: password.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: 45, bottom: 0, right: 0),size: .init(width: 300, height: 70))
        login.setTitle("Login", for: .normal)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = .darkGray
        view.backgroundColor = .systemGray6
        login.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        let myImg = UIImage(systemName: "arrow.left")
        let backArrow = UIButton()
        backArrow.setImage(myImg, for: .normal)
        backArrow.addTarget(self, action: #selector(backHit), for: .touchUpInside)
        view.addSubview(backArrow)
        backArrow.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 15, bottom: 0, right: 0),size: .init(width: 20, height: 20))
      
    }
    let registeringHUD = JGProgressHUD(style: .dark)
    fileprivate func showHUDWithError(error: Error) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3)
    }
    @objc fileprivate func backHit(){
        let myController = LoginOrSignUpViewController()
        myController.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(myController, animated: false) {
        }
    }
    @objc func loginTapped() {
    let myFieldsFilled = validateFieldsFilled()
        let emailFinal = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pswrd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(myFieldsFilled == nil){
            Auth.auth().signIn(withEmail: emailFinal, password: pswrd) { (result, error) in
                if error != nil{
                    self.showHUDWithError(error: error as! Error)
                }
                else{
                    let myController = myTabBarController()
                    myController.modalPresentationStyle = .fullScreen
                    self.present(myController, animated: false) {
                    }
                }
            }
        }
    }
    func validateFieldsFilled() -> String?{
        if (email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ){
            return "please Fill in one of the Fileds"
        }
        else{return nil}
    }

}
