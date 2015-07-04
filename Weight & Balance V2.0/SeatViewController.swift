//
//  seatViewController.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 22/01/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import UIKit

protocol SeatTab_Delegate {
    func dataSentFromSeatView(aircraftData: AircraftData)
}

class SeatViewController: UIViewController {
    
    @IBOutlet weak var numberOfSeatsLabel: UILabel!

    @IBOutlet weak var seatButtons: UIButton!
    
    //create a property to store the incoming data
    var testData: String?
    var aircraftData:AircraftData?
    
    @IBAction func seatClicked(sender: AnyObject) {
        
        //get which button has been pressed using sender parameter
        var seatSender:UIButton = sender as UIButton
        
        //get seat number
        var seatNumber = seatSender.tag
        
        //get state of seat clicked
        var state = aircraftData!.seatStates[seatNumber]
    
        //set the image of the button according to the new state it will become
        switch state {
        case .Present:
            //change the state of the button.
            state = SeatState.Absent
            AircraftData.setSeatImage(toState: state, forSeat: seatSender)
            
            //if the seat has been set to absent, remove the
            
        case .Absent:
            //change the state back to Normal
            state = .Present
            AircraftData.setSeatImage(toState: state, forSeat: seatSender)
        default: showAlert("Seat has a member assigned to it. \nPlease return to PAX mode and remove the PAX before removing the seat")
        }
        
        //assign the state back to the aircraftData instance
        aircraftData!.seatStates[seatNumber] = state
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //safely unwrap aircraft data from optional characteristic
        if aircraftData != nil{
            //check which cabin layoutout has been selected and use func to populate the view with the correct number of seats
            switch aircraftData!.cabinConfig{
            case 14:
                //FWD Seats
                enableSeatsInRange(start: 1, endInclusive: 6)
                //AFT Seats
                enableSeatsInRange(start: 9, endInclusive: 16)
            case 16:
                //All except center seats
                enableSeatsInRange(start: 1, endInclusive: 16)
            case 20:
                //FWD Seats
                enableSeatsInRange(start: 1, endInclusive: 6)
                //AFT Seats
                enableSeatsInRange(start: 9, endInclusive: aircraftData!.totalPossibleNumberOfSeats)
            default:
                println("empty Cabin")
            }
            //Crew Seats
            enableSeatsInRange(start: 23, endInclusive: aircraftData!.totalPossibleNumberOfSeats)

            //call the function to assign images to all the seats for each of its states
            setAllSeatsInUI()
        }
    }
    
    func enableSeatsInRange(#start:Int,endInclusive:Int){
        //iterate though the required number of seats
        for seatNumber in start...endInclusive{
            aircraftData!.seatStates[seatNumber] = SeatState.Present
        }
    }

    func setAllSeatsInUI(){
        for seatNumber in 1...aircraftData!.totalPossibleNumberOfSeats{
            //get a reference to each button in the range using the tag of each button
            var seat = self.view.viewWithTag(seatNumber) as UIButton
                
            //get state of button
            var state = aircraftData!.seatStates[seatNumber]
                
            //use static method call in aircraftData to set the image of each button
            AircraftData.setSeatImage(toState: state, forSeat: seat)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        setAllSeatsInUI()
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: nil, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
        
        //present the alert view
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }
}
