//
//  ZoneViewController.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 27/01/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import UIKit

protocol ZoneTab_Delegate {
    func dataSentFromZoneView()
}

class ZoneViewController: UIViewController, dataWasEntered_Delegate {
    
    //create a variable to hold the func call
    var delegate: ZoneTab_Delegate?
    
    //need a reference to all buttons so the text can be centered programatically in viewDidLoad method
    @IBOutlet weak var zoneAreaButton: UIButton!
    
    //create variable to hold which button is clicked
    var zoneAreaNumber: Int?
    
    //create variable to hold aircraftData
    var aircraftData: AircraftData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //get the size of the zone image assigned to each button
        var buttonImageSize: CGSize = zoneAreaButton.imageView!.image!.size
        
        for index in 1...aircraftData!.numberOfZoneAreas {
            //set the title for each button to appear centered
            //get reference to each button
            var zone = self.view.viewWithTag(index) as UIButton
            
            //center the text so that it sits on top of the image of each button
            zone.titleEdgeInsets = UIEdgeInsetsMake(0.0, -buttonImageSize.width, 0.0, 0.0)
            zone.alpha = 0.7
            
        }
        
        disableZonesIfSeatsAreEnabled()
    }
    
    func disableZonesIfSeatsAreEnabled(){
        //1 - 1
        //2 - 3
        
        //3 - 4
        //4 - 6
        
        //5 - 7
        // etc
        //therefore, if the seat index is odd, leave it to increment naturally.
        //if the seat index is even, add 1 so it skips the middle zone 
        
        var index = 1
        var zone = 1
        while zone <= aircraftData!.numberOfZoneAreas {
            //println(zone)
            //check if the index of the seat is enabled and disable the zone if so
            
            //increment the zone count according to the index count
            if index % 2 != 0 { //must be odd
                zone += 2
            }else{
                ++zone
            }
            ++index
        }
    }
    
    
    //NB MUST ENSURE THAT ALL SEAT BUTTONS ARE LINKED TO THIS IBACTION!!!!
    @IBAction func zoneAreaClicked(sender: AnyObject) {
        //save the button tag to buttonSender so we know which button is pressed
        let zoneAreaSender = sender as UIButton
        zoneAreaNumber = zoneAreaSender.tag
        
        //programatically call the popOver Segue. NB This DOES NOT call the prepareForSegue
        if zoneAreaNumber != nil && zoneAreaNumber != 0 {
            showPopOverView(sender, zoneAreaNumber: zoneAreaNumber!)
        }else {
            println("zoneAreaNumber was found to be nil or 0 (cannot be either)\nEnsure zoneArea in UI has correct tag assigned to it in the attributes")
        }
    }
    
    func showPopOverView(sender: AnyObject,zoneAreaNumber: Int) {
        
        //first instantiate the new view that will become the popOver view
        let zoneWeightViewController = storyboard!.instantiateViewControllerWithIdentifier("zoneWeightViewController") as ZoneWeightViewController
        
        //zoneWeightViewController.dismissViewControllerAnimated(true, completion: nil)
        
        //now create a popOverController with its content initialised to the view we created in step 1
        let popOverController = UIPopoverController(contentViewController: zoneWeightViewController)
        
        //now present the view
        popOverController.presentPopoverFromRect(sender.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        
        //lastly, the view that becomes the popOver delegates to the self view allowing for information to be returned
        zoneWeightViewController.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this func is enacted when it is called from the delegate of the zoneWeightViewController
    func zoneWeightWasEntered(zoneAreaWeight: Float) {
        if zoneAreaNumber != nil {
            var button = self.view.viewWithTag(zoneAreaNumber!) as UIButton
            button.setTitle("\(Int(zoneAreaWeight))", forState: UIControlState.Normal)
            
            //save the data to airCraftData instance
            if aircraftData != nil {
                aircraftData!.zoneAreaWeights[zoneAreaNumber!] = zoneAreaWeight
            }else {
                println("aircraftData found to be nil")
            }
        }else {
            println("zoneAreaNumber was found to be nil")
        }
        
        //call a function in loadAssignment view controller by calling the protocol func
        if delegate != nil {
            delegate!.dataSentFromZoneView()
        }else {
            println("delegate in ZoneTab was found to be nil")
        }
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //check for popOver Segue
        
        //NB EVERY SINGLE SEGUE FOR THE ZONE AREAS MUST HAVE THE IDENTIFIER "showPopOver"
        //        if segue.identifier == "showPopOver" {
        //            //safely unwrap the zoneWeightViewController
        //            let zoneWeightViewController = segue.destinationViewController as ZoneWeightViewController
        //                //set the delegate to be the new popOver Controller
        //                zoneWeightViewController.delegate = self
        //        }
        
        // Get the new view controller using segue.destinationViewController.
        
        
        // Pass the selected object to the new view controller.
    }
    
    
}
