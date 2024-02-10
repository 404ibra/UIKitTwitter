//
//  AuthService.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 9.02.2024.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

final class AuthService {
    static let shared = AuthService()
    
    
    func logUserIn(withEmail email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Task {
           await Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        }
    }
    
    func registerUser(credentials: AuthCredentials) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("Profile-Images").child(fileName)
        
        
        
        storageRef.putData(imageData, metadata: nil) { meta, error in
            storageRef.downloadURL { url, error in
                guard let profileImageURL = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
                    if let error = error {
                        print("DEBUG: Account cant be created \(error)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    let values = ["email": credentials.email, "username": credentials.username, "fullname": credentials.fullname, "profileImageUrl": profileImageURL]
                    
                    Firestore.firestore().collection("Users").document(uid).setData(values) { error in
                        if let error = error {
                            print("DEBUG: Error when new collection added \(error)")
                            return
                        }
                    }
                    
                }
                
                
                
            }
        }
    }
}
