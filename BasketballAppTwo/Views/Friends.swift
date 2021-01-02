//
//  Friends.swift
//  BasketballAppTwo
//
//  Created by Michael  on 12/29/20.
//

import UIKit
protocol FriendsViewDelgate {
    func ImageSelected(myView: UIView)
}
class Friends: UIView {
    var messageType = 3{
        didSet {
            switch messageType {
            //this is the case for following usr
            case 0:
              addSubview(AcceptFollow)
                AcceptFollow.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 3), size: .init(width: 50, height: 20))
            //this is a case for friends
            case 1:
              addSubview(MessageButton)
                MessageButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 3),size: .init(width: 70, height: 20))
              addSubview(ReportScore)
                ReportScore.anchor(top: MessageButton.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 3),size: .init(width: 60, height: 20))
            case 2:
                addSubview(Unfollow)
                Unfollow.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 3),size: .init(width: 60, height: 20))
            case 3:
                addSubview(Ranking)
                Ranking.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 3),size: .init(width: 60, height: 20))
            default:
                print("sad")
            }
        }
    }
    let Ranking:UILabel = {
        let button = UILabel()
        button.text = "Rank 1"
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
        setupLayout()
        let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetViewDidTapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
    }
    @objc fileprivate func targetViewDidTapped(){
        self.delegate?.ImageSelected(myView: self)
    }
    var Userimage: UIImageView = UIImageView()
    let gradientLayer = CAGradientLayer()
    //have to set locationusername
    let locationUsername = UILabel()
    //have to set userimage
    //have to set Elo
    let Elo = UILabel()
    fileprivate let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(imageLiteralResourceName: "info_icon")
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var myImg = UIImage(imageLiteralResourceName: "shootingImageInitialPage")
    fileprivate func setupLayout(){
       self.Userimage.image?.withRenderingMode(.alwaysOriginal)
       self.Userimage.contentMode = .scaleAspectFill
       Userimage.image = myImg
       addSubview(Userimage)
       Userimage.fillSuperview()
       layer.cornerRadius = 10
       clipsToBounds = true
       addSubview(locationUsername)
       locationUsername.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 16, right: 16))
       locationUsername.font = .systemFont(ofSize: 12, weight: .semibold)
       locationUsername.textColor = .white
       locationUsername.numberOfLines = 0
       locationUsername.text = "Michael Fitzgerald \n 22 miles away"
       addSubview(Elo)
       Elo.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 5, bottom: 0, right: 0))
       Elo.numberOfLines = 0
       Elo.textColor = .white
       Elo.numberOfLines = 0
       Elo.text = "1200"
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
   }
}
