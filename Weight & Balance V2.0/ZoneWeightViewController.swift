//
//  ZoneWeightViewController.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 28/01/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import UIKit

//create a protocol to allow information to be passed "back" FROM the popOver TO the parent class
protocol dataWasEntered_Delegate{
    func zoneWeightWasEntered(zoneAreaWeight: Float)
}

class ZoneWeightViewController: UIViewController {
    
    @IBOutlet weak var zoneWeightTextField: UITextField!
    
    var delegate: dataWasEntered_Delegate?
    
    //dismiss the popover if the "Done" button is tapped
    @IBAction func doneClicked(sender: AnyObject) {
        
        if zoneWeightTextField.text.toInt() != nil {
            if delegate != nil{
                let zoneAreaWeight:Float = Float(zoneWeightTextField.text.toInt()!)
                //now send the zoneWeight back to the delegating class
                delegate!.zoneWeightWasEntered(zoneAreaWeight)
            } else {
                println("delegate in ZoneWeightViewController found to be nil")
            }
            dismissViewControllerAnimated(true, completion: nil)
        }else {
            showAlert("please enter interger values")
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //make the textfield first responder (automatically "selected") 
        zoneWeightTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //set the size of the pop-over window
        preferredContentSize = CGSize(width: 300, height: 200)
    }
    
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        //present the alert view
        self.presentViewController(alertController, animated: true, completion: nil)
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
