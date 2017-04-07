//
//  ImageViewController.swift
//  Beditor2
//
//  Created by Felipe Benitez on 7/18/16.
//  Copyright © 2016 Felipe Benitez. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import Social

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var Profileimageholder: UIImageView!
    let dbledeletetab = UITapGestureRecognizer()
    
    lazy var profileImageView : UIImageView =
    {
        let imageView = UIImageView()
        return imageView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbledeletetab.numberOfTapsRequired = 2;
        dbledeletetab.addTarget(self, action: "deleteProfImg")
        Profileimageholder.addGestureRecognizer(dbledeletetab)
        Profileimageholder.userInteractionEnabled = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deleteProfImg()
    {
        Profileimageholder.image = nil
    }

    @IBAction func shareTwitter(sender: AnyObject)
    {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            var twtShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twtShare.addImage(Profileimageholder.image)
            
            self.presentViewController(twtShare, animated: true, completion: nil)
            
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }

    }
    @IBAction func shareSheet(sender: AnyObject)
    {
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            var fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fbShare.addImage(Profileimageholder.image)
            
            self.presentViewController(fbShare, animated: true, completion: nil)
            
        } else {
            var alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }

    @IBAction func CancelButtonTapped(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func uploadImageTapped(sender: AnyObject)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false;
        presentViewController(picker, animated: true, completion: nil)
        
        
    }
    
        
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        {
            let imageName = NSUUID().UUIDString

            let storageRef = FIRStorage.storage().reference().child("UserImages").child("\(imageName).png")

            var selectedImageFromPicker: UIImage?
            
            if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
                selectedImageFromPicker = editedImage
            } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                
                selectedImageFromPicker = originalImage
            }
            
            if let selectedImage = selectedImageFromPicker
            {
                profileImageView.image = selectedImageFromPicker
                Profileimageholder.image = selectedImage
                
            }
            
            dismissViewControllerAnimated(true, completion: nil)
            
          
            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!){
                storageRef.putData(uploadData, metadata: nil, completion:
                    {(metadata, error) in
                        
                        if error != nil{
                            print(error)
                            return
                        }
                })

            
            
        }
        

    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("canceled picker")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
