//
//  UserService.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 9.02.2024.
//

import Foundation
import Firebase

final class UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String, completion: @escaping (UserModel) -> Void) {
        Firestore.firestore().collection("Users").document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() as? [String : AnyObject] else { return }
            
            let user = UserModel(uid: uid, snapshotDictionary: dictionary)
            completion(user)
        }
    }
}
