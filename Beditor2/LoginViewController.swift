//
//  LoginViewController.swift
//  Beditor2
//
//  Created by Felipe Benitez on 6/26/16.
//  Copyright © 2016 Felipe Benitez. All rights reserved.
//

import UIKit
import Foundation
import Firebase


class LoginViewController: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
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
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
        
        let email = userEmailTextField.text!;
        let password = userPasswordTextField.text!;
        
        if email != "" && password != ""
        {
            FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) in
                if error == nil
                {
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
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

func displayMyAlertMessage(userMessage:String)
{
    var myAlert = UIAlertController(title:"Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert)
    
    let okAction = UIAlertAction(title:"Ok", style: UIAlertActionStyle.Default, handler:nil)
    
    myAlert.addAction(okAction);
    
    self.presentViewController(myAlert, animated: true, completion: nil);
}



}
