//
//  LoginViewController.swift
//  Places
//
//  Created by Zachary Cheshire on 2/25/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit
 var user = User()
class LoginViewController: UIViewController {
  @IBOutlet weak var usernameText: UITextField!
  @IBOutlet weak var passwordText: UITextField!
  
  
  @IBAction func login(_ sender: Any) {
    user.login(userName: usernameText.text!, password: passwordText.text!)
    
    
  }
 
  @IBAction func register(_ sender: Any) {
    user.register(username: usernameText.text!, password: passwordText.text!)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
