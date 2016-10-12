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
    
    @IBAction func ImageViewTapped(_ sender: AnyObject) {
        let picker : OLFacebookImagePickerController = OLFacebookImagePickerController()
        picker.delegate = self
        
        //    let picker = OLFacebookImagePickerController.init()
        present(picker, animated: true, completion: nil)
        
    }
    
    // Facebook Delegate Methods
    
    func facebookImagePickerDidCancelPickingImages(_ imagePicker: OLFacebookImagePickerController!) {
        dismiss(animated: true, completion: nil)
    }
    
    func facebookImagePicker(_ imagePicker: OLFacebookImagePickerController!, didFailWithError error: NSError!) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func facebookImagePicker(_ imagePicker: OLFacebookImagePickerController!, didFinishPickingImages images: [AnyObject]!) {
        dismiss(animated: true, completion: nil)
    }

}
    
