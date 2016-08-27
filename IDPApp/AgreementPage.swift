

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import CloudKit

class AgreementPage: UIViewController {
    
    @IBOutlet weak var agreement_button: UIButton!
    
    @IBAction func accept(sender: AnyObject) {
        self.performSegueWithIdentifier("DisplayMainPage", sender: nil)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    
  
    
    func displayMyAlertMessage(userMessage:String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated: true, completion: nil);
        
    }
    
}

