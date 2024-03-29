//
//  NavigationForMap.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/9/21.
//
import UIKit
import FirebaseStorage
protocol NavigationSocialDelegateMap {
    func CreateChallenge()
    func addATournament()
    func reportAScore()
}
class NavigationSocialForMap: UIView {
    var PicImage = ""{
        didSet{
            let storageRef = Storage.storage().reference(withPath: PicImage ?? "")
            storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
                if let error = error{
                    print("Got an error fetching data: \(error.localizedDescription)")
                    return
                }else{
                    if let data = data{
                        self.profilePic.image = UIImage(data: data)
                    }
                }
            }        }
    }
    var delegate: NavigationSocialDelegateMap?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let profilePic = UIImageView()
    fileprivate func setupLayout(){
        let editProfile = UIButton(type: .system)
        editProfile.titleLabel?.textColor = .white
        editProfile.titleLabel?.tintColor = .white
        editProfile.addTarget(self, action: #selector(CreateChallenge), for: .touchUpInside)
        let playButton = UIButton(type: .system)
        //heightAnchor.constraint(equalToConstant: 100).isActive = true
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
        editProfile.setTitle("Create A Challenge", for: .normal)
        editProfile.backgroundColor = .systemGray
        editProfile.layer.cornerRadius = 7
        addSubview(playButton)
        let aboutAndOne = UIButton(type: .system)
        aboutAndOne.setTitle("Tournament", for: .normal)
        aboutAndOne.addTarget(self, action: #selector(abAndOne), for: .touchUpInside)
        addSubview(aboutAndOne)
        let crownImage = UIImage(systemName: "crown.fill")
        let myCrownImageView = UIButton()
        myCrownImageView.setImage(crownImage, for: .normal)
        addSubview(myCrownImageView)
        aboutAndOne.tintColor = .black
        aboutAndOne.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 22, left: 0, bottom: 0, right: 34))
        myCrownImageView.anchor(top: topAnchor, leading: aboutAndOne.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 24, left: 4, bottom: 0, right: 0), size: .init(width: 20, height: 20))
        myCrownImageView.imageView?.tintColor = .gray
        let informationView = UIButton(type: .system)
        informationView.tintColor = .black
        addSubview(informationView)
        addSubview(informationView)
        informationView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 28, left: 0, bottom: 0, right: 10), size: .init(width: 20, height: 20))
        playButton.anchor(top: aboutAndOne.bottomAnchor, leading: nil, bottom: nil, trailing: trailingAnchor,padding: .init(top: 5, left: 0, bottom: 0, right: 29))
        playButton.setTitle("Report A Score", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.addTarget(self, action: #selector(ReportAScore), for: .touchUpInside)
        let bottomDivider = UIView()
        addSubview(bottomDivider)
        bottomDivider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        bottomDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider.backgroundColor = .systemGray6
        let editProfileButton = UIImage(systemName: "slider.horizontal.below.square.fill.and.square")
        let editProfileButtonField = UIButton()
        editProfileButtonField.setImage(editProfileButton, for: .normal)
        addSubview(editProfileButtonField)
        editProfileButtonField.tintColor = .gray
        editProfileButtonField.anchor(top: playButton.topAnchor, leading: playButton.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 5, left: 3, bottom: 0, right: 3))
        editProfileButtonField.addTarget(self, action: #selector(ReportAScore), for: .touchUpInside)
    }
    
    @objc fileprivate func CreateChallenge(){
        delegate?.CreateChallenge()
    }
    @objc fileprivate func ReportAScore(){
        delegate?.addATournament()
    }
     
    @objc fileprivate func abAndOne(){
        delegate?.reportAScore()
        }
    }
