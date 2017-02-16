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
    
    func register(username: String, password: String) -> Void {
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        
        jsonObject.setValue(password, forKey: "password")
        jsonObject.setValue(username, forKey: "username")
        currentUserName = username
        currentPassword = password
        
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
            //let paramString = ""
            request.httpBody = jsonData as Data //paramString.data(using: String.Encoding.utf8)
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
    
    func login(userName: String, password: String) -> Void {
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        
        jsonObject.setValue(password, forKey: "password")
        jsonObject.setValue(userName, forKey: "username")
        currentUserName = userName
        currentPassword = password
        
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
            
            let urlString = URL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/users/login")
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
    func createPost(postText: String, coordinate: AnyObject) -> Void {
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        
        //jsonObject.setValue(currentPassword, forKey: "password")
        jsonObject.setValue(currentUserName, forKey: "username")
        jsonObject.setValue(postText, forKey: "post")
        jsonObject.setValue(coordinate, forKey: "coordinate")
       
        
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


    
    

