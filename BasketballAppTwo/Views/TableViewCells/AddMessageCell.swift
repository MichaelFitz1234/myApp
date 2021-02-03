//
//  AddMessageCell.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/27/20.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
class AddMessageCell: UITableViewCell {
    let myImg4 = UIImage(systemName: "checkmark.square.fill")
    let myImg5 = UIImage(systemName: "squareshape")
    var count = 0 {
        didSet{
            if(count % 2 == 0){
                pointingImage.image = myImg5
            }else{
                pointingImage.image = myImg4
            }
        }
    }
    let ReportScore:UIButton = {
        let button = UIButton(type: .system)
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button.backgroundColor = color1
        button.alpha = 1
        button.layer.cornerRadius = 8
        button.setTitle("Unfriend", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    @objc fileprivate func reptScoreHit(){
        let currentUsr = Auth.auth().currentUser?.uid
        let db = Firestore.firestore().collection("Users").document(currentUsr ?? "").collection("Social").document(self.uid ?? "")
        let db2 = Firestore.firestore().collection("Users").document(self.uid ?? "").collection("Social").document(currentUsr ?? "")
        db.updateData(["relationship" : "follower"])
        db2.updateData(["relationship" : "following"])
    }
    var imagePath = ""{
        didSet{
            addSubview(myImg)
            myImg.backgroundColor = .gray
            myImg.image?.withRenderingMode(.alwaysOriginal)
            myImg.contentMode = .scaleAspectFill
            myImg.layer.masksToBounds = true
            myImg.layer.cornerRadius = 20
            let storageRef = Storage.storage().reference(withPath: imagePath)
            storageRef.getData(maxSize: 4*1024*1024) {[unowned self] (data, error) in
                if let error = error{
                    print("Got an error fetching data: \(error.localizedDescription)")
                    return
                }else{
                    if let data = data{
                        self.myImg.image = UIImage(data: data)
                    }
                }
            }
        }
   }
   var messageType = 0{
        didSet{
                addSubview(myLabel)
                myLabel.anchor(top: topAnchor, leading: myImg.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 4, bottom: 0, right: 0))
                myLabel.textColor = .systemGray2
                myLabel.backgroundColor = .white
                myLabel.font = .systemFont(ofSize: 13, weight: UIFont.Weight(rawValue: 10))
                myImg.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 12, left: 15, bottom: 0, right: 0), size: .init(width: 40, height: 40))
                switch messageType {
                case 0:
                    addSubview(AcceptFollow)
                    AcceptFollow.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 10, bottom: 0, right: 8), size: .init(width: 70, height: 30))
                    AcceptFollow.addTarget(self, action: #selector(FriendHit), for: .touchUpInside)
                case 1:
                    addSubview(ReportScore)
                    ReportScore.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 0, bottom: 0, right: 8), size: .init(width: 70, height: 30))
                    ReportScore.addTarget(self, action: #selector(reptScoreHit), for: .touchUpInside)

                case 2:
                    addSubview(Unfollow)
                    Unfollow.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 10, bottom: 0, right: 8), size: .init(width: 70, height: 30))
                    Unfollow.addTarget(self, action: #selector(unfollowHit), for: .touchUpInside)
                case 3:
                  addSubview(RankingLabel)
                  RankingLabel.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 8))

                case 4:
                    img?.withTintColor(.gray)
                    pointingImage.image = img
                    myLabel.backgroundColor = .white
                    addSubview(pointingImage)
                    pointingImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 10, bottom: 0, right: 8), size: .init(width: 30, height: 30))
                case 5:
                    img?.withTintColor(.gray)
                    pointingImage.image = img2
                    myLabel.backgroundColor = .white
                    addSubview(pointingImage)
                    pointingImage.tintColor = .black
                    pointingImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 10, bottom: 0, right: 8), size: .init(width: 30, height: 30))
                case 6:
                    img?.withTintColor(.gray)
                    myLabel.backgroundColor = .white
                    addSubview(pointingImage)
                    pointingImage.image = myImg5
                    pointingImage.tintColor = .black
                    pointingImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 10, bottom: 0, right: 8), size: .init(width: 30, height: 30))
                case 7:
                    myImg.removeFromSuperview()
                    let selectAllLabel = UILabel()
                    addSubview(selectAllLabel)
                    selectAllLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 15, bottom: 0, right: 0))
                    selectAllLabel.font = .boldSystemFont(ofSize: 20)
                    selectAllLabel.textColor = .systemGray3
                    selectAllLabel.text = "Select All"
                    img?.withTintColor(.gray)
                    myLabel.backgroundColor = .white
                    addSubview(pointingImage)
                    pointingImage.image = myImg5
                    pointingImage.tintColor = .black
                    pointingImage.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 10, bottom: 0, right: 8), size: .init(width: 30, height: 30))
                default:
                    print("Message")
                }
        }
    }
    var img3 = UIImage(systemName: "squareshape")
    var uid:String?
    let myImg = UIImageView()
    let myLabel = UILabel()
    let RankingLabel = UILabel()
    let pointingImage = UIImageView()
    let imageView2 = UIImageView()
    let img = UIImage(systemName: "plus.message")
    let img2 = UIImage(systemName: "iphone.homebutton.badge.play")
    let AcceptFollow:UIButton = {
        let button = UIButton(type: .system)
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button.backgroundColor = color1
        button.alpha = 0.7
        button.alpha = 1
        button.layer.cornerRadius = 8
        button.setTitle("Friend", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    let Unfollow:UIButton = {
        let button = UIButton(type: .system)
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button.backgroundColor = color1
        button.alpha = 1
        button.layer.cornerRadius = 8
        button.setTitle("Unfollow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    @objc fileprivate func FriendHit(){
        let timestamp = Date()
        let currentUsr = Auth.auth().currentUser?.uid
        let db = Firestore.firestore().collection("Users")
        db.document(currentUsr ?? "").collection("Social").document(self.uid ?? "").updateData(["relationship" : "friend"])
        db.document(self.uid ?? "").collection("Social").document(currentUsr ?? "").updateData(["relationship" : "friend"])
    self.removeFromSuperview()
    }
    @objc fileprivate func unfollowHit(){
    let currentUsr = Auth.auth().currentUser?.uid
    let db = Firestore.firestore().collection("Users")
    db.document(currentUsr ?? "").collection("Social").document(self.uid ?? "").delete()
    db.document(self.uid ?? "").collection("Social").document(currentUsr ?? "").delete()
    self.removeFromSuperview()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        }
    }
