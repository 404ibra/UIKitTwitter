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
    
    func fetchUser(completion: @escaping (UserModel) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
       
        
        Firestore.firestore().collection("Users").document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() as? [String : AnyObject] else { return }
            
            let user = UserModel(uid: uid, snapshotDictionary: dictionary)
            completion(user)
        }
    }
}
