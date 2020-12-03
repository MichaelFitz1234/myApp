//
//  LoginPage.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 11/13/20.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
class LoginPage: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        email.layer.borderWidth = 3
        email.layer.borderColor = UIColor.black.cgColor
        email.layer.cornerRadius = 5
        password.layer.borderWidth = 3
        password.layer.borderColor = UIColor.black.cgColor
        password.layer.cornerRadius = 5
        login.layer.borderWidth = 1
        login.layer.borderColor = UIColor.black.cgColor
        login.layer.cornerRadius = 2
        
    }
    
    
    //this is used to transitino to the homescreen
    func transitionToHome() {
        let HomeViewController = self.storyboard?.instantiateViewController(identifier: "homePage")
        self.view.window?.rootViewController = HomeViewController
        self.view.window?.makeKeyAndVisible()

    }
    let registeringHUD = JGProgressHUD(style: .dark)
    fileprivate func showHUDWithError(error: Error) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    @IBAction func loginTapped(_ sender: Any) {
    let myFieldsFilled = validateFieldsFilled()
        let emailFinal = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pswrd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if(myFieldsFilled == nil){
            Auth.auth().signIn(withEmail: emailFinal, password: pswrd) { (result, error) in
                if error != nil{
                    self.showHUDWithError(error: error as! Error)
                }
                else{
                    self.transitionToHome()
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
