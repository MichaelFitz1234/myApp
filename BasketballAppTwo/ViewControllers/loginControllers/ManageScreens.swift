//
//  manageScreens.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/16/21.
//

import UIKit
import FirebaseAuth
class ManageScreens: UINavigationController, firstPageProtocol, signedUp, LoginPageViewControllerProt, emailConfirmationScreen{
    func emailConfirmed() {
        let myTopView = myTabBarController()
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        popViewController(animated: false)
        pushViewController(myTopView, animated: false)
    }
    
    func signUpHit() {
        let myTopView = myTabBarController()
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        popViewController(animated: false)
        pushViewController(myTopView, animated: false)
    }
    
    func loginHit() {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let myTopView = myTabBarController()
        popViewController(animated: false)
        pushViewController(myTopView, animated: false)
    }
    
    func backHit() {
        popViewController(animated: true)
    }
    
    func removed() {
        popViewController(animated: true)
    }
    func myAccount() {
        let messageView = SignUpPageSignUp()
        messageView.delegate = self
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        popViewController(animated: true)
        pushViewController(messageView, animated: false)
    }
    func login1() {
        let messageView = LoginPageViewController()
        messageView.delegate = self
        messageView.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        popViewController(animated: true)
        pushViewController(messageView, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
        //this will be when the current user is nill
        if Auth.auth().currentUser?.uid != nil && Auth.auth().currentUser?.isEmailVerified == true{
            let myTopView = myTabBarController()
            pushViewController(myTopView, animated: false)
            popViewController(animated: true)
        //send to landing page if email isn't verified
        } else if Auth.auth().currentUser?.isEmailVerified == false && Auth.auth().currentUser?.uid != nil{
            let myTopView = ConfirmationEmailScreen()
            myTopView.delegate = self
            pushViewController(myTopView, animated: false)
            popViewController(animated: true)
        }
    }
}
