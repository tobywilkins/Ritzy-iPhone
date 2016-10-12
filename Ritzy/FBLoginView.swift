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
        
        let delayTime = DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            [unowned self] in
            self.performSegue(withIdentifier: "FBPhotoLoad", sender: self)
        }
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.value(forKey: "name") as! NSString
                print("User Name is: \(userName)")
            }
        })
    }

    @IBAction func FacebookContinuePressed(_ sender: AnyObject) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends", "user_photos", "user_work_history"], handler: { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    self.segueToPhoto()
                    }
            }
        })
        
        
    }
    
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                }
            })
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        NotificationCenter.default.addObserver(self, selector:#selector(FBLoginView.handleFBSessionStateChangeWithNotification(_:)), name: NSNotification.Name(rawValue: "SessionStateChangeNotification"), object: nil)


        
            }
    
    func handleFBSessionStateChangeWithNotification(_ notification: Notification) {
        if ((FBSDKAccessToken.current()) != nil) {
            segueToPhoto()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {

        
        if (FBSDKAccessToken.current() != nil)
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
