//
//  Tournemaents.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/13/21.
//

import UIKit

class Tournemaents: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let Navigation = UIView()
        view.addSubview(Navigation)
        let bottomDivider = UIView()
        Navigation.addSubview(bottomDivider)
        Navigation.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        Navigation.heightAnchor.constraint(equalToConstant: 120).isActive = true
        bottomDivider.anchor(top: nil, leading: Navigation.leadingAnchor, bottom: Navigation.bottomAnchor, trailing: Navigation.trailingAnchor)
        bottomDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider.backgroundColor = .systemGray6
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let bigView = UIView()
        let Scrollview = UIScrollView()
        Scrollview.isUserInteractionEnabled = true
        view.addSubview(Scrollview)
        Scrollview.anchor(top: Navigation.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        Scrollview.addSubview(bigView)
        bigView.isUserInteractionEnabled = true
        bigView.translatesAutoresizingMaskIntoConstraints = false
        bigView.anchor(top: Scrollview.topAnchor, leading: Scrollview.leadingAnchor, bottom: Scrollview.bottomAnchor, trailing: Scrollview.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0),size: .init(width: 580, height: screenHeight/2))
        let someView = myTournamentCell()
        let someView1 = myTournamentCell()
        let someView2 = myTournamentCell()
        let someView3 = myTournamentCell()
        let secondRound = myTournamentCell()
        let secondRound2 = myTournamentCell()
        let myThirdRoundCell = myTournamentCell()
        let stackView = UIStackView()
        bigView.addSubview(stackView)
        stackView.anchor(top: bigView.topAnchor, leading: bigView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 40, left: 10, bottom: 140, right: 0))
        stackView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 640).isActive = true
        stackView.addArrangedSubview(someView)
        stackView.addArrangedSubview(someView1)
        stackView.addArrangedSubview(someView2)
        stackView.addArrangedSubview(someView3)
        stackView.spacing = 60
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        view.backgroundColor = .white
        let mySecondRound = UIStackView()
        bigView.addSubview(mySecondRound)
        mySecondRound.anchor(top: stackView.topAnchor, leading: stackView.trailingAnchor, bottom: stackView.bottomAnchor, trailing: nil, padding: .init(top: 60, left: 10, bottom: 60, right: 0))
        mySecondRound.addArrangedSubview(secondRound)
        mySecondRound.addArrangedSubview(secondRound2)
        mySecondRound.widthAnchor.constraint(equalToConstant: 140).isActive = true
        mySecondRound.spacing = 140
        mySecondRound.axis = .vertical
        mySecondRound.distribution = .fillEqually
        let myThirdRound = UIStackView()
        bigView.addSubview(myThirdRound)
        myThirdRound.anchor(top: mySecondRound.topAnchor, leading: mySecondRound.trailingAnchor, bottom: mySecondRound.bottomAnchor, trailing: nil, padding: .init(top: 60, left: 10, bottom: 60, right: 0))
        myThirdRound.addArrangedSubview(myThirdRoundCell)
        myThirdRound.widthAnchor.constraint(equalToConstant: 140).isActive = true
        myThirdRound.spacing = 140
        myThirdRound.axis = .vertical
        myThirdRound.distribution = .fillEqually
        let winner = UIView()
        bigView.addSubview(winner)
        winner.anchor(top: myThirdRound.topAnchor, leading: myThirdRound.trailingAnchor, bottom: nil, trailing: nil,padding: .init(top: 200, left: 10, bottom: 0, right: 0),size: .init(width: 100, height: 3))
        winner.backgroundColor = .black
    }
}
