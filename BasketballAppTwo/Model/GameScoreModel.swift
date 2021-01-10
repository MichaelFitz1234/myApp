//
//  GameScoreModel.swift
//  BasketballAppTwo
//
//  Created by Michael  on 1/10/21.
//

import Foundation
import FirebaseFirestore
struct GameScore {
    var player1: String?
    var player2: String?
    var date:Timestamp?
    var Player1Score: [Int]?
    var Playet2Score: [Int]?
    var gamesP1: Int?
    var gamesP2: Int?
    init(dictionary: [String: Any]) {
        self.player1 = dictionary["player1"] as? String ?? ""
        self.player2 = dictionary["player2"] as? String ?? ""
        self.Player1Score = dictionary["Player1Score"] as? [Int] ?? [0]
        self.Playet2Score = dictionary["Player2Score"] as? [Int] ?? [0]
        self.gamesP1 = dictionary["gamesP1"] as? Int ?? 0
        self.gamesP2 = dictionary["gamesP2"] as? Int ?? 0
    }
}
