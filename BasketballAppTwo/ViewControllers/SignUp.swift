//
//  SignUp.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 11/12/20.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import JGProgressHUD

class SignUp: UIViewController {
 
    @IBOutlet weak var selectImage: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var signUpButton: UIButton!
   
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var DOBTextFeild: UITextField!
    
    var imagePicker: ImagePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        formattingStuff()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
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
    fileprivate func showWithString(string: String) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration \(string)"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    @IBAction func signUpHit(_ sender: Any) {
        let error = validateFieldsFilled()
        if error == nil {
            let date = NSDate()
            //clean up the field that exist
            let DOB = DOBTextFeild.text!
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateOfBirth = dateFormatter.date(from: DOB)
            let Username = usernameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if(err != nil){
                    self.showHUDWithError(error: err!)
                    return
                    //show the error to the user
                }else{
                    let uid = Auth.auth().currentUser?.uid as String?
                    //add to firebase database database reference
                    let db = Firestore.firestore()
                    //adds the picture to my firebase Storage
                    db.collection("users").document("\(result!.user.uid)").setData(["DOB": dateOfBirth ?? 1999, "email": email, "username": Username, "currElo": 1200, "uid": uid ?? "", ])
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
                    guard let imageData = self.imageView.image?.jpegData(compressionQuality: 0.75) else {return}
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
            }
            transitionToHome()
        }else{
            showWithString(string: error ?? "")
        }
    }
    
    
    //this is used to formate the buttons and everything else
    func formattingStuff(){
        signUpButton.layer.borderWidth = 3
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.cornerRadius = 5
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.systemGray4.cgColor
        passwordTextField.layer.cornerRadius = 3
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.systemGray4.cgColor
        emailTextField.layer.cornerRadius = 3
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = UIColor.systemGray4.cgColor
        usernameTextField.layer.cornerRadius = 3
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.systemGray4.cgColor
        DOBTextFeild.layer.cornerRadius = 3
        DOBTextFeild.layer.borderWidth = 1
        DOBTextFeild.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.layer.cornerRadius = 3
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemGray2.cgColor
    }
    //executed when the image is selected
    @IBAction func selectImage(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
        imageView.layer.borderWidth = 0
        selectImage.setTitleColor(UIColor.clear, for: UIControl.State.normal)
    }

    //this is method used in order to make sure that the fields are all filled password is correct
    func validateFieldsFilled() -> String?{
        if (DOBTextFeild.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            return "please Fill in one of the Fileds"
        }
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanPassword) == false{
            return "Please Make Password more secure"
        }
        else{
            return nil
        }
        
    }
    
    
    //this method is used to make sure that the password is valid
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    //this is used to transitino to the homescreen
    func transitionToHome() {
        let HomeViewController = self.storyboard?.instantiateViewController(identifier: "homePage")
        self.view.window?.rootViewController = HomeViewController
        self.view.window?.makeKeyAndVisible()

    }
    
}

extension SignUp: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.imageView.image = image
        //docRef.updateData(["profilePic": image!])
    }
}
