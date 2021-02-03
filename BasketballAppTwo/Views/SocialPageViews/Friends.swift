//
//  Friends.swift
//  BasketballAppTwo
//
//  Created by Michael  on 12/29/20.
//
import FirebaseAuth
import FirebaseStorage
import UIKit
import FirebaseFirestore
protocol FriendsViewDelgate {
    func ImageSelected(myView: UIView)
    func messageButtonHit(uid: String)
    func reportScoreHit(uid: String)
}
class Friends: UIView {
    var messageType1 = 0 {
        didSet{
            setupLayout()
        }
    }
    var userProperties: User?{
        didSet {
            let currentElo = String(userProperties?.Elo ?? 0)
            if(userProperties?.Elo ?? 0 >= 2000){
                Elo.text = "\(currentElo) \n Hall of Faxame"
            }else if (userProperties?.Elo ?? 0 >= 1800 && userProperties?.Elo  ?? 0 < 2000){
                Elo.text  = "\(currentElo) \n All Star"
            }else if(userProperties?.Elo  ?? 0 >= 1600 && userProperties?.Elo  ?? 0 < 1800){
                Elo.text  = "\(currentElo) \n Champion"
            }else if(userProperties?.Elo  ?? 0 >= 1400 && userProperties?.Elo  ?? 0 < 1600){
                Elo.text  = "\(currentElo) \n Professional"
            }else if(userProperties?.Elo  ?? 0 >= 1200 && userProperties?.Elo  ?? 0 < 1400){
                Elo.text  = "\(currentElo) \n Amateur"
            }else if(userProperties?.Elo  ?? 0 >= 1000 && userProperties?.Elo  ?? 0 < 1200){
                Elo.text  = "\(currentElo) \n Rookie"
            }else if(userProperties?.Elo  ?? 0 >= 800 && userProperties?.Elo  ?? 0 < 1000){
                Elo.text  = "\(currentElo)  \n Small-Baller"
            }else if(userProperties?.Elo  ?? 0 < 800){
                Elo.text  = "Just Chillin"
            }
            uid = userProperties?.uid ?? ""
            let username = userProperties?.Username ?? ""
            UsrName = username
            //distance will have to go here once added
            locationUsername.text = "\(username)"
            imageUrl = userProperties?.imageUrl
            let storageRef = Storage.storage().reference(withPath: userProperties?.imageUrl ?? "")
            storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
                if let error = error{
                    print("Got an error fetching data: \(error.localizedDescription)")
                    return
                }else{
                    if let data = data{
                        DispatchQueue.main.async {
                            self.Userimage.image = UIImage(data: data)
                            self.Userimage.image?.withRenderingMode(.alwaysOriginal)
                            self.Userimage.contentMode = .scaleAspectFill
                        }
                    }
                }
            }
        }
    }
    var UsrName = ""
    let Text = UILabel()
    let locationUsername = UILabel()
    let Elo = UILabel()
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
    let Unfriend:UIButton = {
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
        let currentUsr = Auth.auth().currentUser?.uid
        let db = Firestore.firestore().collection("Users").document(currentUsr ?? "").collection("Social").document(self.uid ?? "")
        let db2 = Firestore.firestore().collection("Users").document(self.uid ?? "").collection("Social").document(currentUsr ?? "")
        db.updateData(["relationship" : "friend"])
        db2.updateData(["relationship" : "friend"])
    }
    @objc fileprivate func unfollowHit(){
        let currentUsr = Auth.auth().currentUser?.uid
        let db = Firestore.firestore().collection("Users").document(currentUsr ?? "").collection("Social").document(self.uid ?? "")
        let db2 = Firestore.firestore().collection("Users").document(self.uid ?? "").collection("Social").document(currentUsr ?? "")
        db.delete()
        db2.delete()
    }
    @objc fileprivate func unfriendHit(){
        let currentUsr = Auth.auth().currentUser?.uid
        let db = Firestore.firestore().collection("Users").document(currentUsr ?? "").collection("Social").document(self.uid ?? "")
        let db2 = Firestore.firestore().collection("Users").document(self.uid ?? "").collection("Social").document(currentUsr ?? "")
        db.updateData(["relationship" : "follower"])
        db2.updateData(["relationship" : "following"])
    }
    func setupLayout(){
        self.Userimage.image?.withRenderingMode(.alwaysOriginal)
        self.Userimage.contentMode = .scaleAspectFill
        addSubview(Userimage)
        Userimage.fillSuperview()
        layer.cornerRadius = 10
        clipsToBounds = true
        addSubview(locationUsername)
        locationUsername.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 16, right: 16))
        locationUsername.font = .systemFont(ofSize: 12, weight: .semibold)
        locationUsername.textColor = .white
        locationUsername.numberOfLines = 0
        addSubview(Elo)
        Elo.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 0))
        Elo.numberOfLines = 0
        Elo.textColor = .white
        Elo.numberOfLines = 0
        Elo.text = "\(elo ?? "")"
        Elo.font = .boldSystemFont(ofSize: 14)
        addSubview(Text)
        Text.anchor(top: Elo.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 5, bottom: 0, right: 0))
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
            addSubview(Unfriend)
            Unfriend.anchor(top: ReportScore.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 3),size: .init(width: 60, height: 20))
            Unfriend.addTarget(self, action: #selector(unfriendHit), for: .touchUpInside)
            //Unfriend
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
