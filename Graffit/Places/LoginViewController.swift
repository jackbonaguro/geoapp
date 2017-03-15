//
//  LoginViewController.swift
//  Places
//
//  Created by Zachary Cheshire on 2/25/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit
var user = User(userName: "", password: "", token: "")
class LoginViewController: UIViewController {
  @IBOutlet weak var usernameText: UITextField!
  @IBOutlet weak var passwordText: UITextField!
  
  
  @IBAction func login(_ sender: Any) {
    model.login(userName: usernameText.text!, password: passwordText.text!)
    
    
  }
 
  @IBAction func register(_ sender: Any) {
    model.register(username: usernameText.text!, password: passwordText.text!)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
    // Do any additional setup after loading the view, typically from a nib.
  }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
