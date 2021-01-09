//
//  Friends.swift
//  BasketballAppTwo
//
//  Created by Michael  on 12/29/20.
//
import FirebaseAuth
import FirebaseFirestore
import UIKit
protocol FriendsViewDelgate {
    func ImageSelected(myView: UIView)
    func messageButtonHit(uid: String)
    func reportScoreHit(uid: String)
}
class Friends: UIView {
    let locationUsername = UILabel()
    let Elo = UILabel()
    var myImage = UIImage(imageLiteralResourceName: "shootingImageInitialPage")
    var messageType1 = 0
    var RankingValue = 1
    let Ranking:UILabel = {
        let button = UILabel()
        button.numberOfLines = 0
        button.textColor = .white
        button.numberOfLines = 0
        button.font = .boldSystemFont(ofSize: 14)
        return button
    }()
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
    let MessageButton:UIButton = {
        let button = UIButton(type: .system)
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button.backgroundColor = color1
        button.alpha = 1
        button.layer.cornerRadius = 8
        button.setTitle("Message", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        return button
    }()
    let ReportScore:UIButton = {
        let button = UIButton(type: .system)
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button.backgroundColor = color1
        button.alpha = 1
        button.layer.cornerRadius = 8
        button.setTitle("Score", for: .normal)
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
    
    var delegate: FriendsViewDelgate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
        
    }
    @objc fileprivate func targetViewDidTapped(){
        self.delegate?.ImageSelected(myView: self)
    }
    var Userimage: UIImageView = UIImageView()
    let gradientLayer = CAGradientLayer()
  
    fileprivate let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(imageLiteralResourceName: "info_icon")
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    @objc fileprivate func msgButtonHit(){
        delegate?.messageButtonHit(uid: uid ?? "")
    }
    @objc fileprivate func ReportScoreHit(){
        delegate?.reportScoreHit(uid: uid ?? "")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var Username: String?
    var elo: String?
    var uid: String?
    var imageUrl: String?
    @objc fileprivate func AcceptFollowButton(){
        let timestamp = Date()
        let currentUsr = Auth.auth().currentUser?.uid
        let db = Firestore.firestore().collection("users")
        let docRef = Firestore.firestore().collection("users").document(currentUsr ?? "")
        docRef.getDocument { (snapshot, error) in
            let myData = snapshot?.data()
            let currentUsrData = PlayerShort(dictionary: myData ?? ["":""])
            db.document(currentUsr ?? "").collection("Friends").document(self.uid ?? "").setData(["uid": self.uid ?? "", "imagePath": self.imageUrl ?? "", "username" : self.Username ?? "", "timestamp": timestamp])
            db.document(self.uid ?? "").collection("Friends").document(currentUsr ?? "").setData(["uid": currentUsrData.uid , "imagePath": currentUsrData.profileImageUrl, "username" : currentUsrData.Username, "timestamp": timestamp])
            db.document(self.uid ?? "").collection("Following").document(currentUsr ?? "").delete()
            db.document(currentUsr ?? "").collection("Followers").document(self.uid ?? "").delete()
        }
        self.removeFromSuperview()
    }
    @objc fileprivate func unfollowHit(){
        let currentUsr = Auth.auth().currentUser?.uid
        let db = Firestore.firestore().collection("users")
        db.document(currentUsr ?? "").collection("Following").document(self.uid ?? "").delete()
        db.document(self.uid ?? "").collection("Followers").document(currentUsr ?? "").delete()
        self.removeFromSuperview()
    }
    
    func setupLayout(){
       self.Userimage.image?.withRenderingMode(.alwaysOriginal)
       self.Userimage.contentMode = .scaleAspectFill
        Userimage.image = myImage
       addSubview(Userimage)
       Userimage.fillSuperview()
       layer.cornerRadius = 10
       clipsToBounds = true
       addSubview(locationUsername)
       locationUsername.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 16, right: 16))
       locationUsername.font = .systemFont(ofSize: 12, weight: .semibold)
       locationUsername.textColor = .white
       locationUsername.numberOfLines = 0
        locationUsername.text = "\(Username ?? "") \n 22 miles away"
       addSubview(Elo)
       Elo.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 0))
       Elo.numberOfLines = 0
       Elo.textColor = .white
       Elo.numberOfLines = 0
        Elo.text = "\(elo ?? "")"
       Elo.font = .boldSystemFont(ofSize: 14)
       let Text = UILabel()
       addSubview(Text)
        Text.anchor(top: Elo.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 5, bottom: 0, right: 0))
       Text.numberOfLines = 0
       Text.textColor = .white
       Text.numberOfLines = 0
       Text.text = "Hooper"
       Text.font = .boldSystemFont(ofSize: 14)
       addSubview(moreInfoButton)
       moreInfoButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 16, right: 16), size: .init(width: 20, height: 20))
        switch messageType1 {
        //this is the case for following usr
        case 0:
          addSubview(AcceptFollow)
            AcceptFollow.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 3), size: .init(width: 50, height: 20))
            AcceptFollow.addTarget(self, action: #selector(AcceptFollowButton), for: .touchUpInside)
        case 1:
          addSubview(MessageButton)
            MessageButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 3),size: .init(width: 70, height: 20))
          addSubview(ReportScore)
            ReportScore.anchor(top: MessageButton.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 3),size: .init(width: 60, height: 20))
            MessageButton.addTarget(self, action: #selector(msgButtonHit), for: .touchUpInside)
            ReportScore.addTarget(self, action: #selector(ReportScoreHit), for: .touchUpInside)
        case 2:
            addSubview(Unfollow)
            Unfollow.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 3),size: .init(width: 60, height: 20))
            Unfollow.addTarget(self, action: #selector(unfollowHit), for: .touchUpInside)
        case 3:
            addSubview(Ranking)
            Ranking.text = "Rank \(RankingValue)"
            Ranking.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 3),size: .init(width: 60, height: 20))
        default:
            print("sad")
        }
        
    }
    
}
