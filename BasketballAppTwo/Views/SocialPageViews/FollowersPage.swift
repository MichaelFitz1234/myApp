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
    func reportScoreH()
}
class FollowersPage: UIView,FriendsViewDelgate {
    func reportScoreHit() {
        self.delegate?.reportScoreH()
    }
    
    func messageButtonHit(uid: String) {
        self.delegate?.messageButtonHit(uid: uid)
    }
    func ImageSelected(myView: UIView) {
        let controller = FullPlayerView()
        controller.playCard = myView
        self.delegate?.makeFullScreen(myViewControllers: controller)
    }
    var MessageType = 0
    let scrollView = UIScrollView()
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
    func setupLayout(){
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
        heightAnchor.constraint(equalToConstant: 65).isActive = true
        addSubview(FriendsLabel)
        FriendsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 20, bottom: 0, right: 0),size: .init(width: Thewidth, height: 30))
        makeSmallerImgView.setImage(makeSmaller, for: .normal)
        addSubview(makeSmallerImgView)
        makeSmallerImgView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 28, bottom: 0, right: 12),size: .init(width: 25, height: 22))
        makeSmallerImgView.addTarget(self, action: #selector(editViewFriends), for: .touchUpInside)
        makeSmallerImgView.tintColor = .systemGray2
        let searchImg = UIImage(systemName: "magnifyingglass.circle.fill")
        let thisImage = UIButton(type: .system)
        addSubview(thisImage)
        thisImage.setImage(searchImg, for: .normal)
        thisImage.addTarget(self, action: #selector(FriendsSearch), for: .touchUpInside)
        thisImage.tintColor = .systemGray3
        thisImage.anchor(top: topAnchor, leading: FriendsLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 19, left: 1, bottom: 0, right: 0),size: .init(width: 22, height: 22))
        thisImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        FriendsLabel.titleLabel?.font = .boldSystemFont(ofSize: 16)
        FriendsLabel.titleLabel?.textColor = .systemGray2
        FriendsLabel.addTarget(self, action: #selector(FriendsSearch), for: .touchUpInside)
        FriendsLabel.tintColor = .systemGray3
        //heightAnchor.constraint(equalToConstant: 65).isActive = true
        backgroundColor = .white
        addSubview(bottomDivider)
        bottomDivider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        bottomDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider.backgroundColor = .systemGray6
    }
    func setupLayout2(){
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
        heightAnchor.constraint(equalToConstant: 420).isActive = true
        addSubview(FriendsLabel)
        FriendsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 20, bottom: 0, right: 0),size: .init(width: Thewidth, height: 30))
        makeSmallerImgView.setImage(makeSmaller, for: .normal)
        addSubview(makeSmallerImgView)
        makeSmallerImgView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 17, left: 28, bottom: 0, right: 12),size: .init(width: 25, height: 22))
        makeSmallerImgView.addTarget(self, action: #selector(editViewFriends), for: .touchUpInside)
        makeSmallerImgView.tintColor = .systemGray2
        let searchImg = UIImage(systemName: "magnifyingglass.circle.fill")
        let thisImage = UIButton(type: .system)
        addSubview(thisImage)
        thisImage.setImage(searchImg, for: .normal)
        thisImage.addTarget(self, action: #selector(FriendsSearch), for: .touchUpInside)
        thisImage.tintColor = .systemGray3
        thisImage.anchor(top: topAnchor, leading: FriendsLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 19, left: 1, bottom: 0, right: 0),size: .init(width: 22, height: 22))
        thisImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        FriendsLabel.titleLabel?.font = .boldSystemFont(ofSize: 16)
        FriendsLabel.titleLabel?.textColor = .systemGray2
        FriendsLabel.addTarget(self, action: #selector(FriendsSearch), for: .touchUpInside)
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
        addSubview(bottomDivider)
        bottomDivider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        bottomDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider.backgroundColor = .systemGray6
        }
    func addViewFriend(friend: Friends){
        friend.delegate = self
        friend.widthAnchor.constraint(equalToConstant: 220).isActive = true
        stackView.addArrangedSubview(friend)
    }
    //MARK: action is initiated
    @objc fileprivate func FriendsSearch(){
        delegate?.searchHit(MessageType: MessageType)
    }
    var makeSmallOrBig:Int?
    @objc fileprivate  func editViewFriends(){
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
