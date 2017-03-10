//
//  ViewController.swift
//  Graffit
//
//  Created by Zachary Cheshire on 2/14/17.
//  Copyright © 2017 zcheshire. All rights reserved.
//

import UIKit

let user = User()

class ViewController: UIViewController {
    
    let userJson:NSMutableDictionary = NSMutableDictionary()
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!

    @IBAction func LoginBtn(_ sender: Any) {
       // var userLogged: Bool
       // userLogged =
            user.login(userName: userNameTextField.text!, password: passwordTextField.text!)
            performSegue(withIdentifier: "successSegue", sender: self)
       /* if userLogged {
            print("it worked")
        performSegue(withIdentifier: "successSegue", sender: self)
        } */

    }
    func goToView() -> Void {
        performSegue(withIdentifier: "successSegue", sender: self)
    }
    @IBAction func registerBtn(_ sender: Any) {
        
        user.register(username: userNameTextField.text!, password: passwordTextField.text!)
        //LoginBtn(Any)
  
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

