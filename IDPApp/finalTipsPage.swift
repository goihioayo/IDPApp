

import UIKit

class finalTipsPage: UIViewController {
    
    @IBOutlet weak var done_button: UIButton!
    @IBAction func backToMain_func(sender: AnyObject) {
        self.performSegueWithIdentifier("finished", sender: self)
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

