//
//  shortUsr.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/16/20.
//

import UIKit
struct shortUsr {
    //defining out properties for our model layer
    let uid: String?
    let Username: String?
    let imageUrl: String?
    init(dictionary: [String: Any]){
        self.uid = dictionary["uid"] as? String
        self.Username = dictionary["Username"] as? String
        self.imageUrl = dictionary["imagePath"] as? String
    }
}
