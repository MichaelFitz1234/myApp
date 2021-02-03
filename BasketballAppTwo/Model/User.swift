//
//  User.swift
//  tinderCloneSwiping
//
//  Created by Michael Fitzgerald on 11/18/20.
//
//
import UIKit
import FirebaseFirestore
struct User {
    //defining out properties for our model layer
    let uid: String?
    let Username: String?
    let age: NSDate?
    let Elo: Int?
    let imageUrl: String?
    let email: String?
    let location: GeoPoint?
    init(dictionary: [String: Any]){
        self.uid = dictionary["uid"] as? String
        self.Username = dictionary["username"] as? String
        self.age = dictionary["DOB"] as? NSDate
        self.Elo = dictionary["currElo"] as? Int
        self.imageUrl = dictionary["imagePath"] as? String
        self.email = dictionary["username"] as? String
        self.location = dictionary["location"] as? GeoPoint
    }
}


