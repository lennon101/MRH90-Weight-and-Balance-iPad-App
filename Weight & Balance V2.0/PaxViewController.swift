//
//  PaxViewController.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 27/01/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import UIKit

protocol PaxTab_Delegate {
    func dataSentFromPaxView()
}

class PaxViewController: UIViewController, dataWasEnteredInPaxWeight_Delegate {
    
    //create a variable to hold the protocal
    var delegate: PaxTab_Delegate?
    
    //this variable waits for aircraftData to be passed to it from any of the other tab Bar View Controllers
    var aircraftData: AircraftData?
    
    
    
    //create variables to hold the seat button and seatnumber when clicked or long pressed
    var seatButton:UIButton?
    var seatNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //safely unwrap aircraft data from optional characteristic
        if aircraftData != nil{
            //call the function to assign images to all the seats for each of their states
            setAllSeatsInUI()
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
            
            if seatNumber != 23 && seatNumber != 24 && seatNumber != 25 {
                let longPress = UILongPressGestureRecognizer()
                longPress.minimumPressDuration = 1.0
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        setAllSeatsInUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func seatClicked(sender: AnyObject) {
        //get which button has been pressed using sender parameter
        seatButton = sender as? UIButton
        
        //get seat number
        seatNumber = seatButton!.tag
        
        //get state of seat clicked
        var state = aircraftData!.seatStates[seatNumber!]
        
        setAircraftData(forState: state)
        changeState(fromState: state)
        
        //call the protocal delegate func to force delegating class to update its aircraftData labels
        if delegate != nil {
            delegate!.dataSentFromPaxView()
        }else{
            println("delegate in PaxView was found to be nill")
        }
    }
    
    //this function maintains the data stored in the aircraftData instance
    func setAircraftData(forState state: SeatState, forWeight weight: Float = 110){
        
        switch state {
        case .Present:
            //set the pax weight to the relevant index. default is 110kg
            aircraftData!.setPaxWeight(ForSeatIndex: seatNumber!, to: weight)

        case .Assigned:
            //set the element at array index to 0
            aircraftData!.setPaxWeight(ForSeatIndex: seatNumber!, to: 0)

        default: showAlert("seat is disabled and cannot have a PAX assigned to it")
        }
    }
    
    func changeState(fromState state: SeatState) {
        //transition to new state
        let newState = switchSeatState(state)
        
        //update aircraftData and UI for newstate of seat
        aircraftData!.seatStates[seatNumber!] = newState
        updateUI(toState: newState, forSeat: seatButton!)
    }
    
    func updateUI(toState state: SeatState, forSeat seatButton: UIButton){
        //set the image of the button according to the state that its in
        //this function progresses the state of the seat to its new state and updates the seat UI
        //the reason why the setButton method is contained within the AircraftData Class is because it needs to be called from multiple classes (both the SeatViewController Class and the PaxViewController Class) and so it was placed somewhere where it could be used by both
        
        AircraftData.setSeatImage(toState: state, forSeat: seatButton)
    }
    
    func switchSeatState(state:SeatState) -> SeatState{
        //this method recieves a seat state and switches it too the new state accordingly
        
        switch state {
        case .Present: return .Assigned
        case .Assigned: return .Present
        default:
            //else leave seat in the Absent state
            return .Absent
        }
    }
    
    @IBAction func paxLongPressed(sender: AnyObject) {
        
        if sender.state == UIGestureRecognizerState.Began {
            //showAlert("Long-Press Gesture Detected")
            
            //get the button UIView that was long pressed 
            seatButton = sender.view as? UIButton
            
            //save the seat number to a property of this class
            seatNumber = seatButton!.tag as Int
            
            //only invoke the popOver view if the seat HAS BEEN assigned
            if aircraftData!.seatStates[seatNumber!] == SeatState.Assigned {
                //invoke the popover view
                showPopOverView(seatButton!)
            }
        }
        
    }
    
    
    func showPopOverView(sender: AnyObject) {
        
        //first instantiate the new view that will become the popOver view
        let paxWeightViewController = storyboard!.instantiateViewControllerWithIdentifier("PaxWeightViewController") as PaxWeightViewController
    
        //now create a popOverController with its content initialised to the view we created 
        let popOverController = UIPopoverController(contentViewController: paxWeightViewController)
        
        //now present the view
        popOverController.presentPopoverFromRect(sender.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        
        //pass the number of the zone area and aircraftData to the popOver view
        //zoneWeightViewController.zoneAreaNumber = zoneAreaNumber
        //zoneWeightViewController.aircraftData = aircraftData
        
        //lastly, the view that becomes the popOver delegates to the self view allowing for information to be returned
        paxWeightViewController.delegate = self
    }
    
    //this func is called from the delegatee class
    func weightWasEntered(paxWeight: Float) {
        //assign the new pax weight to the index of aircraftData
        
        if aircraftData != nil {
            //get state of seat clicked
            //var state = aircraftData!.seatsStates[seatNumber!]
            
            setAircraftData(forState: .Present, forWeight: paxWeight)
            //changeState(fromState: state)
            
            //call the protocal delegate func to force delegating class to update its aircraftData labels
            if delegate != nil {
                delegate!.dataSentFromPaxView()
            }else{
                println("delegate in PaxView was found to be nill")
            }
            
            println("seat was assigned the value: \(paxWeight) at the index \(seatNumber!)")
        }
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
