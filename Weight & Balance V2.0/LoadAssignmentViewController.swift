//
//  SeatAssignmentViewController.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 7/01/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import UIKit

class LoadAssignmentViewController: UIViewController, PaxTab_Delegate, ZoneTab_Delegate {

    //create outlet for label to display which cabinLayout has been selected
    @IBOutlet weak var cabinLayoutLabel: UILabel!
    @IBOutlet weak var cgOutputLabel: UILabel!
    
    
    //-----------------------------------------------------------------------
    //test labels for deletion before final draft is made
    
    //PAX Labels
    @IBOutlet weak var totalPaxWeightLabel: UILabel!
    @IBOutlet weak var totalPaxXmomentLabel: UILabel!
    @IBOutlet weak var totalPaxYmoment: UILabel!
    
    //Zone Labels 
    @IBOutlet weak var totalZoneWeightLabel: UILabel!
    @IBOutlet weak var totalZoneXmomentLabel: UILabel!
    @IBOutlet weak var totalZoneYmomentLabel: UILabel!
    
    
    //-----------------------------------------------------------------------
    
    
    //initialise an aircraftData member for to hold the incoming data from the masterviewcontroller
    //NB as we don't yet have the information from the segway, this property is created as an optional
    //this avoids have having to initialise it
    var aircraftData: AircraftData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //remove the gesture to go back (pop a view) when the user swipes on the very left side of the screen
        if self.navigationController != nil {
            self.navigationController?.interactivePopGestureRecognizer.enabled = false;
        }
        
        // Do any additional setup after loading the view.
        
        //unwrap the aircraftData file now that it has been loaded from the segue
        if aircraftData != nil {
            //aircraftData!
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //viewDidLoad is called only once when the viewController is loaded
    override func viewDidAppear(animated: Bool) {
        //safely unwrap aircraftData
        if aircraftData != nil {
            //display which cabin layout has been selected in the master view controller
            cabinLayoutLabel.text = "Cabin Config:\t\t\(aircraftData!.cabinConfig)"
            
            updateGlobalCGLabels()
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //get the destination view controller for the subview
        if segue.identifier == "displayLoadAssSubView"{
            
            // Get the new view controller using segue.destinationViewController.
            let tabBarController = segue.destinationViewController as UITabBarController
            
            //get the tab view controller for the first tab view
            //NB, within the tabBarController, there are subviews contained within an index from 0 (the first tab) to the last tab number
            var seatViewController = tabBarController.viewControllers![0] as SeatViewController
            
            //get the tab view controller for the second tab view
            var paxViewController = tabBarController.viewControllers![1] as PaxViewController
            
            //third tab view controller: Zones
            var zoneViewController = tabBarController.viewControllers![2] as ZoneViewController
            
            //test data for first tab view
            seatViewController.testData = "number of seats is: \(aircraftData!.cabinConfig)"
            
            //pass the aircraft data to each of the subviews
            //NB this is by REFERENCE not by type
            seatViewController.aircraftData = aircraftData
            paxViewController.aircraftData = aircraftData
            
            paxViewController.delegate = self
            zoneViewController.delegate = self
            
            zoneViewController.aircraftData = aircraftData
        }
    }
    
    func dataSentFromPaxView() {
        totalPaxWeightLabel.text = "Total Pax Weight: \(aircraftData!.totalWeightOfAllPax)"
        totalPaxXmomentLabel.text = "Total Pax X Moment: \(aircraftData!.totalPaxXMoment)"
        totalPaxYmoment.text = "Total Pax Y Moment: \(aircraftData!.totalPaxYMoment)"
        
        updateGlobalCGLabels()
    }
    
    func dataSentFromZoneView() {
        totalZoneWeightLabel.text = "Total Zone Weight: " + NSString(format: "%.02f", aircraftData!.totalWeightOfAllZones)
        totalZoneXmomentLabel.text = "Total Zone X Moment: \(aircraftData!.totalXmomentOfAllZones)"
        totalZoneYmomentLabel.text = "Total Zone Y Moment: \(aircraftData!.totalYmomentOfAllZones)"
        
        updateGlobalCGLabels()
    }
    
    
    func updateGlobalCGLabels(){
        let globalXCG: Float = aircraftData!.globalXCG
        let globalYCG: Float = aircraftData!.globalYCG
        
        let globalXCGString: NSString = NSString(format: "%.3f", globalXCG)
        let globalYCGString: NSString = NSString(format: "%.3f", globalYCG)
        
        //asssign values to the Center of gravity labels for interim viewing
        cgOutputLabel.text = "X CoG:\t\t" + globalXCGString + "m\nY CoG:\t\t" + globalYCGString + "m"
    }
}
