//
//  CardView.swift
//  tinderCloneSwiping
//
//  Created by Michael Fitzgerald on 11/18/20.
//

import UIKit
import SDWebImage
import FirebaseStorage
protocol CardViewDelegate {
    func nextCardRight(translation: CGFloat)
    func nextCardLeft(translation: CGFloat)
    func didTapMoreInfo(uid: String)
    func followHit(followOrNot: Int, uid: String, username: String, imagePath: String)
    func unfollowHit(unFollow: Int, uid: String, username: String, imagePath: String)
    func friendHit(uid: String,username: String, imagePath: String)
    func unfriendHit(uid: String)
    func msgHit(uid: String)
    func reportScoreHit(uid: String)
}
class CardView: UIView {
    var UsrName = ""
    fileprivate let threshold: CGFloat = 100
    var uid = ""
    var nextCard: CardView?
    var previousCard: CardView?
    var delegate: CardViewDelegate?
    var Userimage: UIImageView = UIImageView()
    let gradientLayer = CAGradientLayer()
    let locationUsername = UILabel()
    var distance:Int?
    var imageUrl: String?
    fileprivate lazy var screenSize = UIScreen.main.bounds
    fileprivate lazy var ScreenWidth = screenSize.width+20
    var count = 1
    let Elo = UILabel()
    let mylabel = UILabel()
    var relationship: String?{
        didSet{
            switch relationship {
            case "follower":
                followButton.removeFromSuperview()
                addSubview(friendButton)
                friendButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 0, right: 16), size: .init(width: 80, height: 30))
                addSubview(mylabel)
                mylabel.numberOfLines = 0
                mylabel.text = "\(UsrName) is following \n you click to friend"
                mylabel.anchor(top: Elo.bottomAnchor, leading: Elo.leadingAnchor, bottom: nil, trailing: Elo.trailingAnchor)
                mylabel.font = .systemFont(ofSize: 14, weight: .semibold)
                mylabel.textColor = .white
                case "friend":
                followButton.removeFromSuperview()
                addSubview(MessageButton)
                MessageButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 0, right: 16), size: .init(width: 80, height: 30))
                addSubview(ReportScore)
                ReportScore.anchor(top: MessageButton.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 0, right: 16), size: .init(width: 80, height: 30))
                mylabel.text = "\(UsrName) is you friend"
                addSubview(mylabel)
                mylabel.numberOfLines = 0
                mylabel.anchor(top: Elo.bottomAnchor, leading: Elo.leadingAnchor, bottom: nil, trailing: Elo.trailingAnchor)
                mylabel.font = .systemFont(ofSize: 14, weight: .semibold)
                mylabel.textColor = .white
                addSubview(unfriend)
                unfriend.anchor(top: mylabel.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 0, right: 16), size: .init(width: 80, height: 30))
            case "following":
                followButton.removeFromSuperview()
                addSubview(unfollow)
                unfollow.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 0, right: 16), size: .init(width: 80, height: 30))
                addSubview(mylabel)
                mylabel.numberOfLines = 0
                mylabel.text = "you are following \(UsrName)"
                mylabel.anchor(top: Elo.bottomAnchor, leading: Elo.leadingAnchor, bottom: nil, trailing: Elo.trailingAnchor)
                mylabel.font = .systemFont(ofSize: 14, weight: .semibold)
                mylabel.textColor = .white
            case "currentUsr":
                followButton.removeFromSuperview()
                addSubview(mylabel)
                mylabel.numberOfLines = 0
                mylabel.text = "This is you!"
                mylabel.anchor(top: Elo.bottomAnchor, leading: Elo.leadingAnchor, bottom: nil, trailing: Elo.trailingAnchor)
                mylabel.font = .systemFont(ofSize: 14, weight: .semibold)
                mylabel.textColor = .white
            default:
                print("nothing to see here")
            }
        }
    }
    var userProperties: User?{
        didSet {
            let currentElo = String(userProperties?.Elo ?? 0)
            if(userProperties?.Elo ?? 0 >= 2000){
                Elo.text = "\(currentElo) \n Hall of Fame"
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
            locationUsername.text = "\(username) \n \(distance ?? 0) miles away"
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    fileprivate let unfriend:UIButton = {
        let button = UIButton(type: .system)
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button.backgroundColor = color1
        button.alpha = 1
        button.layer.cornerRadius = 8
        button.setTitle("Unfriend", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(unfriendHit), for: .touchUpInside)
        return button
    }()
    @objc fileprivate func unfriendHit(){
        MessageButton.removeFromSuperview()
        ReportScore.removeFromSuperview()
        unfriend.removeFromSuperview()
        mylabel.text = "\(UsrName) is following \n you click to friend"
        addSubview(friendButton)
        friendButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 0, right: 16), size: .init(width: 80, height: 30))
        delegate?.unfriendHit(uid: uid)
    }
    fileprivate let friendButton:UIButton = {
        let button = UIButton(type: .system)
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button.backgroundColor = color1
        button.alpha = 1
        button.layer.cornerRadius = 8
        button.setTitle("Friend", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(friendHit), for: .touchUpInside)
        return button
    }()
    fileprivate let followButton: UIButton = {
        let button = UIButton(type: .system)
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button.backgroundColor = color1
        button.alpha = 1
        button.layer.cornerRadius = 8
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(followHit), for: .touchUpInside)
        return button
    }()
    fileprivate let unfollow: UIButton = {
        let button = UIButton(type: .system)
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button.backgroundColor = color1
        button.alpha = 1
        button.layer.cornerRadius = 8
        button.setTitle("Unfollow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(unFollowHit), for: .touchUpInside)
        return button
    }()
    fileprivate let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(imageLiteralResourceName: "info_icon")
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(moreInfoHit), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(messageButtonHit) , for: .touchUpInside)
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
        button.addTarget(self, action: #selector(reportScore) , for: .touchUpInside)
        return button
    }()
    var count2 = 0
    @objc func unFollowHit(){
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        if count2 % 2 == 0{
        unfollow.backgroundColor = color1
        unfollow.setTitle("Follow", for: .normal)
        unfollow.backgroundColor = .white
        unfollow.setTitleColor(color1, for: .normal)
        count2 = count2 + 1
        }else{
        unfollow.setTitle("Unfollow", for: .normal)
        unfollow.backgroundColor = color1
            unfollow.setTitleColor(.white, for: .normal)
        count2 = count2 + 1
        }
        delegate?.unfollowHit(unFollow: count2 % 2, uid: uid, username: UsrName, imagePath: imageUrl ?? "")
    }
    @objc func messageButtonHit(){
        delegate?.msgHit(uid: uid)
    }
    @objc func reportScore(){
        delegate?.reportScoreHit(uid: uid)
    }
    @objc func friendHit(){
    followButton.removeFromSuperview()
    addSubview(MessageButton)
    MessageButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 0, right: 16), size: .init(width: 80, height: 30))
    addSubview(ReportScore)
    ReportScore.anchor(top: MessageButton.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 0, right: 16), size: .init(width: 80, height: 30))
    mylabel.text = "\(UsrName) is you friend"
    addSubview(unfriend)
    unfriend.anchor(top: mylabel.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 0, right: 16), size: .init(width: 80, height: 30))
    delegate?.friendHit(uid: uid, username: UsrName, imagePath: imageUrl ?? "")
    }
    func nextCardSetup(){
        let rotationalTransformation = CGAffineTransform(rotationAngle: 0)
        nextCard?.transform = rotationalTransformation.translatedBy(x: ScreenWidth, y: 0)
    }
    func lastCardSetup(){
        let rotationalTransformation = CGAffineTransform(rotationAngle: 0)
        previousCard?.transform = rotationalTransformation.translatedBy(x: -ScreenWidth, y: 0)
    }
    //MARK: THIS IS USED TO HANDLE A PAN
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        if shouldDismissCard {
            if translationDirection == 1{
                if previousCard == nil{
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                        self.transform = .identity
                        let rotationalTransformation = CGAffineTransform(rotationAngle: 0)
                        self.nextCard?.transform = rotationalTransformation.translatedBy(x: self.ScreenWidth, y: 0)
                        self.previousCard?.transform = rotationalTransformation.translatedBy(x: -self.ScreenWidth, y: 0)
                    })
                }else{
                    self.delegate?.nextCardLeft(translation: -700)
                }
            } else if translationDirection == -1{
                if nextCard == nil{
                    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                        self.transform = .identity
                        let rotationalTransformation = CGAffineTransform(rotationAngle: 0)
                        self.nextCard?.transform = rotationalTransformation.translatedBy(x: self.ScreenWidth, y: 0)
                        self.previousCard?.transform = rotationalTransformation.translatedBy(x: -self.ScreenWidth, y: 0)
                    })
                } else {
                    self.delegate?.nextCardRight(translation: 700)
                }
            }
        } else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
                self.transform = .identity
                let rotationalTransformation = CGAffineTransform(rotationAngle: 0)
                self.nextCard?.transform = rotationalTransformation.translatedBy(x: self.ScreenWidth, y: 0)
                self.previousCard?.transform = rotationalTransformation.translatedBy(x: -self.ScreenWidth, y: 0)
            })
        }
    }
    //MARK: THIS IS USED TO CHANGE THE PANNING
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        let rotationalTransformation = CGAffineTransform(rotationAngle: 0)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: 0)
        nextCard?.transform = rotationalTransformation.translatedBy(x: translation.x+ScreenWidth, y: 0)
        previousCard?.transform = rotationalTransformation.translatedBy(x: translation.x-ScreenWidth, y: 0)
    }
    //this sets up the layout kinda messy could be done in fewer lines but going to go with ith for now
    //MARK: SETS UP THE LAYOUT OF THE CARDS
    func setupLayout(){
        layer.cornerRadius = 10
        clipsToBounds = true
        addSubview(Userimage)
        Userimage.fillSuperview()
        addSubview(locationUsername)
        locationUsername.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        locationUsername.font = .systemFont(ofSize: 18, weight: .semibold)
        locationUsername.textColor = .white
        locationUsername.numberOfLines = 0
        addSubview(Elo)
        Elo.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 16, bottom: 0, right: 16))
        Elo.numberOfLines = 0
        Elo.textColor = .white
        Elo.numberOfLines = 0
        Elo.font = .boldSystemFont(ofSize: 20)
        addSubview(followButton)
        followButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 8, bottom: 0, right: 16), size: .init(width: 80, height: 30))
        addSubview(moreInfoButton)
        moreInfoButton.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 16, right: 16), size: .init(width: 44, height: 44))
    }
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .began:
            //
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture: gesture)
        default:
            ()
        }
    }
    //this should dismiss the card and update the database
    @objc fileprivate func followHit(){
        //this goes to the next card
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        if count % 2 == 0{
        followButton.backgroundColor = color1
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        count = count + 1
        }else{
        followButton.setTitle("Unfollow", for: .normal)
        followButton.backgroundColor = .white
        followButton.setTitleColor(color1, for: .normal)
        count = count + 1
        }
        delegate?.followHit(followOrNot: count % 2, uid: uid, username: UsrName, imagePath: imageUrl ?? "")
    }
    @objc fileprivate func moreInfoHit(){
        delegate?.didTapMoreInfo(uid: uid)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
