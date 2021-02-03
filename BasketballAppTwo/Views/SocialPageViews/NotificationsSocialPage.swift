//
//  NotificationsSocialPage.swift
//  BasketballAppTwo
//
//  Created by Michael  on 12/31/20.
//

import UIKit

class NotificationsSocialPage: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    fileprivate func setupLayout(){
        heightAnchor.constraint(equalToConstant: 210).isActive = true
        let FriendsLabel = UILabel()
        addSubview(FriendsLabel)
        FriendsLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        FriendsLabel.text = "New Notifications"
        FriendsLabel.font = .boldSystemFont(ofSize: 13)
        FriendsLabel.textColor = .systemBlue
        backgroundColor = .white
        let bottomDivider = UIView()
        addSubview(bottomDivider)
        bottomDivider.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        bottomDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider.backgroundColor = .systemGray6
        let stackView = UIStackView()
        stackView.axis = .horizontal
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        scrollView.anchor(top: FriendsLabel.bottomAnchor, leading: leadingAnchor , bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 10, right: 0))
        scrollView.addSubview(stackView)
        stackView.spacing = 5
        stackView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        translatesAutoresizingMaskIntoConstraints = false
        let view1 = ConfirmScore()
        let view2 = ConfirmScore()
        let view3 = ConfirmScore()
        view1.widthAnchor.constraint(equalToConstant: 270).isActive = true
        view1.backgroundColor = .systemGray6
        view2.widthAnchor.constraint(equalToConstant: 270).isActive = true
        view2.backgroundColor = .systemGray6
        view3.widthAnchor.constraint(equalToConstant: 270).isActive = true
        view3.backgroundColor = .systemGray6
        stackView.addArrangedSubview(view1)
        stackView.addArrangedSubview(view2)
        stackView.addArrangedSubview(view3)
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
