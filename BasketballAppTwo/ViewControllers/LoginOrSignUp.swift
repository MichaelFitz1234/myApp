//
//  LoginOrSignUp.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 11/11/20.
//

import UIKit

class LoginOrSignUp: UIViewController {
   
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //code to add borders to the buttons
        signUpButton.layer.borderWidth = 3
        signUpButton.layer.cornerRadius = 3
        signUpButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.cornerRadius = 3
    }
    //called when signup is tapped
    @IBAction func SignUpTapped(_ sender: Any) {
        transitionToCreate()
    }
    
    //this method transitions to the sign up page
    func transitionToCreate() {
        let HomeViewController = self.storyboard?.instantiateViewController(identifier: "SignUp")
        self.view.window?.rootViewController = HomeViewController
        self.view.window?.makeKeyAndVisible()

    }
    func transitionToLogin() {
        let HomeViewController = self.storyboard?.instantiateViewController(identifier: "Login")
        self.view.window?.rootViewController = HomeViewController
        self.view.window?.makeKeyAndVisible()

    }
    
    @IBAction func login(_ sender: Any) {
        transitionToLogin()
    }
    
}
