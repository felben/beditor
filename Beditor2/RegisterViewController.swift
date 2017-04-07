//
//  RegisterViewController.swift
//  Beditor2
//
//  Created by Felipe Benitez on 7/10/16.
//  Copyright © 2016 Felipe Benitez. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var userEmailTextFiled: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction func returnButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func registerButtonTapped(sender: AnyObject) {
        
        let email = userEmailTextFiled.text!;
        let password = userPasswordTextField.text!;
        
        if email != "" && password != ""
        {
            FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) in
                if error == nil
                {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
                else
                {
                    print(error)
                }
                
                
            }
        }
        else
        {
            print("error")
        }
    }
    
    }
