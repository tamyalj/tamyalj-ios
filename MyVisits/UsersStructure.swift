//
//  UsersStructure.swift
//  MyVisits
//
//  Created by Ahmed Al Neyadi on 7/9/19.
//  Copyright © 2019 FatimaAljassmi. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase


struct UsersStructure {
    
    let title : String!
    let name : String!
    let address : String!
    let datetime : String!
    let img: String!


    let ref: DatabaseReference?
    
    
    
    init(title: String, name: String, address: String, datetime: String, img: String) {
        self.title = title
        self.name = name
        self.address = address
        self.datetime = datetime
        self.img = img

        self.ref = nil
        // self.uid = uid
    }
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        title = snapshotValue["title"] as! String
        name = snapshotValue["name"] as! String
        address = snapshotValue["address"] as! String
        datetime = snapshotValue["datetime"] as! String
        img = snapshotValue["img"] as! String
        ref = snapshot.ref
        //uid = snapshotValue["uid"] as! String
    }
    
    func toAnyObject() -> Any
    {
        return [
            "title": title,
            "name": name,
            "address": address,
            "datetime": datetime,
            "img": img
            //"uid": uid
        ]
    }
}

/*init(name: String, addedByUser: String, completed: Bool, key: String = "") {
 self.key = key
 self.name = name
 self.addedByUser = addedByUser
 self.completed = completed
 self.ref = nil
 }
 
 init(snapshot: FIRDataSnapshot) {
 key = snapshot.key
 let snapshotValue = snapshot.value as! [String: AnyObject]
 name = snapshotValue["name"] as! String
 addedByUser = snapshotValue["addedByUser"] as! String
 completed = snapshotValue["completed"] as! Bool
 ref = snapshot.ref
 }*/
