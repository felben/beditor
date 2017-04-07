//
//  ViewController.swift
//  Beditor2
//
//  Created by Felipe Benitez on 6/26/16.
//  Copyright © 2016 Felipe Benitez. All rights reserved.
//

import UIKit
import Firebase
import imglyKit
import Social

class ViewController: UIViewController {
   
    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
                // Do any additional setup after loading the view, typically from a nib.
        if let user = FIRAuth.auth()?.currentUser
        {
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid;
            
            self.username.text = "Hi, " + email!
        }
        else
        {
            self.username.text = ""

            // No user is signed in.
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        if(!isUserLoggedIn)
        {
            self.performSegueWithIdentifier("loginView", sender: self);

        }
    }
    
    
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        try! FIRAuth.auth()!.signOut()
        self.performSegueWithIdentifier("loginView", sender: self)
    }


    @IBAction func callCameraView(sender: AnyObject)
    {
        
        let configuration = Configuration() { builder in
            builder.backgroundColor = UIColor.whiteColor()
            
            builder.configureCameraViewController { options in
                options.tapToFocusEnabled = true
            }
            builder.configurePhotoEditorViewController{ options in
                options.backgroundColor = UIColor.blackColor()
            }
        }
        
        if let window = UIApplication.sharedApplication().delegate?.window! {
            window.tintColor = UIColor.blackColor()
        }
        
        let cameraViewController = CameraViewController(configuration: configuration)
        
        presentViewController(cameraViewController, animated: true, completion: nil)
        
    }
    
    
}

