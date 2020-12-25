//
//  FirebaseMessages.swift
//  BasketballAppTwo
//
//  Created by Michael Fitzgerald on 12/20/20.
//

import Foundation
struct ChatMessages{
    let message: String
    let incoming: Bool
    let date:Date
    init(dictionary: [String: Any]) {
        self.message = dictionary["Message"] as? String ?? ""
        self.incoming = dictionary["incoming"] as? Bool ?? false
        self.date = dictionary["timestamp"] as? Date ?? Date()
    }
}
