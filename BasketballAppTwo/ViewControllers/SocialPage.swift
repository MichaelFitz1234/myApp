//  SocialPage.swift
//  BasketballAppTwo
//  Created by Michael Fitzgerald on 12/28/20.

import UIKit
class SocialPage: UIViewController, UIScrollViewDelegate, FollowersPageProtocol{
    var count = 0
    func makeFullScreen(myViewControllers: UIViewController) {
        present(myViewControllers, animated: true, completion: nil)
    }
    func makeBigger(MessageType: Int) {
        switch MessageType {
        case 0:
            FollowersLarge.isHidden = false
            scrollViewContainer.insertArrangedSubview(FollowersLarge, at: 3)
            scrollViewContainer.removeArrangedSubview(Followers)
        case 1:
            FriendsViewLarge.isHidden = false
            scrollViewContainer.insertArrangedSubview(FriendsViewLarge, at: 2)
            scrollViewContainer.removeArrangedSubview(FriendsView)
        case 2:
            FollowingLarge.isHidden = false
            scrollViewContainer.insertArrangedSubview(FollowingLarge, at: 4)
            scrollViewContainer.removeArrangedSubview(Following)
        case 3:
            GlobalLarge.isHidden = false
            scrollViewContainer.insertArrangedSubview(GlobalLarge, at: 5)
            scrollViewContainer.removeArrangedSubview(Global)
        default:
            print("sadddd")
        }
    
    }
    func makeSmaller(MessageType: Int){
        switch MessageType {
        case 0:
            scrollViewContainer.insertArrangedSubview(Followers, at: 3)
            scrollViewContainer.removeArrangedSubview(FollowersLarge)
            FollowersLarge.isHidden = true
        case 1:
            scrollViewContainer.insertArrangedSubview(FriendsView, at: 2)
            scrollViewContainer.removeArrangedSubview(FriendsViewLarge)
            FriendsViewLarge.isHidden = true
        case 2:
            scrollViewContainer.insertArrangedSubview(Following, at: 4)
            scrollViewContainer.removeArrangedSubview(FollowingLarge)
            FollowingLarge.isHidden = true
        case 3:
            scrollViewContainer.insertArrangedSubview(Global, at: 5)
            scrollViewContainer.removeArrangedSubview(GlobalLarge)
            GlobalLarge.isHidden = true
        default:
            print("sadddd")
        }
    }
  
    func makeLargeAgain(myFollowersPage: FollowersPage) -> FollowersPage{
        myFollowersPage.isLarge = true
        myFollowersPage.big = false
        myFollowersPage.MessageType = 0
        myFollowersPage.makeSmallOrBig = 1
        return myFollowersPage
    }
   
    func searchHit(MessageType: Int) {
        let controller = plusButtonHitViewController()
        controller.messageType = MessageType
        present(controller, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupView()
        FriendsView.delegate = self
        FriendsViewLarge.delegate = self
        Followers.delegate = self
        Following.delegate = self
        FollowingLarge.delegate = self
        Global.delegate = self
        GlobalLarge.delegate = self
        FollowersLarge.delegate = self
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var newFrame = NavigationView.frame
        newFrame.origin.y = max(self.initialOffSet, scrollView.contentOffset.y)
        NavigationView.frame = newFrame
    }
    fileprivate func setupView() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        scrollViewContainer.addArrangedSubview(NavigationView)
        NavigationView.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        scrollViewContainer.addArrangedSubview(NewRequests)
        scrollViewContainer.addArrangedSubview(FriendsView)
        scrollViewContainer.addArrangedSubview(Followers)
        scrollViewContainer.addArrangedSubview(Following)
        scrollViewContainer.addArrangedSubview(Global)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        initialOffSet = NavigationView.frame.origin.y
    }
    var initialOffSet = CGFloat(0)
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let NavigationView = NavigationSocial()
    //this is used to show the friends
    let Followers: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.isLarge = false
        myFollowersPage.MessageType = 0
        return myFollowersPage
    }()
    let FollowersLarge: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.isLarge = true
        myFollowersPage.big = false
        myFollowersPage.MessageType = 0
        myFollowersPage.makeSmallOrBig = 1
        return myFollowersPage
    }()
    let FriendsView: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.isLarge = false
        myFollowersPage.MessageType = 1
        return myFollowersPage
    }()
    let FriendsViewLarge: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.isLarge = true
        myFollowersPage.big = false
        myFollowersPage.MessageType = 1
        myFollowersPage.makeSmallOrBig = 1
        return myFollowersPage
    }()
  
    let Following: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.MessageType = 2
        return myFollowersPage
    }()
    let FollowingLarge: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.isLarge = true
        myFollowersPage.big = false
        myFollowersPage.MessageType = 2
        myFollowersPage.makeSmallOrBig = 1
        return myFollowersPage
    }()
    let Global: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.isLarge = false
        myFollowersPage.MessageType = 3
        return myFollowersPage
    }()
    let GlobalLarge: FollowersPage = {
        let myFollowersPage = FollowersPage()
        myFollowersPage.isLarge = true
        myFollowersPage.big = false
        myFollowersPage.MessageType = 3
        myFollowersPage.makeSmallOrBig = 1
        return myFollowersPage
    }()
    let NewRequests: UIView = NotificationsSocialPage()
}
