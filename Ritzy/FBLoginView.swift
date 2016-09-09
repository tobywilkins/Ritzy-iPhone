//
//  FBLoginView.swift
//  Ritzy
//
//  Created by Wilkins, Toby (UK - London) on 08/09/2016.
//  Copyright © 2016 Apparently. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit



class FBLoginView: UIViewController {
    
    
    func segueToPhoto() {
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            [unowned self] in
            self.performSegueWithIdentifier("FBPhotoLoad", sender: self)
        }
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
            }
        })
    }

    @IBAction func FacebookContinuePressed(sender: AnyObject) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logInWithReadPermissions(["public_profile", "email", "user_friends", "user_photos", "user_work_history"], handler: { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    self.segueToPhoto()
                    
                    fbLoginManager.logOut()
                }
            }
        })
        
        
    }
    
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                }
            })
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"handleFBSessionStateChangeWithNotification:", name: "SessionStateChangeNotification", object: nil)


        
            }
    
    func handleFBSessionStateChangeWithNotification(notification: NSNotification) {
        if ((FBSDKAccessToken.currentAccessToken()) != nil) {
            segueToPhoto()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {

        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            segueToPhoto()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
