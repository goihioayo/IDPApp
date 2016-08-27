

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import AVKit
import AVFoundation
import MessageUI

class MainPage: UIViewController, FBSDKLoginButtonDelegate,MFMailComposeViewControllerDelegate {
    

    @IBOutlet weak var contact_button: UIButton!
    @IBOutlet weak var logout_button: UIButton!
    @IBOutlet weak var gototips_button: UIButton!
    @IBOutlet weak var tutorialvideo_button: UIButton!
    @IBOutlet weak var record_button: UIButton!
    
    @IBAction func logout_func(sender: AnyObject) {
        if (FBSDKAccessToken.currentAccessToken() != nil){
            FBSDKLoginManager().logOut()
            temp = ""
        }
        self.performSegueWithIdentifier("LogOut", sender: self)
    }
    @IBAction func gototips_func(sender: AnyObject) {
        self.performSegueWithIdentifier("showTips", sender: self)
    }
    
    @IBAction func tutorialVideo_func(sender: AnyObject) {
        playTutorialVideo()

    }
    @IBAction func record_func(sender: AnyObject) {
        self.performSegueWithIdentifier("startRecording", sender: self)
    }
    
    
    func playTutorialVideo(){
        let filePath = NSBundle.mainBundle().pathForResource("Zach_V4-SD", ofType: "mp4")
        let videoUrl = NSURL(fileURLWithPath: filePath!)
        let player = AVPlayer(URL: videoUrl)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController, animated: true){() -> Void in
            playerViewController.player!.play()
            
        }
    }
    
    var temp:NSString = ""
    
    override func viewDidAppear(animated: Bool) {
        print(temp)
        if (temp == "done"){
            self.performSegueWithIdentifier("read", sender: self)
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*if (temp == "done")
        {
            //print("Not logged in...")
            let loginButton = UIButton()
            loginButton.center = CGPoint(x: SignUp_button.center.x, y: SignUp_button.center.y + SignUp_button.frame.height * 2)
            loginButton.delegate = self
            self.view.addSubview(loginButton)
        }*/
        
    }
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["shirusun123@gmail.com"])
        mailComposerVC.setSubject("Message from IDPApp user")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error == nil
        {
            //print("Login complete.")
            self.performSegueWithIdentifier("LogOut", sender: self)
        }
        else
        {
            print(error.localizedDescription)
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        //print("User logged out...")
        self.performSegueWithIdentifier("LogOut", sender: self)

    }
    func displayMyAlertMessage(userMessage:String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated: true, completion: nil);
        
    }
    
}

