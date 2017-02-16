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
        let user = User()
        user.login(userName: userNameTextField.text!, password: userNameTextField.text!)
    }
    @IBAction func registerBtn(_ sender: Any) {
            let user = User()
            user.register(username: userNameTextField.text!, password: passwordTextField.text!)
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

