//
//  FBPhotoViewController.swift
//  Ritzy
//
//  Created by Wilkins, Toby (UK - London) on 09/09/2016.
//  Copyright © 2016 Apparently. All rights reserved.
//

import UIKit
import FacebookImagePicker


class FBPhotoViewController: UIViewController, OLFacebookImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBAction func ImageViewTapped(sender: AnyObject) {
        let picker : OLFacebookImagePickerController = OLFacebookImagePickerController()
        picker.delegate = self
        
        //    let picker = OLFacebookImagePickerController.init()
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    // Facebook Delegate Methods
    
    func facebookImagePickerDidCancelPickingImages(imagePicker: OLFacebookImagePickerController!) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func facebookImagePicker(imagePicker: OLFacebookImagePickerController!, didFailWithError error: NSError!) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func facebookImagePicker(imagePicker: OLFacebookImagePickerController!, didFinishPickingImages images: [AnyObject]!) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
    
