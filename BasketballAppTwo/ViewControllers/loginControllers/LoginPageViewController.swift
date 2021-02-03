//
//  LoginPageViewController.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/6/21.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
protocol LoginPageViewControllerProt {
    func backHit()
    func loginHit()
}
class LoginPageViewController: UIViewController {
    let myStackView = UIStackView()
    let andOne = UILabel()
    let email = UITextField()
    let password = UITextField()
    let emailImage = UIImageView()
    let passwordImage = UIImageView()
    let login = UIButton(type: .system)
    let myImage2 = UIImageView()
    let forgotPassworld = UIButton(type: .system)
    let registeringHUD = JGProgressHUD(style: .dark)
    var delegate: LoginPageViewControllerProt?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    //this is used to setup the view
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        let screenSize = UIScreen.main.bounds
        let ScreenWidth = screenSize.width
        let emailPersonImg = UIImage(systemName: "person.circle.fill")
        let passwordLockImg = UIImage(systemName: "lock")
        let myImage = UIImage(imageLiteralResourceName: "myImageBball")
        let myImg = UIImage(systemName: "arrow.left")
        let backArrow = UIButton()
        //adds subviews
        view.addSubview(andOne)
        view.addSubview(myImage2)
        view.addSubview(email)
        view.addSubview(password)
        view.addSubview(forgotPassworld)
        view.addSubview(login)
        view.addSubview(backArrow)
        //creates the targets for buttons
        login.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        backArrow.setImage(myImg, for: .normal)
        backArrow.addTarget(self, action: #selector(backHit), for: .touchUpInside)
        email.autocapitalizationType = .none
        password.autocapitalizationType = .none
        forgotPassworld.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        //setting up of views below
        password.isSecureTextEntry = true
        emailImage.image = emailPersonImg
        passwordImage.image = passwordLockImg
        andOne.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 50, left: ScreenWidth/2.5, bottom: 0, right: 0))
        andOne.text = "andOne"
        andOne.font = .italicSystemFont(ofSize: 16)
        andOne.textColor = .lightGray
        myImage2.image = myImage
        myImage2.anchor(top: andOne.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: ScreenWidth/2.9, bottom: 0, right: 0), size: .init(width: 100, height: 100))
        email.anchor(top: myImage2.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 25, left: 25, bottom: 0, right: 25))
        email.heightAnchor.constraint(equalToConstant: 35).isActive = true
        email.placeholder = "Email"
        email.layer.cornerRadius = 6
        email.layer.borderWidth = 2
        email.layer.borderColor = UIColor.darkGray.cgColor
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
        forgotPassworld.anchor(top: password.bottomAnchor, leading: password.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 100, bottom: 10, right: 0))
        forgotPassworld.setTitle("Forgot Password", for: .normal)
        forgotPassworld.setTitleColor(.systemGray, for: .normal)
        login.anchor(top: forgotPassworld.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: 45, bottom: 0, right: 0),size: .init(width: 300, height: 70))
        login.setTitle("Login", for: .normal)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = .darkGray
        view.backgroundColor = .systemGray6
        backArrow.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 15, bottom: 0, right: 0),size: .init(width: 20, height: 20))
        view.sendSubviewToBack(password)
        view.sendSubviewToBack(email)
        view.addSubview(forgotPassworld)
    }
    
    //this creates my hud
    fileprivate func showHUDWithError(error: Error) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 3)
    }
    func validateFieldsFilled() -> String?{
        if (email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ){
            return "please Fill in one of the Fileds"
        }
        else{return nil}
    }
    //goes to the back hit
    @objc fileprivate func backHit(){
        delegate?.backHit() 
    }
    //this method us used for hitting the login is hit to make sure the login is correct
    @objc func loginTapped() {
        let myFieldsFilled = validateFieldsFilled()
        let emailFinal = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pswrd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(myFieldsFilled == nil){
            Auth.auth().signIn(withEmail: emailFinal, password: pswrd) { (result, error) in
                if error != nil{
                    self.showHUDWithError(error: error!)
                }
                else{
                    self.delegate?.loginHit()
                }
            }
        }
    }
    @objc func resetPassword(){
        let myPswrd = PasswordReset()
        present(myPswrd, animated: true, completion: nil)
    }
    
}
