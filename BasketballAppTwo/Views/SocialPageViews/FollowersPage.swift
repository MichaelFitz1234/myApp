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
}
class FollowersPage: UIView,FriendsViewDelgate {
    func ImageSelected(myView: UIView) {
        let controller = FullPlayerView()
        controller.playCard = myView
        self.delegate?.makeFullScreen(myViewControllers: controller)
    }
    var isLarge = false
    let scrollView = UIScrollView()
    var MessageType = 1{
        didSet {
            switch MessageType {
            //this is the case for following usr
            case 0:
                FriendsLabel.setTitle("Followers/Follow Requests", for: .normal)
                Thewidth = 203
                if isLarge == true{
                  setupLayout2()
                }else {
                   setupLayout()
                }
            //this is a case for friends
            case 1:
                FriendsLabel.setTitle("Friends", for: .normal)
                Thewidth = 58
                if isLarge == true{
                  setupLayout2()
                }else {
                   setupLayout()
                }
            case 2:
                FriendsLabel.setTitle("Following", for: .normal)
                Thewidth = 73
                if isLarge == true{
                  setupLayout2()
                }else {
                   setupLayout()
                }
            case 3:
                FriendsLabel.setTitle("Global Leaderboard", for: .normal)
                Thewidth = 152
                if isLarge == true{
                  setupLayout2()
                }else {
                   setupLayout()
                }
            default:
                print("sadness")
            }
        }
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
    let FriendsLabel = UIButton(type: .system)
    var Thewidth = 58
    let stackView = UIStackView()
    let view1 = Friends()
    let view2 = Friends()
    let view3 = Friends()
    let view4 = Friends()
    var makeSmaller = UIImage(systemName: "chevron.left")
    var delegate: FollowersPageProtocol?
    let makeSmallerImgView = UIButton(type: .system)
    let bottomDivider = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setupLayout(){
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
        view1.messageType = MessageType
        view2.messageType = MessageType
        view3.messageType = MessageType
        view4.messageType = MessageType
        view1.delegate = self
        view2.delegate = self
        view3.delegate = self
        view4.delegate = self
        view1.widthAnchor.constraint(equalToConstant: 220).isActive = true
        view2.widthAnchor.constraint(equalToConstant: 220).isActive = true
        view3.widthAnchor.constraint(equalToConstant: 220).isActive = true
        view4.widthAnchor.constraint(equalToConstant: 220).isActive = true
        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        stackView.addArrangedSubview(view3)
        stackView.addArrangedSubview(view4)
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        addSubview(bottomDivider)
        bottomDivider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        bottomDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider.backgroundColor = .systemGray6
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
            //setupLayout()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
