//
//  PlaceCreate.swift
//  Graffit
//
//  Created by Zachary Cheshire on 3/14/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import Foundation
import MapKit
class PlaceCreate {
    func createPost(user: String, textt: String, location: CLLocationCoordinate2D) -> Void {
        let long = location.longitude
        let lat = location.latitude
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(long, forKey: "longitude") //hard set
        jsonObject.setValue(lat, forKey: "latitude")
        jsonObject.setValue(0, forKey: "altitude")
        jsonObject.setValue(textt, forKey: "text")// hard set
        print("Creatin Post")
        
        let jsonData: NSData
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
            print("json string = \(jsonString)")
            print("json data = \(jsonData)")
            let url = NSURL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/authorized/newpost")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            print("Before adding jsonData")
            request.httpBody = jsonData as Data
            print("After adding jsonData")
            
            let session = URLSession.shared
            request.addValue(model.getCurrentUser().userToken, forHTTPHeaderField: "Authorization")
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            request.httpBody = jsonData as Data
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let _: Data = data, let _: URLResponse = response, error == nil else {
                    print("*****error")
                    return
                }
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let responseDict = json as? [String: Any] {
                    if let text = responseDict["text"] as? String {
                        print(text)
                        print("What")
                       /* let place = Place(id: model.getCurrentUser().userToken, creator: model.getCurrentUser().currentUserName,longitude: long,latitude: lat,text: textt)
                        model.addPost(place: place)*/
                        
                    } else {
                        
                        print("Shit is no beuno")
                    }
                    
                    
                } else {
                    
                    print("Error Initializing JSON Data")
                    
                }
                // print(self.userToken)
            }
            task.resume()
            
        } catch _ {
            print ("JSON Failure")
        }
    }

}
