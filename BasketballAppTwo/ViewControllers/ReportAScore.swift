//
//  ReportAScore.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/4/21.
//
import UIKit
class ReportAScore: UIViewController {
    let numberOfGamesBar = UISlider()
    let numberValue = UILabel()
    let stackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        view.backgroundColor = .white
        let navigationView = UIView()
        view.addSubview(navigationView)
        navigationView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        navigationView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        let myView2 = UIView()
        view.addSubview(myView2)
        myView2.anchor(top: nil, leading: view.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: view.trailingAnchor)
        myView2.heightAnchor.constraint(equalToConstant: 3).isActive = true
        myView2.backgroundColor = .systemGray6
        let myImg = UIImage(systemName: "arrow.left")
        let backArrow = UIButton()
        backArrow.setImage(myImg, for: .normal)
        backArrow.addTarget(self, action: #selector(backHit), for: .touchUpInside)
        navigationView.addSubview(backArrow)
        backArrow.anchor(top: nil, leading: view.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 15, bottom: 35, right: 0),size: .init(width: 20, height: 20))
        let currentUsrImg = UIImageView()
        navigationView.addSubview(currentUsrImg)
        let nextUsrImg = UIImageView()
        navigationView.addSubview(nextUsrImg)
        currentUsrImg.backgroundColor = .yellow
        nextUsrImg.backgroundColor = .orange
        currentUsrImg.anchor(top: nil, leading: view.leadingAnchor, bottom: navigationView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: screenWidth/3, bottom: 30, right: 0), size: .init(width: 40, height: 40))
        let myLabel = UILabel()
        navigationView.addSubview(myLabel)
        myLabel.text = "Vs."
        myLabel.anchor(top: nil, leading: currentUsrImg.trailingAnchor, bottom: navigationView.bottomAnchor, trailing: nil,padding: .init(top: 0, left: 13, bottom: 35, right: 0))
        nextUsrImg.anchor(top: nil, leading: myLabel.trailingAnchor, bottom: navigationView.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 30, right: 0),size: .init(width: 40, height: 40))
        let numberOfGames = UILabel()
        numberOfGames.text = "Number of game played:"
        view.addSubview(numberOfGames)
        numberOfGames.anchor(top: navigationView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: .init(top: 20, left: screenWidth/4, bottom: 0, right: 0))
        view.addSubview(numberValue)
        numberValue.anchor(top: numberOfGames.bottomAnchor, leading: nil, bottom: nil, trailing: numberOfGames.trailingAnchor,padding: .init(top: 3, left: 0, bottom: 0, right: 80))
        numberValue.text = "1"
        view.addSubview(numberOfGamesBar)
        numberOfGamesBar.anchor(top: numberValue.bottomAnchor, leading: numberOfGames.leadingAnchor, bottom: nil, trailing: numberOfGames.trailingAnchor,padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        numberOfGamesBar.minimumValue = 1
        numberOfGamesBar.maximumValue = 10
        numberValue.text = String(Int(numberOfGamesBar.value))
        numberOfGamesBar.addTarget(self, action: #selector(hitSlider), for: .allEvents)
        stackView.axis = .vertical
        stackView.isUserInteractionEnabled = true
        let Scrollview = UIScrollView()
        Scrollview.isUserInteractionEnabled = true
        let submitButton = UIButton(type: .system)
        submitButton.tintColor = .white
        view.addSubview(submitButton)
        submitButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: nil, padding: .init(top: 0, left: screenWidth/3, bottom: 40, right: 0), size: .init(width: 130, height: 60))
        submitButton.layer.cornerRadius = 14
        submitButton.setTitle("Submit Score", for: .normal)
        submitButton.backgroundColor = .systemGray
        submitButton.titleLabel?.textColor = .white
        view.addSubview(Scrollview)
        Scrollview.anchor(top: numberOfGamesBar.bottomAnchor, leading: view.leadingAnchor, bottom: submitButton.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        Scrollview.addSubview(stackView)
        stackView.isUserInteractionEnabled = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.anchor(top: Scrollview.topAnchor, leading: Scrollview.leadingAnchor, bottom: Scrollview.bottomAnchor, trailing: Scrollview.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        let reportCell = ReportScoreStackCell()
        reportCell.scoreValue = count
        reportCell.isUserInteractionEnabled = true
        stackView.addArrangedSubview(reportCell)
    }
    var count = 1
    var previousNumberValue = 1
    @objc fileprivate func backHit(){
        let myController = myTabBarController()
        myController.modalPresentationStyle = .fullScreen
        myController.selectedIndex = 2
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(myController, animated: false) {
        }
    }
    @objc fileprivate func hitSlider(){
        numberValue.text = String(Int(numberOfGamesBar.value))
        if(Int(numberOfGamesBar.value) - previousNumberValue > 0){
            let difference = abs(Int(numberOfGamesBar.value) - previousNumberValue)
            for _ in 1...difference {
                let reportCell = ReportScoreStackCell()
                count = count + 1
                reportCell.scoreValue = count
                stackView.addArrangedSubview(reportCell)
            }
        }else if(Int(numberOfGamesBar.value) - previousNumberValue < 0){
            let difference = abs(Int(numberOfGamesBar.value) - previousNumberValue)
            for _ in 1...difference {
            count = count - 1
            stackView.subviews.last?.removeFromSuperview()
            }
        }
        previousNumberValue = Int(numberOfGamesBar.value)
    }
}
