//
//  UserInformation.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/5/20.
//

import UIKit

class UserInformation: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    let navigationBar = UIView()
    let navBarText = UILabel()
    let leftPicture = InformationLeftImage(image: nil)
    let rightText = InformationRight()
    let mainView = UIView()
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        myTable.delegate = self
        myTable.dataSource = self
        view.addSubview(mainView)
        mainView.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        mainView.fillSuperview()
        mainView.addSubview(navigationBar)
        navigationBar.anchor(top: mainView.topAnchor, leading: mainView.leadingAnchor, bottom: nil, trailing: mainView.trailingAnchor)
        navigationBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        navigationBar.backgroundColor = .systemGray5
        navigationBar.addSubview(navBarText)
        navBarText.anchor(top: navigationBar.topAnchor, leading: navigationBar.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: ScreenWidth/2, bottom: 0, right: 0))
        navBarText.text = "Player Details"
        navBarText.textColor = .black
        navBarText.font = .systemFont(ofSize: 15, weight: .bold)
        mainView.addSubview(leftPicture)
        leftPicture.anchor(top: navigationBar.bottomAnchor, leading: mainView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        leftPicture.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.55).isActive = true
        leftPicture.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5).isActive = true
        mainView.addSubview(rightText)
        rightText.anchor(top: navigationBar.bottomAnchor, leading: nil, bottom: nil, trailing: mainView.trailingAnchor)
        rightText.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        rightText.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.5).isActive = true
        rightText.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.45).isActive = true
        mainView.addSubview(myTable)
        myTable.anchor(top: rightText.bottomAnchor, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor)
        myTable.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        
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
        return 50
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.myTable.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell?)!
            // set the text from the data model
        var myString:NSString = "L 12 - 10  Michael (1200) Vs. Ethan (1100)"
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 18.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:0,length:1))
        // set label Attribute
        cell.textLabel?.attributedText = myMutableString
        cell.heightAnchor.constraint(equalToConstant: 35).isActive = true
        cell.backgroundColor = UIColor.white
        //cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        //cell.anch
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  
    print("You tapped cell number \(indexPath.row).")
    }
}
