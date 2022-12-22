//
//  User.swift
//  OCRTasks
//
//  Created by Dmitriy on 19.12.2022.
//

import Foundation
import Firebase

struct User {
    
    var uid: String
    var displayName: String?
    var email: String
    
    init(user: User) {
        self.uid = user.uid
        self.displayName = user.displayName
        self.email = user.email
    }
    
    init (uid: String, email: String, displayName: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
