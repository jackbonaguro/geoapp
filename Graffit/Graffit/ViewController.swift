//
//  ViewController.swift
//  Graffit
//
//  Created by Zachary Cheshire on 2/14/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let userJson:NSMutableDictionary = NSMutableDictionary()

    @IBAction func LoginBtn(_ sender: Any) {
       
    }
    @IBAction func registerBtn(_ sender: Any) {
        let jsonObject: NSMutableDictionary = NSMutableDictionary()
        
        jsonObject.setValue(passwordTextField.text, forKey: "password")
        jsonObject.setValue(userNameTextField.text, forKey: "username")

        
        let jsonData: NSData
        
        do {
            jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
            let jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue) as! String
            print("json string = \(jsonString)")
            print("json data = \(jsonData)")
            let url = NSURL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/createuser")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            print("Before adding jsonData")
            request.httpBody = jsonData as Data
            print("After adding jsonData")
            
            let urlString = URL(string: "http://ec2-54-242-147-65.compute-1.amazonaws.com:3333/createuser")
            let session4 = URLSession.shared
            let request2 = NSMutableURLRequest(url: urlString!)
            request2.httpMethod = "POST"
            request2.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            let paramString = ""
            request2.httpBody = paramString.data(using: String.Encoding.utf8)
            let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
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
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

