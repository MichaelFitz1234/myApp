//
//  ConfirmationEmailScreen.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/18/21.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
protocol emailConfirmationScreen {
    func emailConfirmed()
}
class ConfirmationEmailScreen: UIViewController {
    var count = 0
    var count2 = 0
    var delegate:emailConfirmationScreen?
    var email:String?
    let thankYou = UILabel()
    let andOne = UILabel()
    let myImage2 = UIImageView()
    let registeringHUD = JGProgressHUD(style: .dark)
    let changeEmailTxtField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            if(error != nil){
            self.showHUDWithError(error: error!)
            return
            }
        })
    }
    fileprivate func setupLayout(){
        view.backgroundColor = .white
        //variables
        let sendButton = UIButton(type: .system)
        let email = Auth.auth().currentUser?.email
        let resendEmail = UIButton(type: .system)
        let confirmEmail = UIButton(type: .system)
        let myImage = UIImage(imageLiteralResourceName: "myImageBball")
        let screenSize = UIScreen.main.bounds
        let ScreenWidth = screenSize.width
        //adding subviews
        view.addSubview(andOne)
        view.addSubview(resendEmail)
        view.addSubview(confirmEmail)
        view.addSubview(myImage2)
        view.addSubview(changeEmailTxtField)
        view.addSubview(sendButton)
        sendButton.addTarget(self, action: #selector(sendButtHit), for: .touchUpInside)
        resendEmail.addTarget(self, action: #selector(resendMyEmail), for: .touchUpInside)
        confirmEmail.addTarget(self, action: #selector(confirmButtonHit), for: .touchUpInside)
        andOne.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 50, left: ScreenWidth/2.5, bottom: 0, right: 0))
        andOne.text = "andOne"
        andOne.font = .italicSystemFont(ofSize: 16)
        andOne.textColor = .lightGray
        myImage2.image = myImage
        myImage2.anchor(top: andOne.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: ScreenWidth/2.9, bottom: 0, right: 0), size: .init(width: 100, height: 100))
        view.addSubview(thankYou)
        thankYou.anchor(top: myImage2.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        thankYou.numberOfLines = 0
        thankYou.font = .boldSystemFont(ofSize: 16)
        thankYou.textColor = .lightGray
        confirmEmail.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 45, bottom: 50, right: 0),size: .init(width: 300, height: 70))
        confirmEmail.setTitle("Proceede to App", for: .normal)
        confirmEmail.setTitleColor(.white, for: .normal)
        confirmEmail.backgroundColor = .darkGray
        
        resendEmail.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: confirmEmail.topAnchor, trailing: nil,padding: .init(top: 0, left: 45, bottom: 10, right: 0),size: .init(width: 300, height: 70))
        resendEmail.setTitle("Resend Confirmation Email", for: .normal)
        resendEmail.setTitleColor(.white, for: .normal)
        resendEmail.backgroundColor = .darkGray
        view.backgroundColor = .systemGray6
        thankYou.text = "Thank you for signing up one for andOne one more step and we can help you acheive your 1v1 goals check your email to confirm your email address then press procede to app"
        changeEmailTxtField.anchor(top: thankYou.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 80, left: 10, bottom: 0, right: 10))
        changeEmailTxtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        changeEmailTxtField.placeholder = email
        changeEmailTxtField.textAlignment = .center
        changeEmailTxtField.isUserInteractionEnabled = true
        sendButton.anchor(top: changeEmailTxtField.bottomAnchor, leading: myImage2.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: -7, bottom: 0, right: 0))
        sendButton.setTitle("Edit Email Address", for: .normal)
        }
    fileprivate func showHUDWithError(error: Error) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "\(error))"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
        }
    fileprivate func showWithString(string: String) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "\(string)"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    @objc fileprivate func sendButtHit(){
        if changeEmailTxtField.text != nil && count2 < 8 {
        Auth.auth().currentUser?.updateEmail(to: changeEmailTxtField.text!, completion: { (error) in
            if error != nil {
                self.showHUDWithError(error: error!)
            }
            Auth.auth().currentUser?.reload(completion: { (error) in
                self.count = 0
                self.count2 = self.count2+1
            })
          })
        }else if count2 >= 8{
            thankYou.text = "maximum number of email changes please contact us at andOne.app and we will resolve this issue"
            showWithString(string: "maximum number of email changes Hit")

        }
    }
    @objc fileprivate func resendMyEmail(){
        if count < 6 {
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            if(error != nil){
            self.showHUDWithError(error: error!)
            return
            }
        })
        showWithString(string: "Email Resent Please Go To Email and Verify Email")
        count = count + 1
        }else if count >= 6{
        showWithString(string: "You've hit our limit of 6 confirmation emails sent please double check email address")
        }
    }
    @objc fileprivate func confirmButtonHit(){
        Auth.auth().currentUser?.reload(completion: { (error) in
            if error != nil{
            }
            if Auth.auth().currentUser?.isEmailVerified == true {
                self.count = 0
                self.count2 = 0
                self.delegate?.emailConfirmed()
            }else{
                self.showWithString(string: "Please Go To Email and Verify Email")
            }
        })
    
    }
    }
    

