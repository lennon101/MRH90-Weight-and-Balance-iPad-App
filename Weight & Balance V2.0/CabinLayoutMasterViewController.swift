//
//  HomeViewController.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 7/01/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import UIKit

//extend the String Class to have a method call floatvalue that converts the string to a float. this allows you to keep the safety of String without having to use the older version of NSString. 
//NB: the NSString method "floatValue" will return 0.0 even if the string is not a number therefore NSNumberFormatter was used instead
extension String {
    var floatValue: Float? {
    let numberFormatter = NSNumberFormatter()
        if numberFormatter.numberFromString(self) != nil{
            return numberFormatter.numberFromString(self)! as? Float
        }else{
            return nil
        }
    }
}


class CabinLayoutMasterViewController: UIViewController,UITextFieldDelegate {
    
    //create outlets for the Empty Weight Equipped (EWE) data entered in the three textFields
    @IBOutlet weak var eweWeightTextField: UITextField!
    @IBOutlet weak var xCenterOfGravityEWE: UITextField!
    @IBOutlet weak var yCenterOfGravityEWE: UITextField!
    
    //outlets for cabinCongigurations
    @IBOutlet weak var cabinEmpty: UIButton!
    @IBOutlet weak var cabin14Seats: UIButton!
    @IBOutlet weak var cabin16Seats: UIButton!
    @IBOutlet weak var cabin20Seats: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //assign the view controller delegate to each text field. this is done to allow for the keyboard to be dismissed when done is pressed
        self.eweWeightTextField.delegate = self
        self.xCenterOfGravityEWE.delegate = self
        self.yCenterOfGravityEWE.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //create actions for making the cabinLayout images enabled if all the data has been entered, else grey them out
    @IBAction func editingChangedInLabels() {
        editingChanged()
    }
    
    //function used for each textfield to enable or disable the cabin layout buttons
    func editingChanged(){
        //check if the text is valid for each text field
        if isTextValid(eweWeightTextField.text) && isTextValid(xCenterOfGravityEWE.text) && isTextValid(yCenterOfGravityEWE.text) {
            //if statement all statements are true, enable all the cabin configuration buttons
                cabinEmpty.enabled = true
                cabin14Seats.enabled = true
                cabin16Seats.enabled = true
                cabin20Seats.enabled = true
            
        }else{
            //if any one of the statements is false, disable all the cabin configuation buttons
            cabinEmpty.enabled = false
            cabin14Seats.enabled = false
            cabin16Seats.enabled = false
            cabin20Seats.enabled = false
        }
    }
    
    //test if values entered into text fields are convertible to string
    func isTextValid (text:String) ->Bool {
        
        if text.floatValue != nil {
            return true
        }else {
            return false
        }
    }
    
    //create actions to dismiss the keyboard once done is pressed. NB must add protocal UITextFieldDelegate to Class definition
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        //remember the new constant needs to be type cast to the correct Class as segue.destionViewController returns "Any Object"
        let loadAssignmentViewController = segue.destinationViewController as LoadAssignmentViewController
        
        //get the text field values and convert to int. this can be safely converted without error as each text field has been checked for compatibility to be converted to Float during func editingChanged
        let eweBasic = (eweWeightTextField.text as NSString).floatValue
        let eweXCG = (xCenterOfGravityEWE.text as NSString).floatValue
        let eweYCG = (yCenterOfGravityEWE.text as NSString).floatValue
        
        //get which cabin layout has been selected using segue ID's
        var cabinConfig = 0
        
        switch segue.identifier! {
        case "cabin14" :
            //save cabin config seat number to a variable
            cabinConfig = 14
        case "cabin16" :
            //save cabin config seat number to a variable
            cabinConfig = 16
        default :
            //default value for cabinConfig is 20
            cabinConfig = 20
        }

        //save all data to a structure named airCraftData of type AircraftData
        //NB the xCoG and yCoG can be safely unwrapped with "!" as they have already been tested to contain valid data in the textIsValid func
        let aircraftData: AircraftData = AircraftData(cabinConfig: cabinConfig, eweBasic: eweBasic, eweXCG: eweXCG, eweYCG: eweYCG)
        
        // Pass the selected object to the new view controller.
        //pass the weight, x and y cg's to the load assignment view controller for further calculation
        loadAssignmentViewController.aircraftData = aircraftData
    }
    
    

}
