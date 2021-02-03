//
//  FollowersPage.swift
//  BasketballAppTwo
//
//  Created by Michael  on 12/31/20.
//

import UIKit
protocol FollowersPageProtocol {
    func searchHit(MessageType: Int)
    func makeBigger(MessageType: Int)
    func makeSmaller(MessageType: Int)
    func makeFullScreen(myViewControllers: UIViewController)
    func messageButtonHit(uid: String)
    func reportScoreH(uid: String)
}
class FollowersPage: UIView, FriendsViewDelgate {
    func reportScoreHit(uid: String) {
        self.delegate?.reportScoreH(uid: uid)
    }
    func messageButtonHit(uid: String) {
        self.delegate?.messageButtonHit(uid: uid)
    }
    func ImageSelected(myView: UIView) {
        let controller = FullPlayerView()
        controller.playCard = myView
        self.delegate?.makeFullScreen(myViewControllers: controller)
    }
    var big = false {
        didSet{
            if big == true {
                makeSmaller = UIImage(systemName: "chevron.left")
                makeSmallerImgView.setImage(makeSmaller, for: .normal)
            }else{
                makeSmaller = UIImage(systemName: "chevron.down")
                makeSmallerImgView.setImage(makeSmaller, for: .normal)
            }
        }
    }
    var MessageType = 0{
        didSet{
            setupLayout()
        }
    }
    var height = CGFloat(420.0)
    let scrollView = UIScrollView()
    let FriendsLabel = UIButton(type: .system)
    var Thewidth = 58
    let stackView = UIStackView()
    var makeSmaller = UIImage(systemName: "chevron.left")
    var delegate: FollowersPageProtocol?
    let makeSmallerImgView = UIButton(type: .system)
    let bottomDivider = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    fileprivate func setupLayout(){
        switch MessageType {
        //this is the case for following usr
        case 0:
            FriendsLabel.setTitle("Followers/Follow Requests", for: .normal)
            Thewidth = 203
        //this is a case for friends
        case 1:
            FriendsLabel.setTitle("Friends", for: .normal)
            Thewidth = 58
        case 2:
            FriendsLabel.setTitle("Following", for: .normal)
            Thewidth = 73
        case 3:
            FriendsLabel.setTitle("Global Leaderboard", for: .normal)
            Thewidth = 152
        default:
            print("sadness")
        }
        let searchImg = UIImage(systemName: "magnifyingglass.circle.fill")
        let thisImage = UIButton(type: .system)
        addSubview(thisImage)
        addSubview(bottomDivider)
        heightAnchor.constraint(equalToConstant: height).isActive = true
        addSubview(FriendsLabel)
        makeSmallerImgView.addTarget(self, action: #selector(editViewFriends), for: .touchUpInside)
        thisImage.addTarget(self, action: #selector(FriendsSearch), for: .touchUpInside)
        FriendsLabel.addTarget(self, action: #selector(FriendsSearch), for: .touchUpInside)
        FriendsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 20, bottom: 0, right: 0),size: .init(width: Thewidth, height: 30))
        makeSmallerImgView.setImage(makeSmaller, for: .normal)
        addSubview(makeSmallerImgView)
        makeSmallerImgView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 28, bottom: 0, right: 12),size: .init(width: 25, height: 22))
        makeSmallerImgView.tintColor = .systemGray2
        thisImage.setImage(searchImg, for: .normal)
        thisImage.tintColor = .systemGray3
        thisImage.anchor(top: topAnchor, leading: FriendsLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 19, left: 1, bottom: 0, right: 0),size: .init(width: 22, height: 22))
        thisImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        FriendsLabel.titleLabel?.font = .boldSystemFont(ofSize: 16)
        FriendsLabel.titleLabel?.textColor = .systemGray2
        FriendsLabel.tintColor = .systemGray3
        backgroundColor = .white
        addSubview(scrollView)
        stackView.axis = .horizontal
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        scrollView.anchor(top: FriendsLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 15, bottom: 10, right: 15))
        scrollView.addSubview(stackView)
        stackView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        translatesAutoresizingMaskIntoConstraints = false
        //creates the cards and number of Cards
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        bottomDivider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        bottomDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider.backgroundColor = .systemGray6
    }
    func addViewFriend(friend: Friends){
        friend.delegate = self
        friend.widthAnchor.constraint(equalToConstant: 220).isActive = true
        stackView.insertArrangedSubview(friend, at: 0)
    }
    func removeFriend(uid: String){
        stackView.subviews.forEach { (myView) in
         let view = myView as? Friends
            if view?.uid == uid{
                view?.removeFromSuperview()
            }
        }
    }
    //MARK: action is initiated
    @objc fileprivate func FriendsSearch(){
        delegate?.searchHit(MessageType: MessageType)
    }
    var makeSmallOrBig:Int?
    @objc fileprivate func editViewFriends(){
        //setupLayout2()
        if makeSmallOrBig ?? 0 % 2 == 0 {
            self.delegate?.makeBigger(MessageType: MessageType)
        }else{
            self.delegate?.makeSmaller(MessageType: MessageType)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
