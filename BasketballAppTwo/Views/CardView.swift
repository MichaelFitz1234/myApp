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
}

class CardView: UIView {
    var imageUrl = ""{
    didSet {
        let storageRef = Storage.storage().reference(withPath: imageUrl)
        storageRef.getData(maxSize: 4*1024*1024) { (data, error) in
        if let error = error{
        print("Got an error fetching data: \(error.localizedDescription)")
            return
            }else{
        if let data = data{
            self.Userimage.image = UIImage(data: data)
            self.Userimage.image?.withRenderingMode(.alwaysOriginal)
            self.Userimage.contentMode = .scaleAspectFill
            self.setupLayout()
                    }
                }
            }
        }
    }
    var nextCard: CardView?
    var previousCard: CardView?
    var delegate: CardViewDelegate?
    var Userimage: UIImageView = UIImageView()
    let gradientLayer = CAGradientLayer()
    //have to set locationusername
    let locationUsername = UILabel()
    //have to set userimage
    //have to set Elo
    let Elo = UILabel()
    fileprivate let followButton: UIButton = {
        let button = UIButton(type: .system)
        let color1 = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        button.backgroundColor = color1
        button.alpha = 1
        button.layer.cornerRadius = 8
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    fileprivate let moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(imageLiteralResourceName: "info_icon")
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
//    fileprivate func setUpImagefromDatabase(){
//        layer.borderColor = .init(red: 0, green: 0, blue: 140, alpha: 0.75)
//        layer.cornerRadius = 10
//        clipsToBounds = true
//        addSubview(Userimage)
//        sendSubviewToBack(Userimage)
//        Userimage.fillSuperview()
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setupLayout()
        // rotation
        // some not that scary math here to convert radians to degrees
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
    }
    fileprivate lazy var screenSize = UIScreen.main.bounds
    fileprivate lazy var ScreenWidth = screenSize.width+20
    var myResult: CardView?
    func nextCardSetup(){
        let rotationalTransformation = CGAffineTransform(rotationAngle: 0)
        nextCard?.transform = rotationalTransformation.translatedBy(x: ScreenWidth, y: 0)
    }
    func lastCardSetup(){
        let rotationalTransformation = CGAffineTransform(rotationAngle: 0)
        previousCard?.transform = rotationalTransformation.translatedBy(x: -ScreenWidth, y: 0)
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

    fileprivate let threshold: CGFloat = 100
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        if shouldDismissCard {
            // hack solution
            if translationDirection == 1 {
                self.delegate?.nextCardLeft(translation: -700)
            } else {
                self.delegate?.nextCardRight(translation: 700)
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
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        // rotation
        // some not that scary math here to convert radians to degrees
        let rotationalTransformation = CGAffineTransform(rotationAngle: 0)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: 0)
        nextCard?.transform = rotationalTransformation.translatedBy(x: translation.x+ScreenWidth, y: 0)
        previousCard?.transform = rotationalTransformation.translatedBy(x: translation.x-ScreenWidth, y: 0)
    }
    //this sets up the layout kinda messy could be done in fewer lines but going to go with ith for now
     func setupLayout(){
        layer.borderColor = .init(red: 0, green: 0, blue: 140, alpha: 0.75)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
