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
   // var regions: [CLLocation] = nil
    //var availablePosts: [String] = ""
    //var postInRegion: [String] = ""
    
   /* func loadPost(region: CLLocation) -> [String] {
    
         make call to server to get post within region
 
 
 
    }
 */
    
 /*   func checkRegion(region: CLLocation) -> CLLocation {
        for regionn in regions {
            
            let distanceInMeters = regionn.distance(from: region)
            if distanceInMeters < 0.0000001 {
            
               return regionn
                
        }
     
    }
    */
    
    
   /* func checkAvailablePosts(<#parameters#>) -> <#return type#> {
        <#function body#>
    }
    */
    
    //send server a username and password to be registered
    func register(username: String, password: String) -> Void {
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(password, forKey: "password")
        jsonObject.setValue(username, forKey: "username")
       // currentUserName = username
       // currentPassword = password
        
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

                
               // presentViewController(ViewControllerMain, animated: true, completion: nil)
            }
            task.resume()
            
        } catch _ {
            print ("JSON Failure")
           // return false
        }
        //return true
    }
    
    
     //send server a username and password to be authrorized
    func login(userName: String, password: String) -> Void {
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        var itWorked: Bool = false
        jsonObject.setValue(password, forKey: "password")
        jsonObject.setValue(userName, forKey: "username")
        currentUserName = userName
        currentPassword = password
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
            
         //   let urlString = URL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/users/login")
            
            let session = URLSession.shared
            //let request2 = NSMutableURLRequest(url: urlString!)
           // request.httpMethod = "POST"
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
           // request.addValue("token", forHTTPHeaderField: "Authorization")
            //let paramString = ""
            request.httpBody = jsonData as Data //paramString.data(using: String.Encoding.utf8)
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let _: Data = data, let _: URLResponse = response, error == nil else {
                    print("*****error")
                    return
                }
               // let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let dictionary = json as? [String: Any] {
                    if let token = dictionary["authorization"] as? String {
                        print( (token))
                        self.userToken = token
                        //ViewController.goToView(self)
                        
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
    
  /*  func getTest() -> Void {
        
        
        
        let jsonData: NSData
        
        do {
            let url = NSURL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/posts/test")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            print("Before adding jsonData")
            print("After adding jsonData")
            request.addValue(user.userToken, forHTTPHeaderField: "Authorization")
            print(user.userToken)
            let urlString = URL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/posts/test")
            
            let session = URLSession.shared
            //let request2 = NSMutableURLRequest(url: urlString!)
            // request.httpMethod = "POST"
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            // request.addValue("token", forHTTPHeaderField: "Authorization")
            //let paramString = ""
            //request.httpBody = jsonData as Data //paramString.data(using: String.Encoding.utf8)
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let _: Data = data, let _: URLResponse = response, error == nil else {
                    print("*****error")
                    return
                }
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print((dataString))
                print("The data ^^")
            }
            task.resume()
            
            
        } catch _ {
            print ("Cant grab data")
        }

    } */
    
}


    
    

