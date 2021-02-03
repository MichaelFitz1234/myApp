//
//  passwordReset.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/18/21.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
class PasswordReset: UIViewController {
    let changeEmailTxtField = UITextField()
    let registeringHUD = JGProgressHUD(style: .dark)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    fileprivate func setupLayout(){
        view.backgroundColor = .white
        //labels for buttons
        let myLabel = UILabel()
        let login = UIButton()
        //adds subviews
        view.addSubview(myLabel)
        view.addSubview(changeEmailTxtField)
        //add targets
        login.addTarget(self, action: #selector(sendAMsg), for: .touchUpInside)
        changeEmailTxtField.autocapitalizationType = .none
        myLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        myLabel.textAlignment = .center
        myLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        myLabel.backgroundColor = .gray
        myLabel.textColor = .white
        myLabel.text = "Reset Password"
        changeEmailTxtField.anchor(top: myLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 40, left: 10, bottom: 0, right: 10))
        changeEmailTxtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        changeEmailTxtField.placeholder = "Type Email To Send Reset Password"
        changeEmailTxtField.textAlignment = .center
        changeEmailTxtField.isUserInteractionEnabled = true
        view.addSubview(login)
        login.anchor(top: changeEmailTxtField.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 30, left: 45, bottom: 0, right: 0),size: .init(width: 300, height: 70))
        login.setTitle("Submit Reset", for: .normal)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = .darkGray
    }
    fileprivate func showHUDWithError() {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Issue Sending Password Reset Double Check Email, make sure is correct email for and one"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
        }
    fileprivate func showWithString(string: String) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "\(string)"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
        hud.perform {
            self.dismiss(animated: true) {
            }
        }
    }
    @objc fileprivate func sendAMsg(){
        if changeEmailTxtField.text != nil {
        let myEmail = changeEmailTxtField.text
        Auth.auth().sendPasswordReset(withEmail: myEmail!) { (error) in
            if error != nil {
                self.showHUDWithError()
            }else {
            self.showWithString(string: "password reset sent to email")
            }
        }
    }
    }
}
