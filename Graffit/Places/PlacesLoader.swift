/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import CoreLocation

struct PlacesLoader {
    //model = model.sharedInstance
    //let model = Model()
    func loadPost(location: CLLocationCoordinate2D) -> Void {
       // let uri = "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/user/post"
        
       // let url = URL(string: uri)!
        let long = location.longitude
        let lat = location.latitude
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        jsonObject.setValue(long, forKey: "longitude") //hard set
        jsonObject.setValue(lat, forKey: "latitude") // hard set
        print("Logging in")
        
        let jsonData: NSData
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
           // let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
           // print("json string = \(jsonString)")
          //  print("json data = \(jsonData)")
            let url = NSURL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/posts")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            print("Load Post")
            request.httpBody = jsonData as Data
            //print("After adding jsonData")
            
            let session = URLSession.shared
            
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            request.httpBody = jsonData as Data
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                guard let _: Data = data, let _: URLResponse = response, error == nil else {
                    print("*****error")
                    return
                }
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let responseDict = json as? [String: Any] {
                    if let dic = responseDict["nearby_posts"] as? NSArray{
                        for post in dic {
                            let item1 = post as! NSDictionary
                            if let id = item1["_id"] as? String {
                                if let lat = item1["latitude"] as? Double {
                                    if let long = item1["longitude"] as? Double {
                                        if let text = item1["text"] as? String {
                                            if let creator = item1["creator"] as? String {
                                                let place = Place(id: id, creator: creator,longitude: long, latitude: lat,text: text)
                                                    model.addPost(place: place)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                    } else {
                        print("Error loafing that dic")
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
