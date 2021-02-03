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
import CoreLocation
import GeoFire
protocol signedUp {
    func removed()
    func signUpHit()
}
class SignUpPageSignUp: UIViewController, CLLocationManagerDelegate {
    let myImage = UIButton()
    let DOB = UIDatePicker()
    var delegate: signedUp?
    let username = UITextField()
    let email = UITextField()
    let phoneNumber =  UITextField()
    let signUp = UIButton(type: .system)
    let selectImageLabel = UILabel()
    var imagePicker: ImagePicker!
    let registeringHUD = JGProgressHUD(style: .dark)
    var booleanImageHit = false
    var locationManager = CLLocationManager()
    var lon: Double?
    var lat: Double?
    var location:CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        setupLayout()
    }
 
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        lon = locValue.longitude
        lat = locValue.latitude
        location = locValue
    }
    
    fileprivate func setupLayout() {
        view.backgroundColor = .white
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        //thse are the fields
        let screenSize = UIScreen.main.bounds
        let ScreenWidth = screenSize.width
        let myImg = UIImage(systemName: "arrow.left")
        let backArrow = UIButton()
        let SelectDateLabel = UITextField()
        //create subviews
        view.addSubview(myImage)
        view.addSubview(SelectDateLabel)
        view.addSubview(DOB)
        view.addSubview(username)
        view.addSubview(email)
        view.addSubview(phoneNumber)
        view.addSubview(backArrow)
        myImage.addSubview(selectImageLabel)
        view.addSubview(signUp)
        //targets
        myImage.addTarget(self, action: #selector(ImageHit), for: .touchUpInside)
        signUp.addTarget(self, action: #selector(signUpHit), for: .touchUpInside)
        backArrow.addTarget(self, action: #selector(backHit), for: .touchUpInside)
        //the targets are added
        email.autocapitalizationType = .none
        phoneNumber.autocapitalizationType = .none
        username.autocapitalizationType = .none
        myImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 30, bottom: 0, right: 30))
        myImage.heightAnchor.constraint(equalToConstant: 350).isActive = true
        myImage.layer.cornerRadius = 3
        myImage.layer.borderWidth = 3
        myImage.layer.borderColor = UIColor.systemGray2.cgColor
        selectImageLabel.anchor(top: myImage.topAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 180, left: ScreenWidth/3.7, bottom: 0, right: 0))
        selectImageLabel.text = "Add an image"
        SelectDateLabel.anchor(top: myImage.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        SelectDateLabel.text = "Enter Date of Birth: "
        SelectDateLabel.font = .systemFont(ofSize: 16)
        DOB.anchor(top: myImage.bottomAnchor, leading: SelectDateLabel.trailingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        DOB.heightAnchor.constraint(equalToConstant: 35).isActive = true
        username.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: username.frame.height))
        username.leftViewMode = .always
        username.anchor(top: DOB.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        username.heightAnchor.constraint(equalToConstant: 35).isActive = true
        username.placeholder = "Username(4-10 characters unique)"
        username.layer.cornerRadius = 6
        username.layer.borderWidth = 2
        username.layer.borderColor = UIColor.darkGray.cgColor
        email.anchor(top: username.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        email.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: email.frame.height))
        email.leftViewMode = .always
        email.heightAnchor.constraint(equalToConstant: 35).isActive = true
        email.placeholder = "Email"
        email.layer.cornerRadius = 6
        email.layer.borderWidth = 2
        email.layer.borderColor = UIColor.darkGray.cgColor
        phoneNumber.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: phoneNumber.frame.height))
        phoneNumber.leftViewMode = .always
        phoneNumber.anchor(top: email.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        phoneNumber.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 7, height: phoneNumber.frame.height))
        phoneNumber.anchor(top: email.bottomAnchor, leading: myImage.leadingAnchor, bottom: nil, trailing: myImage.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        phoneNumber.heightAnchor.constraint(equalToConstant: 35).isActive = true
        phoneNumber.placeholder = "Password"
        phoneNumber.layer.cornerRadius = 6
        phoneNumber.layer.borderWidth = 2
        phoneNumber.layer.borderColor = UIColor.darkGray.cgColor
        signUp.anchor(top: phoneNumber.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 45, bottom: 0, right: 0),size: .init(width: 300, height: 70))
        signUp.setTitle("Sign Up", for: .normal)
        signUp.setTitleColor(.white, for: .normal)
        signUp.backgroundColor = .darkGray
        view.backgroundColor = .systemGray6
        backArrow.setImage(myImg, for: .normal)
        backArrow.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 15, bottom: 0, right: 0),size: .init(width: 20, height: 20))
    }

    
    //this is used for the send confirmation Email
    fileprivate func allGOO2(){
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Uploading Profile"
        hud.show(in: self.view)
        let email1 = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = phoneNumber.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let dateOfBirth = DOB.date
        let Username = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().createUser(withEmail: email1, password: password) { (result, err) in
            if(err != nil){
                self.showHUDWithError(error: err!)
                return
            }
            let currentUsrId = Auth.auth().currentUser?.uid
            let db = Firestore.firestore().collection("Users")
            let geoDb = Firestore.firestore().collection("GeoPoint")
            let dbEmail = Firestore.firestore().collection("Emails")
            //this is with location
            let myGeoPoint = GeoPoint(latitude: self.lat ?? 0.0, longitude: self.lon ?? 0.0)
            let hash = GFUtils.geoHash(forLocation: self.location ?? CLLocationCoordinate2D(latitude: self.lat ?? 0, longitude: self.lon ?? 0))
            let areaHash = String(hash.prefix(5))
            let randomID = UUID.init().uuidString
            let storageRef = Storage.storage().reference(withPath: "usr/\(randomID).jpg")
            //adds the picture to my firebase Storage
            //adds teh firebase storage
            let searchableIndex = self.createIndex(title: Username)
            let date = Date()
            db.document(currentUsrId ?? "").setData(["dateOfBirth": dateOfBirth , "username": Username, "currElo": 1200, "uid": currentUsrId ?? "", "imagePath": "usr/\(randomID).jpg", "location": myGeoPoint, "searchIndex": searchableIndex])
            geoDb.document(areaHash).setData(["userIds": FieldValue.arrayUnion([Auth.auth().currentUser?.uid ?? ""]), "geohash": areaHash], merge: true)
            db.document(currentUsrId ?? "").collection("Social").document(currentUsrId ?? "").setData(["uid" : currentUsrId ?? "", "searchIndex" : searchableIndex, "username": Username, "imagePath" : "usr/\(randomID).jpg", "relationship": "currentUsr",  "timestamp": date])
            dbEmail.document(currentUsrId ?? "").setData(["email": email1])
            let someImage = self.myImage.image(for: .normal)
            guard let imageData = someImage?.jpegData(compressionQuality: 0.75) else {return}
            let uploadMetadata = StorageMetadata.init()
            uploadMetadata.contentType = "image/jpeg"
            storageRef.putData(imageData, metadata: uploadMetadata) { (downloadMetadata, error) in
              if let err = err{
                  self.showHUDWithError(error: err )
                  return
              }
            hud.dismiss()
            self.delegate?.signUpHit()
          }
        }
    }
    fileprivate func createIndex(title: String) -> [String] {
        var searchableIndex = [String]()
        let myLength = title.count
        for index in 1...myLength{
            let myString = String(title.prefix(index))
            searchableIndex.append(myString)
        }
        return searchableIndex
    }
    //this show the hud and the error
    fileprivate func showHUDWithError(error: Error) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed registration"
        hud.detailTextLabel.text = error.localizedDescription
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    //this is a error message
    fileprivate func showWithString(string: String) {
        registeringHUD.dismiss()
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Failed Registration \(string)"
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 4)
    }
    //this validates all of our fields
    //MARK: this if for field authentication
    fileprivate func validateFieldsFilled() -> String?{
        let a1 = username.text
        let a2 = username.text
        //checks to see if all the fields and image is selected
        if (username.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || booleanImageHit == false){
            if booleanImageHit == false{
                return "Please Select An Image"
            }else{
            return "Not All Fields Filled"
            }
        }
        //checks username length
        if a1?.count ?? 0 < 4{
            return "Username To Short"
        }else if a2?.count ?? 0 > 10{
            return "Username To Long"
        }
        let myEmailisValid =  isValidEmail(email.text ?? "")
        if myEmailisValid == false {
            return "Email Address Not Valid"
        }
        let myPhoneNumber =  isPasswordValid(phoneNumber.text ?? "")
        if myPhoneNumber == false {
            return "Email Not Valid"
        }
        let dateOfBirth = DOB.date

          let today = NSDate()

        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!

        let age = gregorian.components([.year], from: dateOfBirth, to: today as Date, options: [])

        if age.year ?? 0 < 12 || age.year ?? 0 > 100{
            return "Please Select Valid Age"
        }
        return nil
    }
    //MARK: checks if valid email
    fileprivate func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    //MARK: checks valid email address
    fileprivate func validate() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    fileprivate func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    //this is a method run when sign up is hit
    //MARK: the sign up button is hit
    @objc fileprivate func signUpHit(_ sender: Any) {
        let error = validateFieldsFilled()
        if error == nil {
            //this is piece of code used to make firebase call sync using dispatch group in order to check if the username is in database
            //MARK: DISPATCH GROUP CHECK IF USERNAME IS IN DATABASE
                var isInDatabase = false
                let myGroup = DispatchGroup()
                myGroup.enter()
            //MARK: I can do another query here in order to make sure that the email is unique
                let docRef = Firestore.firestore().collection("users")
            docRef.whereField("username", isEqualTo: username.text!.trimmingCharacters(in: .whitespacesAndNewlines)).limit(to: 1).getDocuments { (snapshot, error) in
                        if error != nil{
                            isInDatabase = false
                            return
                        }
                        snapshot?.documents.forEach({ (snapshot) in
                            isInDatabase = true
                        })
                        myGroup.leave()
                    }
                myGroup.notify(queue: .main) {
                    if isInDatabase == true{
                        let myString = "Username Is Taken Please Select A New Username"
                        self.showWithString(string: myString)
                    }else{
                        self.allGOO2()
                    }
                }
        }else{
            self.showWithString(string: error ?? "")
    }
    }
    //this is used when to create the image
    @objc fileprivate func ImageHit(){
        self.imagePicker.present(from: self.view)
    }
    //this goes to the back button
    @objc fileprivate func backHit(){
        delegate?.removed()
    }

}
//this is used for the camera
extension SignUpPageSignUp: ImagePickerDelegate {
     func didSelect(image: UIImage?) {
        self.myImage.setImage(image, for: .normal)
        myImage.layer.borderWidth = 0
        selectImageLabel.removeFromSuperview()
        booleanImageHit = true
    }
}

