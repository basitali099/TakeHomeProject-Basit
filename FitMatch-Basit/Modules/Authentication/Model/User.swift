//
//  User.swift
//  FitMatch-Basit
//
//  Created by basit ch on 7/24/24.
//

import Foundation

// Struct representing a User
struct User {
    var username: String
    var pass: String
    var name: String
    
    // Initializer with default values for properties
    init(username: String = "", pass: String = "", name: String = "") {
        self.username = username
        self.pass = pass
        self.name = name
    }
}
