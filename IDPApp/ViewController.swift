//
//  ViewController.swift
//  IDPApp
//
//  Created by shiru sun on 7/12/16.
//  Copyright © 2016 Shiru Sun. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import CloudKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {

    @IBOutlet weak var username_text: UITextField!
   
    @IBOutlet weak var SignUp_button: UIButton!
    @IBOutlet weak var Login_button: UIButton!
    @IBOutlet weak var password_text: UITextField!
    override func viewDidAppear(animated: Bool) {
        if (FBSDKAccessToken.currentAccessToken() != nil){
            print("Logged in...123123123")
            self.performSegueWithIdentifier("toMainPage", sender: self)
        }
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (FBSDKAccessToken.currentAccessToken() == nil){
            print("this is working")
            let DestViewController:MainPage = segue.destinationViewController as! MainPage;
            DestViewController.temp = "done"
        }
    }*/
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        username_text.delegate = self
        self.textFieldShouldReturn(username_text)
        password_text.delegate = self
        self.textFieldShouldReturn(password_text)
        
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Not logged in...")
            let loginButton = FBSDKLoginButton()
            loginButton.readPermissions = ["public_profile", "email", "user_friends"]
            loginButton.center = CGPoint(x: SignUp_button.center.x - 10, y: SignUp_button.center.y + SignUp_button.frame.height * 2)
            loginButton.delegate = self
            self.view.addSubview(loginButton)
        }
       
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    // MARK: - Facebook Login
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error == nil
        {
            print("Login complete.")
            self.performSegueWithIdentifier("logIn_succeed", sender: self)
        }
        else
        {
            print(error.localizedDescription)
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("User logged out...")
    }
    @IBAction func login_pressed(sender: AnyObject) {
        
        let UserPassword = password_text.text
        let UserUsername = username_text.text
        
        if UserPassword == "" || UserUsername == "" {
            displayMyAlertMessage("All fields are required")
            
        }
        
        
        let users = CKRecord(recordType: "IDPUser")
        users["UserName"] = UserUsername
        users["Password"] = UserPassword
        
        let publicDB = CKContainer.defaultContainer().publicCloudDatabase
        
        let usernamePredict = NSPredicate(format:"UserName = %@ AND Password = %@", argumentArray:[UserUsername!,UserPassword!])
        let query = CKQuery(recordType:"IDPUser" , predicate: usernamePredict)
        
        let usernamePD = NSPredicate(format:"UserName = %@", argumentArray: [UserUsername!])
        let q = CKQuery(recordType: "IDPUser", predicate: usernamePD)
        
        publicDB.performQuery(query, inZoneWithID: nil) {
            results, error in
            if error != nil {
                
                print(error)
                return
                
            } else {
                
                if (results!) != []{
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("toMainPage", sender: nil)
                        
                    }
                    return
                }
                publicDB.performQuery(q, inZoneWithID: nil){
                    result, er in
                    if er != nil{
                        print(er)
                        return
                    }else{
                        if(result!) == []{
                            dispatch_async(dispatch_get_main_queue(), {
                                self.displayMyAlertMessage("New User? Please sign up first")
                            })
                            return
                        }else{
                            dispatch_async(dispatch_get_main_queue(), {
                                self.displayMyAlertMessage("Please check your password")
                            })
                            return
                        }
                    }
                }
            }
        }
        
        return
    }
    @IBAction func signup_pressed(sender: AnyObject) {
        self.performSegueWithIdentifier("SignUp", sender: nil)
    }
    
    func displayMyAlertMessage(userMessage:String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated: true, completion: nil);
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }

}

