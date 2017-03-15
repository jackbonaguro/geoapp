//
//  Model.swift
//  Graffit
//
//  Created by Zachary Cheshire on 3/14/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import UIKit
import CoreLocation
let model = Model()
class Model: NSObject {
    private var postArray: [Place]
    private var currentUser: User
    
    override init() {
        self.postArray = []
        self.currentUser = User(userName: "", password: "", token: "")
        super.init()
    }
    //1
    class var sharedInstance: Model {
        //2
        struct Singleton {
            //3
            static let instance = Model()
        }
        //4
        return Singleton.instance
    }
    
    func addPost(place: Place) -> Void {
        postArray.append(place)
    }
    func getPost() -> [Place] {
        return postArray
    }
    func setPost(location: CLLocationCoordinate2D) -> Void {
        //postArray.removeAll()
        let placesLoader = PlacesLoader()
        placesLoader.loadPost(location: location)
        
    }
    func getCurrentUser() -> User {
        return currentUser
    }
    func setCurrentUser(user: User) -> Void {
        
        currentUser = user
        
    }
    func login(userName: String, password: String) -> Void {
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(password, forKey: "password")
        jsonObject.setValue(userName, forKey: "username")
        print("Logging in")
        
        let jsonData: NSData
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
            print("json string bitch = \(jsonString)")
            print("json data = \(jsonData)")
            let url = NSURL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/user/login")!
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
                        //self.userToken = token
                        //self.currentUserName = userName
                        //self.currentPassword = password
                        let user = User(userName: userName, password: password, token: token)
                        model.setCurrentUser(user: user)
                        
                    }
                    
                    print("Fuck")
                }
               // print("Fuck")
            }
            task.resume()
            
        } catch _ {
            print ("JSON Failure")
        }
    }
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
            let url = NSURL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/user/create")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            print("Before adding jsonData")
            request.httpBody = jsonData as Data
            print("After adding jsonData")
            
            let urlString = URL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/user/create")
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



}
