//
//  SocialPage.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/28/20.
//

import UIKit

class SocialPage: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let topView = UIView()
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.indexDisplayMode = .automatic
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        view.addSubview(topView)
        topView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        topView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        topView.backgroundColor = .yellow
        view.addSubview(scrollView)
        scrollView.anchor(top: topView.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        scrollView.backgroundColor = .clear
        let view1 = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()
        view1.backgroundColor = .yellow
        view2.backgroundColor = .green
        view3.backgroundColor = .orange
        view4.backgroundColor = .blue
        let stackView = UIStackView(arrangedSubviews: [view1, view2, view3, view4])
        stackView.backgroundColor = .yellow
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        scrollView.addSubview(stackView)
        stackView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        //stackView.heightAnchor.constraint(equalToConstant: 1500).isActive = true
        stackView.sendSubviewToBack(scrollView)
    }
}
