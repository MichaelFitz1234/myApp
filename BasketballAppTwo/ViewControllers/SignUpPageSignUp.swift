//
//  SignUpPageSignUp.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/6/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import JGProgressHUD
class SignUpPageSignUp: UIViewController {
    let scrollView = UIScrollView()
    let myImage = UIButton()
    let DOB = UITextField()
    let username = UITextField()
    let email = UITextField()
    let passwrod =  UITextField()
    let signUp = UIButton(type: .system)
    let selectImageLabel = UILabel()
    var imagePicker: ImagePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        let screenSize = UIScreen.main.bounds
        let ScreenWidth = screenSize.width
        let screenHeight = screenSize.height
        //scrollView.addSubview(view)
        view.addSubview(myImage)
        view.backgroundColor = .white
        myImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        myImage.heightAnchor.constraint(equalToConstant: 350).isActive = true
        myImage.layer.cornerRadius = 3
        myImage.layer.borderWidth = 3
        myImage.layer.borderColor = UIColor.systemGray2.cgColor
        myImage.addTarget(self, action: #selector(ImageHit), for: .touchUpInside)
        myImage.addSubview(selectImageLabel)
        selectImageLabel.anchor(top: myImage.topAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 180, left: ScreenWidth/3.7, bottom: 0, right: 0))
        selectImageLabel.text = "Add an image"
        view.addSubview(DOB)
        DOB.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: DOB.frame.height))
        DOB.leftViewMode = .always
        DOB.anchor(top: myImage.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        DOB.heightAnchor.constraint(equalToConstant: 35).isActive = true
        DOB.placeholder = "Date of birth mm/dd/yyyy"
        DOB.layer.cornerRadius = 6
        DOB.layer.borderWidth = 2
        DOB.layer.borderColor = UIColor.darkGray.cgColor
        view.addSubview(username)
        username.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: username.frame.height))
        username.leftViewMode = .always
        username.anchor(top: DOB.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        username.heightAnchor.constraint(equalToConstant: 35).isActive = true
        username.placeholder = "Username"
        username.layer.cornerRadius = 6
        username.layer.borderWidth = 2
        username.layer.borderColor = UIColor.darkGray.cgColor
        view.addSubview(email)
        email.anchor(top: username.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        email.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: email.frame.height))
        email.leftViewMode = .always
        email.heightAnchor.constraint(equalToConstant: 35).isActive = true
        email.placeholder = "Email"
        email.layer.cornerRadius = 6
        email.layer.borderWidth = 2
        email.layer.borderColor = UIColor.darkGray.cgColor
        view.addSubview(passwrod)
        passwrod.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: passwrod.frame.height))
        passwrod.leftViewMode = .always
        passwrod.anchor(top: email.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        passwrod.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: passwrod.frame.height))
        passwrod.anchor(top: email.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        passwrod.heightAnchor.constraint(equalToConstant: 35).isActive = true
        passwrod.placeholder = "Password"
        passwrod.layer.cornerRadius = 6
        passwrod.layer.borderWidth = 2
        passwrod.layer.borderColor = UIColor.darkGray.cgColor
        view.addSubview(signUp)
        signUp.anchor(top: passwrod.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 45, bottom: 0, right: 0),size: .init(width: 300, height: 70))
        signUp.setTitle("Sign Up", for: .normal)
        signUp.setTitleColor(.white, for: .normal)
        signUp.backgroundColor = .darkGray
        signUp.addTarget(self, action: #selector(signUpHit), for: .touchUpInside)
        view.backgroundColor = .systemGray6
        let myImg = UIImage(systemName: "arrow.left")
        let backArrow = UIButton()
        backArrow.setImage(myImg, for: .normal)
        backArrow.addTarget(self, action: #selector(backHit), for: .touchUpInside)
        view.addSubview(backArrow)
        backArrow.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 15, bottom: 0, right: 0),size: .init(width: 20, height: 20))
    }
    @objc fileprivate func ImageHit(){
        self.imagePicker.present(from: self.view)
        myImage.layer.borderWidth = 0
        selectImageLabel.removeFromSuperview()
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
    let registeringHUD = JGProgressHUD(style: .dark)
    fileprivate func showHUDWithError(error: Error) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    @objc func signUpHit(_ sender: Any) {
        let error = validateFieldsFilled()
        if error == nil {
            let date = NSDate()
            //clean up the field that exist
            let DOB1 = DOB.text!
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateOfBirth = dateFormatter.date(from: DOB1)
            let Username = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email1 = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwrod.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email1, password: password) { (result, err) in
                if(err != nil){
                    self.showHUDWithError(error: err!)
                    return
                    //show the error to the user
                }else{
                    let uid = Auth.auth().currentUser?.uid as String?
                    //add to firebase database database reference
                    let db = Firestore.firestore()
                    //adds the picture to my firebase Storage
                    db.collection("users").document("\(result!.user.uid)").setData(["DOB": dateOfBirth ?? 1999, "email": email1, "username": Username, "currElo": 1200, "uid": uid ?? "", ])
                    db.collection("Usernames").document("\(Username)").setData(["Username": Username, "uid": uid ?? ""])
                    let docRef = db.collection("users").document("\(result!.user.uid)")
                    let docRefTwo = db.collection("Usernames").document("\(Username)")
                    let randomID = UUID.init().uuidString
                    docRefTwo.updateData(["imagePath" : "usr/\(randomID).jpg"]) { (error) in
                        if error != nil {
                            // Show error message
                            self.showHUDWithError(error: error!)
                        }
                    }
                    docRef.updateData(["imagePath" : "usr/\(randomID).jpg"]) { (error) in
                        if error != nil {
                            // Show error message
                            self.showHUDWithError(error: error!)
                        }
                    }
                    let uploadRef = Storage.storage().reference(withPath: "usr/\(randomID).jpg")
                    let someImage = self.myImage.image(for: .normal)
                    guard let imageData = someImage?.jpegData(compressionQuality: 0.75) else {return}
                    let uploadMetadata = StorageMetadata.init()
                    uploadMetadata.contentType = "image/jpeg"
                    uploadRef.putData(imageData, metadata: uploadMetadata) { (downloadMetadata, error) in
                        if let err = err{
                            self.showHUDWithError(error: err )
                            return
                        }
                        print("great job uploaded \(String(describing: downloadMetadata))")
                    }
                   
                }
                self.transitionToHome()
            }
        }else{
            showWithString(string: error ?? "")
        }
    }
    fileprivate func showWithString(string: String) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration \(string)"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    func validateFieldsFilled() -> String?{
        if (DOB.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                username.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwrod.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            return "please Fill in one of the Fileds"
        }
        let cleanPassword = passwrod.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanPassword) == false{
            return "Please Make Password more secure"
        }
        else{
            return nil
        }
        
    }
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    //this is used to transitino to the homescreen
    func transitionToHome() {
        let messView = myTabBarController()
        messView.modalPresentationStyle = .fullScreen
        present(messView, animated: false, completion: nil)
    }
    
}

extension SignUpPageSignUp: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.myImage.setImage(image, for: .normal)
        //docRef.updateData(["profilePic": image!])
    }
}
