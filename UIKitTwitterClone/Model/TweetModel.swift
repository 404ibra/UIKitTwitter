//
//  TweetModel.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 11.02.2024.
//

import Foundation

struct Tweet: Codable {
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    var timestamp: Date!
    let retweetCount: Int
    let user: UserModel
    
    init(user: UserModel, tweetID: String, dictionary: [String : Any]) {
        self.tweetID = tweetID
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid =  dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount =  dictionary["retweetCount"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
    }
}
