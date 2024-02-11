//
//  TweetService.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 11.02.2024.
//

import Firebase

struct TweetService {
    
    static let shared = TweetService()
    let fileName = NSUUID().uuidString
    
    func uploadTweet(caption: String, completion: @escaping(Error?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweets": 0,
                      "caption": caption] as [String : Any]
        Firestore.firestore().collection("Tweets").document(fileName).setData(values, completion: completion)
        
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()
        Firestore.firestore().collection("Tweets").getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Error occured when fetching tweets: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                       print("DEBUG: No documents found.")
                       completion([])
                       return
                   }
                   
                   for document in documents {
                       do {
                           let data = document.data()
                           
                           guard let data = data as? [String: Any] else { return }
                           guard let uid = data["uid"] as? String else { return }
                           UserService.shared.fetchUser(uid: uid) { user in
                               let tweet = Tweet(user: user, tweetID: fileName, dictionary: data)
                               tweets.append(tweet)
                               completion(tweets)
                           }
                       } catch {
                           print("DEBUG: Error converting document to Tweet: \(error)")
                       }
                   }
                   
                   completion(tweets)
        }
    }
}
