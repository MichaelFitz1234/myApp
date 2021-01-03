//
//  NavigationSocial.swift
//  BasketballAppTwo
//
//  Created by Michael  on 12/31/20.
//

import UIKit
class NavigationSocial: UIView {
    var PicImage = UIImage(imageLiteralResourceName: "Image"){
        didSet{
            self.profilePic.image = PicImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let profilePic = UIImageView()
    fileprivate func setupLayout(){
        let playButtonImage = UIImage(systemName: "gearshape.fill")
        playButtonImage?.withTintColor(.gray)
        let playButtonImageField = UIImageView()
        playButtonImageField.tintColor = .white
        playButtonImageField.image = playButtonImage
        let editProfileButton = UIImage(systemName: "slider.horizontal.below.square.fill.and.square")
        let editProfileButtonField = UIButton()
        editProfileButtonField.setImage(editProfileButton, for: .normal)
        let username = UILabel()
        let Elo = UILabel()
        let editProfile = UIButton(type: .system)
        editProfile.titleLabel?.textColor = .white
        editProfile.titleLabel?.tintColor = .white
        editProfile.addTarget(self, action: #selector(editProfileHit), for: .touchUpInside)
        let playButton = UIButton(type: .system)
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        addSubview(profilePic)
        profilePic.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 15, bottom: 0, right: 0),size: .init(width: 50, height: 50))
        profilePic.backgroundColor = .gray
        profilePic.layer.cornerRadius = 25
        profilePic.clipsToBounds = true
        profilePic.image?.withRenderingMode(.alwaysOriginal)
        profilePic.contentMode = .scaleAspectFill
        profilePic.backgroundColor = .gray
        backgroundColor = .white
        addSubview(editProfile)
        editProfile.anchor(top: topAnchor, leading: profilePic.trailingAnchor, bottom: nil, trailing: nil , padding: .init(top: 38, left: 10, bottom: 0, right: 0),size: .init(width: 150, height: 30))
        editProfile.setTitle("Edit Profile", for: .normal)
        editProfile.backgroundColor = .systemGray
        //editProfile.setTitleColor(.darkGray, for: .normal)
        editProfile.layer.cornerRadius = 7
        editProfile.addSubview(playButtonImageField)
        playButtonImageField.anchor(top: editProfile.topAnchor, leading: editProfile.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 8, left: -24, bottom: 0, right: 0),size: .init(width: 15, height: 15))
        addSubview(playButton)
        let aboutAndOne = UIButton(type: .system)
        aboutAndOne.setTitle("About andOne", for: .normal)
        addSubview(aboutAndOne)
        aboutAndOne.tintColor = .black
        aboutAndOne.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 24, left: 0, bottom: 0, right: 34))
        let information = UIImage(systemName: "info.circle.fill")
        let informationView = UIButton(type: .system)
        informationView.tintColor = .black
        addSubview(informationView)
        informationView.setImage(information, for: .normal)
        addSubview(informationView)
        informationView.addTarget(self, action: #selector(infoButtonHit), for: .touchUpInside)
        informationView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 28, left: 0, bottom: 0, right: 10), size: .init(width: 20, height: 20))
        playButton.anchor(top: aboutAndOne.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 36))
        playButton.setTitle("Report A Score", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.addTarget(self, action: #selector(ReportAScore), for: .touchUpInside)
        addSubview(editProfileButtonField)
        editProfileButtonField.tintColor = .gray
        editProfileButtonField.anchor(top: playButton.topAnchor, leading: playButton.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 5, left: 3, bottom: 0, right: 0))
        editProfileButtonField.addTarget(self, action: #selector(ReportAScore), for: .touchUpInside)
        let bottomDivider = UIView()
        addSubview(bottomDivider)
        bottomDivider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        bottomDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider.backgroundColor = .systemGray6
        
    }
    @objc fileprivate func editProfileHit(){
        
    }
    @objc fileprivate func infoButtonHit(){
    }
    @objc fileprivate func ReportAScore(){
        
    }
    
    //This is for the searchBar Selected
    @objc fileprivate func FriendsSearch(){
        
    }
    //carrot selected
    @objc fileprivate  func editViewFriends(){
        
    }
}
