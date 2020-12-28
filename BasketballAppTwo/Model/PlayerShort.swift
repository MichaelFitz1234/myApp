//
//  PlayerShort.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/12/20.
//


import Foundation
import FirebaseFirestore
struct PlayerShort {
    let Username, profileImageUrl, uid: String
    var lastMsg: String?, timestamp: Timestamp?
    init(dictionary: [String: Any]) {
        self.Username = dictionary["Username"] as? String ?? ""
        self.profileImageUrl = dictionary["imagePath"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.lastMsg = dictionary["lastMsg"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp
    }
}
