//
//  PaxWeightViewController.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 10/02/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import UIKit

//create a protocol to allow information to be passed "back" FROM the popOver TO the parent class
protocol dataWasEnteredInPaxWeight_Delegate{
    func weightWasEntered(paxWeight: Float)
}

class PaxWeightViewController: UIViewController {

    @IBOutlet weak var paxWeightTextField: UITextField!
    
    var delegate: dataWasEnteredInPaxWeight_Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        preferredContentSize = CGSize(width: 300, height: 270)
    }
    
    @IBAction func doneClicked(sender: AnyObject) {
        
    }
    
    @IBAction func troopClicked(sender: AnyObject) {
        //get reference to which button was clicked 
        let troopButton = sender as UIButton
        
        //get troop weight using tag assigned to the button 
        let weight = Float(troopButton.tag)
        
        //pass the weight back to the delegate
        if delegate != nil {
            delegate!.weightWasEntered(weight)
            dismissViewControllerAnimated(true, completion: nil)
        }else{
            println("delegate in paxWeightViewController found to be nil")
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
