//
//  EditSettings.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/7/21.
//

import UIKit

class EditSettings: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource{
        let navigationBar = UIView()
        let navBarText = UILabel()
        let leftPicture = InformationLeftImage(image: nil)
        let rightText = InfoRight2()
        let myTable = UITableView()
        fileprivate lazy var screenSize = UIScreen.main.bounds
        fileprivate lazy var ScreenWidth = screenSize.width-80
        //let myCell = ScoreCell(style: .default, reuseIdentifier: "Ugly")
        lazy var myScrollView: UIScrollView = {
            let sv = UIScrollView()
            sv.alwaysBounceVertical = true
            sv.contentInsetAdjustmentBehavior = .never
            sv.delegate = self
            return sv
        }()
    fileprivate func setupLayout() {
        self.myTable.register(reportScoreCell.self, forCellReuseIdentifier: "cell")
        myTable.delegate = self
        myTable.dataSource = self
        view.backgroundColor = .white
        view.addSubview(navigationBar)
        navigationBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        navigationBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        navigationBar.backgroundColor = .systemGray6
        navigationBar.addSubview(navBarText)
        navBarText.anchor(top: navigationBar.topAnchor, leading: navigationBar.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: ScreenWidth/2, bottom: 0, right: 0))
        navBarText.text = "Player Details"
        navBarText.textColor = .black
        navBarText.font = .systemFont(ofSize: 15, weight: .bold)
        let bottomDivider = UIView()
        view.addSubview(bottomDivider)
        bottomDivider.anchor(top: nil, leading: view.leadingAnchor, bottom: navigationBar.bottomAnchor, trailing: view.trailingAnchor)
        bottomDivider.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider.backgroundColor = .systemGray3
        view.addSubview(leftPicture)
        leftPicture.anchor(top: navigationBar.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 3, left: 0, bottom: 0, right: 0))
        leftPicture.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.55).isActive = true
        leftPicture.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        view.addSubview(rightText)
        rightText.anchor(top: navigationBar.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor)
        rightText.backgroundColor = .white
        rightText.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        rightText.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
        let myLabel = UITextField()
        view.addSubview(myLabel)
        myLabel.anchor(top: leftPicture.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: .init(top: 10, left: 10, bottom: 16, right: 10))
        myLabel.text = "Games:"
        view.addSubview(myTable)
        myTable.anchor(top: myLabel.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        myTable.backgroundColor = .white
        let bottomDivider1 = UIView()
        view.addSubview(bottomDivider1)
        bottomDivider1.anchor(top: nil, leading: view.leadingAnchor, bottom: myLabel.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 4, left: 10, bottom: 0, right: 10))
        bottomDivider1.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomDivider1.backgroundColor = .systemGray6
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        setupLayout()
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
            }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 12
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 5
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.section == 0 {
            return 70
            }else {
            return 70
            }
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:UITableViewCell = (self.myTable.dequeueReusableCell(withIdentifier: "cell") as! reportScoreCell?)!
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        }
    }



