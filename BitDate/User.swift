//
//  User.swift
//  BitDate
//
//  Created by Jamie Montz on 4/9/15.
//  Copyright (c) 2015 David Montz. All rights reserved.
//

import Foundation

struct User {
    let id: String
    //let pictureURL: String
    let name: String
    private let pfUser: PFUser
    
    func getPhoto(callBack:(UIImage) -> ()) {
        let imageFile = pfUser.objectForKey("picture") as PFFile
        
        imageFile.getDataInBackgroundWithBlock { data, error in
            if let data = data {
                callBack(UIImage(data: data)!)
            }
        }
    }
}

private func pfUserToUser (user: PFUser) -> User {
    
    println(user)
    
    return User(id: user.objectId, name: user.objectForKey("firstName") as String, pfUser: user)
    
}

func currentUser() -> User? {

    if let user = PFUser.currentUser() {
        return pfUserToUser(user)
    }
    
    return nil
}

func fetchUnviewedUsers (callback: ([User]) -> ()) {

    
    PFUser.query()
    .whereKey("objectId", notEqualTo: PFUser.currentUser().objectId)
    .findObjectsInBackgroundWithBlock {
        objects, error in
        if let pfUsers = objects as? [PFUser] {
            let users = map(pfUsers, {pfUserToUser($0)})
            callback(users)
        }
    }
}