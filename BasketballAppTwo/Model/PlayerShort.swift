//
//  PlayerShort.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/12/20.
//


import Foundation

struct PlayerShort {
    let name, profileImageUrl, uid: String
    var lastMsg: String?, timestamp: Date?
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.lastMsg = dictionary["lastMsg"] as? String
        self.timestamp = dictionary["timestamp"] as? Date
    }
}
