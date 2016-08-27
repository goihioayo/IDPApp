

import UIKit
import MobileCoreServices

class RecordVideoViewController: UIViewController {

    @IBOutlet weak var message_textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayMyAlertMessage("Please find a quiet and well lit place")
        self.displayMyAlertMessage("There will be six questions")
        // Do any additional setup after loading the view.
        var messageframe:CGRect
        
        messageframe  = message_textfield.frame
        messageframe.size.height = 100
        message_textfield.frame = messageframe
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  
  @IBAction func record(sender: AnyObject) {
    startCameraFromViewController(self, withDelegate: self)
  }

  func startCameraFromViewController(viewController: UIViewController, withDelegate delegate: protocol<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) -> Bool {
    if UIImagePickerController.isSourceTypeAvailable(.Camera) == false {
      return false
    }

    let cameraController = UIImagePickerController()
    cameraController.sourceType = .Camera
    cameraController.mediaTypes = [kUTTypeMovie as NSString as String]
    //set max duration time 3 minutes
    cameraController.videoMaximumDuration = 180
    cameraController.allowsEditing = false
    cameraController.delegate = delegate

    presentViewController(cameraController, animated: true, completion: nil)
    return true
  }

  func video(videoPath: NSString, didFinishSavingWithError error: NSError?, contextInfo info: AnyObject) {
    var title = "Success"
    var message = "Video was saved"
    if let _ = error {
      title = "Error"
      message = "Video failed to save"
    }
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
    presentViewController(alert, animated: true, completion: nil)
  }
    func displayMyAlertMessage(userMessage:String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated: true, completion: nil);
        
    }
  
}

// MARK: - UIImagePickerControllerDelegate

extension RecordVideoViewController: UIImagePickerControllerDelegate {
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    let mediaType = info[UIImagePickerControllerMediaType] as! NSString
    dismissViewControllerAnimated(true, completion: nil)
    // Handle a movie capture
    if mediaType == kUTTypeMovie {
      guard let path = (info[UIImagePickerControllerMediaURL] as! NSURL).path else { return }
      if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path) {
        UISaveVideoAtPathToSavedPhotosAlbum(path, self, #selector(RecordVideoViewController.video(_:didFinishSavingWithError:contextInfo:)), nil)
      }
    }
  }
}

// MARK: - UINavigationControllerDelegate

extension RecordVideoViewController: UINavigationControllerDelegate {
}
