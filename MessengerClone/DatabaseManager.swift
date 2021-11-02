//
//  DatabaseManager.swift
//  MessengerClone
//
//  Created by Rodrigo Leyva on 11/2/21.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    func createUser(user: ChatAppUser){
        
        
        database.child(user.safeEmail).setValue([
            "first_name" : user.firstName,
            "last_name" : user.lastName
        ])
        
    }
    
    
}

struct ChatAppUser{
    let firstName: String
    let lastName: String
    let email: String
    //let profileURL: String
    
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
