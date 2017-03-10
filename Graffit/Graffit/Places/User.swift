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
  func register(username: String, password: String) -> Void {
    let jsonObject: NSMutableDictionary = NSMutableDictionary()
    jsonObject.setValue(password, forKey: "password")
    jsonObject.setValue(username, forKey: "username")

    
    let jsonData: NSData
    
    do {
      jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
      let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
      print("json string = \(jsonString)")
      print("json data = \(jsonData)")
      let url = NSURL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/users/create")!
      let request = NSMutableURLRequest(url: url as URL)
      request.httpMethod = "POST"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      print("Before adding jsonData")
      request.httpBody = jsonData as Data
      print("After adding jsonData")
      
      let urlString = URL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/users/create")
      let session = URLSession.shared
      let request2 = NSMutableURLRequest(url: urlString!)
      request2.httpMethod = "POST"
      request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
      request.httpBody = jsonData as Data
      let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
        guard let _: Data = data, let _: URLResponse = response, error == nil else {
          print("*****error")
          return
        }
        let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("*****This is the data 4: \(dataString)")
      }
      task.resume()
      
    } catch _ {
      print ("JSON Failure")
    }

  }
  
  
  //send server a username and password to be authrorized
  func login(userName: String, password: String) -> Void {
    let jsonObject: NSMutableDictionary = NSMutableDictionary()
    jsonObject.setValue(password, forKey: "password")
    jsonObject.setValue(userName, forKey: "username")
    print("Logging in")
    
    let jsonData: NSData
    
    do {
      jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
      let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
      print("json string = \(jsonString)")
      print("json data = \(jsonData)")
      let url = NSURL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/users/login")!
      let request = NSMutableURLRequest(url: url as URL)
      request.httpMethod = "POST"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      print("Before adding jsonData")
      request.httpBody = jsonData as Data
      print("After adding jsonData")
      
      let session = URLSession.shared

      request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
      request.httpBody = jsonData as Data
      let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
        guard let _: Data = data, let _: URLResponse = response, error == nil else {
          print("*****error")
          return
        }
        let json = try? JSONSerialization.jsonObject(with: data!, options: [])
        if let dictionary = json as? [String: Any] {
          if let token = dictionary["authorization"] as? String {
            print( "\(token) Hey")
            self.userToken = token
            self.currentUserName = userName
            self.currentPassword = password
            
          }
          
          
        }
        print(self.userToken)
      }
      task.resume()
      
    } catch _ {
      print ("JSON Failure")
    }
  }
  
  func createPost(postText: String, longitude: Double, latitude: Double, token: String) -> Void {
    let jsonObject: NSMutableDictionary = NSMutableDictionary()
    
    //jsonObject.setValue(currentPassword, forKey: "password")
    jsonObject.setValue(currentUserName, forKey: "username")
    jsonObject.setValue(postText, forKey: "post")
    jsonObject.setValue(longitude, forKey: "longitude")
    jsonObject.setValue(latitude, forKey: "latitude")
    jsonObject.setValue(token, forKey: "token")
    
    
    let jsonData: NSData
    
    do {
      jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
      let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
      print("json string = \(jsonString)")
      print("json data = \(jsonData)")
      let url = NSURL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/users/post")!
      let request = NSMutableURLRequest(url: url as URL)
      request.httpMethod = "POST"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      print("Before adding jsonData")
      request.httpBody = jsonData as Data
      print("After adding jsonData")
      
      let urlString = URL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/users/post")
      let session = URLSession.shared
      let request2 = NSMutableURLRequest(url: urlString!)
      request2.httpMethod = "POST"
      request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
      let paramString = ""
      request.httpBody = paramString.data(using: String.Encoding.utf8)
      let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
        guard let _: Data = data, let _: URLResponse = response, error == nil else {
          print("*****error")
          return
        }
        let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("*****This is the data 4: \(dataString)")
      }
      task.resume()
      
      
    } catch _ {
      print ("JSON Failure")
    }
    
  }
  
}

