//this is for a last message
import UIKit
import FirebaseFirestore
struct lastMsg {
    //defining out properties for our model layer
    let uid: String?
    let username: String?
    let imageUrl: String?
    let lastMsg: String?
    let timestamp: Timestamp?
    init(dictionary: [String: Any]){
        self.uid = dictionary["uid"] as? String
        self.username = dictionary["username"] as? String
        self.imageUrl = dictionary["imagePath"] as? String
        self.timestamp = dictionary["timestamp"] as? Timestamp
        self.lastMsg = dictionary["lastMsg"] as? String
    }
}
