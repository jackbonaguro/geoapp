//
//  User.swift
//  Graffit
//
//  Created by Zachary Cheshire on 2/15/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation
class User {
  var currentUserName: String = ""
  var currentPassword: String = ""
  var userToken: String = ""
  
  //send server a username and password to be registered
    init(userName: String, password: String, token: String) {
        self.currentUserName = userName
        self.currentPassword = password
        self.userToken = token
    }
    
  
  //send server a username and password to be authrorized
}

