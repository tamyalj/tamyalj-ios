//
//  DBProvider.swift
//  MyVisits
//
//  Created by Ahmed Al Neyadi on 7/4/19.
//  Copyright © 2019 FatimaAljassmi. All rights reserved.
//

import Foundation
import FirebaseDatabase
class Constants { // static var in other classes
    //DBProvider
    // User Regestriation Constants

    static let email = "email"
    static let password = "password"
      static let user = "user"
    static let data = "data"
    
}


class DBProvider { //singletone
    private static let _instance = DBProvider();
    
    static var Instance: DBProvider {
        return _instance;
    }
    var dbRef: DatabaseReference{
        return Database.database().reference();
    }
    var userRef:DatabaseReference {
        return dbRef.child(Constants.user)
    }

    
    
    func saveUser(withID: String, email: String, password: String)  {
        let data: Dictionary<String, Any> = [Constants.email: email, Constants.password: password]
        userRef.child(withID).child(Constants.data).setValue(data)
        // going to databsa to create child caled user with id then values
    }
    
    
    
    
    
    
}
