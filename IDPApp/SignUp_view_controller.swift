

import UIKit
import CloudKit
class SignUpViewController: UIViewController,UITextFieldDelegate {
    var ID = [CKRecord]()
    var empty = false
    var currentTextField:UITextField?
    
    @IBOutlet weak var firstname_text: UITextField!
    @IBOutlet weak var lastname_text: UITextField!
    @IBOutlet weak var username_text: UITextField!
    @IBOutlet weak var password_text: UITextField!
    //@IBOutlet weak var emailaddress_text: UITextField!
    //@IBOutlet weak var retypepassword: UITextField!
    @IBOutlet weak var backtologin_button: UIButton!
    
    
    override func viewDidAppear(animated: Bool) {
        self.textFieldShouldReturn(firstname_text)
        self.textFieldShouldReturn(lastname_text)
        self.textFieldShouldReturn(username_text)
        self.textFieldShouldReturn(password_text)
        //self.textFieldShouldReturn(emailaddress_text)
        //self.textFieldShouldReturn(retypepassword)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        /*NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)*/
        firstname_text.delegate = self
        lastname_text.delegate = self
        username_text.delegate = self
        password_text.delegate = self
        //emailaddress_text.delegate = self
        //retypepassword.delegate = self
        
        self.textFieldShouldReturn(firstname_text)
        self.textFieldShouldReturn(lastname_text)
        self.textFieldShouldReturn(username_text)
        self.textFieldShouldReturn(password_text)
        //self.textFieldShouldReturn(emailaddress_text)
        //self.textFieldShouldReturn(retypepassword)
        /*firstname_text.returnKeyType = UIReturnKeyType.Done
        lastname_text.returnKeyType = UIReturnKeyType.Done
        username_text.returnKeyType = UIReturnKeyType.Done
        password_text.returnKeyType = UIReturnKeyType.Done
        emailaddress_text.returnKeyType = UIReturnKeyType.Done
        retypepassword.returnKeyType = UIReturnKeyType.Done*/
    }
    
    let publicDB = CKContainer.defaultContainer().publicCloudDatabase
    
    let privateDB = CKContainer.defaultContainer().privateCloudDatabase
    
    
    @IBAction func signUp_pressed(sender: AnyObject) {
        let UserPassword = password_text.text
        let UserUsername = username_text.text
        let UserLastName = lastname_text.text
        let UserFirstName = firstname_text.text
        
        if UserPassword == "" || UserLastName == "" || UserUsername == "" || UserFirstName == "" {
            displayMyAlertMessage("All fields are required")
            
        }
        /*else if retypepassword.text != password_text.text{
            
            displayMyAlertMessage("Passwords do not match")
            
        }*/
        
        let users = CKRecord(recordType: "IDPUser")
        users["UserName"] = UserUsername
        users["FirstName"] = UserFirstName
        users["LastName"] = UserLastName
        users["Password"] = UserPassword
        //users["EmailAddress"] = emailaddress_text.text
        
        let publicDB = CKContainer.defaultContainer().publicCloudDatabase
        
        let usernamePredict = NSPredicate(format:"UserName = %@", UserUsername!)
        let query = CKQuery(recordType:"IDPUser" , predicate: usernamePredict)
        
        publicDB.performQuery(query, inZoneWithID: nil) {
            results, error in
            if error != nil {
                print(error)
                return
                
            } else {
                
                if (results!) != []{
                    dispatch_async(dispatch_get_main_queue()) {
                        self.displayMyAlertMessage("Duplicated Username, please change another one")
                    }
                    return
                }
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    publicDB.saveRecord(users, completionHandler: { (record:CKRecord?, error:NSError?) -> Void in
                        if error == nil {
                            self.ID.insert(users, atIndex: 0)
                            
                        }else{
                            print(error)
                            
                        }
                    })
                    self.performSegueWithIdentifier("showAggreement", sender: nil)
                })
                
                return
                
            }
        }
        
        
        return
    }
    @IBAction func backtologin_func(sender: AnyObject) {
        self.performSegueWithIdentifier("backtologin", sender: nil)
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