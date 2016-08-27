

import UIKit

class videoViewController: UIViewController {


    @IBOutlet weak var back_button: UIButton!
    @IBAction func back_func(sender: AnyObject) {
        self.performSegueWithIdentifier("backToMain", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

