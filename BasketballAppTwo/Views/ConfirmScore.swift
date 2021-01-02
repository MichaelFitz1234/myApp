//
//  ConfirmScore.swift
//  BasketballAppTwo
//
//  Created by Michael  on 12/29/20.
//

import UIKit

class ConfirmScore: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupLayout(){
    let homePlayerImg1 = UIImageView()
    let awayPlayerImg1 = UIImageView()
    let homeImage = UIImage(imageLiteralResourceName: "Image")
    let awayImage = UIImage(imageLiteralResourceName: "shootingImageInitialPage")
        let homePlayerImg = makeProfileImage(image: homePlayerImg1)
        let awayPlayerImg = makeProfileImage(image: awayPlayerImg1)
        homePlayerImg.image = homeImage
        awayPlayerImg.image = awayImage
    let homePlayerLabel = UILabel()
    let awayPlayerLabel = UILabel()
    let Date = UILabel()
    addSubview(homePlayerImg)
        homePlayerImg.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 4, bottom: 0, right: 0),size: .init(width: 26, height: 26))
    addSubview(homePlayerLabel)
        homePlayerLabel.anchor(top: topAnchor, leading: homePlayerImg.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 25, left: 3, bottom: 0, right: 0))
        homePlayerLabel.text = "Michael(1200) vs. David(1300)"
        homePlayerLabel.textColor = .systemGray
        homePlayerLabel.font = .boldSystemFont(ofSize: 12)
    addSubview(awayPlayerImg)
        awayPlayerImg.anchor(top: topAnchor, leading: homePlayerLabel.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: 3, bottom: 0, right: 0),size: .init(width: 26, height: 26))
    addSubview(Date)
        Date.anchor(top: homePlayerImg.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 0, left: 85, bottom: 0, right: 0))
        Date.numberOfLines = 0
        var myString:NSString = "Date: 05/02/01 \n Score 11-8 W \n     Confirm:"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGray, range: NSRange(location:0,length:27))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: NSRange(location:28,length:1))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGray, range: NSRange(location:29,length:7))
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location:36,length:8))
        Date.attributedText = myMutableString
        //Date.textColor = .systemGray
        Date.font = .boldSystemFont(ofSize: 12)
        let ConfirmButton = UIButton()
        let wrongScore = UIButton()
        let myImage = UIImage(systemName: "checkmark.rectangle.fill")
        
        myImage?.withTintColor(.green)
        let myImage2 = UIImage(systemName: "xmark.rectangle.fill")
        myImage2?.withTintColor(.red)
        addSubview(ConfirmButton)
        ConfirmButton.anchor(top: Date.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 90, bottom: 0, right: 0))
        ConfirmButton.setImage(myImage, for: .normal)
        ConfirmButton.imageView?.contentMode = .scaleAspectFit
        ConfirmButton.contentVerticalAlignment = .fill
        ConfirmButton.contentHorizontalAlignment = .fill
        ConfirmButton.imageEdgeInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        ConfirmButton.tintColor = .green
        addSubview(wrongScore)
        wrongScore.anchor(top: Date.bottomAnchor, leading: ConfirmButton.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        wrongScore.setImage(myImage2, for: .normal)
        wrongScore.imageView?.contentMode = .scaleAspectFit
        wrongScore.contentVerticalAlignment = .fill
        wrongScore.contentHorizontalAlignment = .fill
        wrongScore.imageEdgeInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        wrongScore.tintColor = .red
    }
    fileprivate func makeProfileImage(image: UIImageView) ->UIImageView{
        image.backgroundColor = .gray
        image.layer.cornerRadius = 13
        image.clipsToBounds = true
        image.image?.withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        return image
    }
}

