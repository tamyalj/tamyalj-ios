//
//  Users.swift
//  MyVisits
//
//  Created by Ahmed Al Neyadi on 7/9/19.
//  Copyright © 2019 FatimaAljassmi. All rights reserved.
//

import Foundation
import Firebase
class Users {
    
    static var currentUserProfile:UserProfile?
    
    static func observeUserProfile(_ uid:String, completion: @escaping ((_ userProfile:UserProfile?)->())) {
        let userRef = Database.database().reference().child("users/profile/\(uid)")
        
        userRef.observe(.value, with: { snapshot in
            var userProfile:UserProfile?
            
            if let dict = snapshot.value as? [String:Any],
                let email = dict["userEmail"] as? String
            {
             userProfile = UserProfile(uid: snapshot.key, email:email)
            }
            
            completion(userProfile)
        })
    }
}
    

class UserProfile {
    var uid:String
    var email:String
    
    init(uid:String, email:String){
        self.uid = uid
        self.email = email

}
}
