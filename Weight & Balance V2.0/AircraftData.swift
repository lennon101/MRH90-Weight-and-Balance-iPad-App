//
//  AircraftData.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 20/01/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import Foundation
import UIKit


//a structure that contains all MUTATABLE information. tracks data that is entered by the user


 class AircraftData {
    
    //force this class to be a Singleton. This means that it will only ever be created once. Once the first instance is created, any following instances will just be references to the first instance. 
    class var sharedInstance : AircraftData {
        struct Static {
            static let instance : AircraftData = AircraftData()
        }
        return Static.instance
    }
    
    //--------------------------Begin Property Declarations -----------------------------
    
    var cabinConfig: Int        //holds the cabin configuration selected in the cabinLayoutMasterViewController
    var eweBasic: Float          //holds the Empty Weight Equipped (Basic) value
    var eweXCG: Float           //holds the EWE (Basic) X Center of Gravity
    var eweYCG: Float           //holds the EWE (Basic) Y Center of Gravity
    
    //variable to hold the total possible number of seats. this is only used to set size of the seats array in the init() method
    var totalPossibleNumberOfSeats: Int
    //variable to track the total number of seats currently allocated to the aircraft. this variable will be initialised to the cabin config number but will change as seats are added/removed.
    var totalCurrentNumberOfSeats: Int
    
    let numberOfZoneAreas = 33
    
    var eweXMoment: Float {
        get {return eweBasic * eweXCG}
    }
    
    var eweYMoment: Float {
        get {return eweBasic * eweYCG}
    }
    
    //------------------------ PAX Data ------------------------//
    
    //array of float values to hold the weight of each pax
    var paxWeights: [Float] = []
    
    var totalWeightOfAllPax: Float {
        get {return paxWeights.reduce(0, combine: +)}
    }
    
    //store the X and Y moments of each PAX in an array. the array is then summed each time a total ammount is needed. Its done this way to avoid catastrophic truncation errors when dealing with adding and subtracting Float Values.
    //they are both private as they only only accessed and calculated in the setPaxWeights method
    private var paxXmoments: [Float] = []
    private var paxYmoments: [Float] = []
    
    //create variables to hold the total moment for X and Y from the PAX tab
    var totalPaxXMoment: Float {
        get {//sum the array elements
            return paxXmoments.reduce(0, combine: +)
        }
    }
    
    var totalPaxYMoment: Float {
        get {//sum the array elements
            return paxYmoments.reduce(0, combine: +)
        }
    }
    //------------------------ End PAX Data ------------------------//
    
    
    //------------------------ Zone Data ------------------------//

    //NB: a Zone spans the whole seat row. a Zone Area is the left/center/right of that zone 
    
    //each individual zone area has its own weight
    var zoneAreaWeights: [Float] = []
    
    //a sum of each row (1-3, 4-6, 7-9, 10-12 etc) will produce a zoneWeight
    //NB THIS IS NEEDED TO OUTPUT TO A TABLE FOR DKU INPUT ON AIRCRAFT
    var zoneWeights: [Float] {
        get {
            var sumRow: [Float] = []
            for row in 1...11 {
                //set the sum of each row back to zero
                var sum: Float = 0
                //now sum each row
                for index in (3 * (row-1) + 1)...(3 * row) {
                    sum += zoneAreaWeights[index]
                }
                sumRow.append(sum)
            }
            return sumRow
        }
    }
    
    //a sum of all zoneWeights produces a total Weight Of All Zones
    var totalWeightOfAllZones: Float {
        get {
            return zoneWeights.reduce(0, combine: +)
        }
    }
    
    //each zone area X-Moment can be calculated by mulitplying the zone area weight (if any have been assigned) with the zone area x-Moment Arm
    var zoneAreaXmoments: [Float] {
        get {
            var xMoments: [Float] = []
            for index in 1...numberOfZoneAreas {
                let zoneAreaMoment = zoneAreaWeights[index] * ZoneArea(index: index).xMomentArm!
                xMoments.append(zoneAreaMoment)
            }
            return xMoments
        }
    }
    
    //each zone area Y-Moment can be calculated by mulitplying the zone area weight (if any have been assigned) with the zone area Y-Moment Arm
    var zoneAreaYmoments: [Float] {
        get {
            var yMoments: [Float] = []
            for index in 1...numberOfZoneAreas {
                let zoneAreaMoment = zoneAreaWeights[index] * ZoneArea(index: index).yMomentArm!
                yMoments.append(zoneAreaMoment)
            }
            return yMoments
        }
    }
    
    //total X-Moment Of All Zones is found so that it can be used in a later calculation
    var totalXmomentOfAllZones: Float {
        get {
            return zoneAreaXmoments.reduce(0, combine: +)
        }
    }
    
    //total Y-Moment Of All Zones is found so that it can be used in a later calculation
    var totalYmomentOfAllZones: Float {
        get {
            return zoneAreaYmoments.reduce(0, combine: +)
        }
    }
    
    //------------------------ End Zone Data ------------------------//

    var hoistWeight: Float = 0
    var externalLoadWeight: Float = 0
    
    var zeroFuelWeight: Float {
        get {
            return eweBasic + totalWeightOfAllPax + totalWeightOfAllZones + hoistWeight + externalLoadWeight
        }
    }
    
    //------------------------ Begin Global CG Data ------------------------//
    var globalXCG: Float {
        get {// + others as they are built (kg*m)/kg = m
            return (eweXMoment + totalPaxXMoment + totalXmomentOfAllZones)/zeroFuelWeight
         }
    }
    
    var globalYCG: Float {
        get {// + others as they are built (kg*m)/kg = m
            return (eweYMoment + totalPaxYMoment + totalYmomentOfAllZones)/zeroFuelWeight
        }
    }
    //------------------------ End Global CG Data ------------------------//

    
    
    //store the state of each seat in an array
    var seatStates: [SeatState] = []
    
    //default initialiser
    init(){
         cabinConfig = 0
         eweBasic = 0
         eweXCG = 0
         eweYCG = 0
        
        //the total possible number of seats is controlled by the number of seat Moment arms stored in the SeatMomentArms Class. Therefore an instance is created, and the count is returned
        //the count of the array - 1 as there is a nil seat at index 0 to allow the seat index to match the seat numbering system of the aircraft
        let seatMomentArmsArray: [Dictionary<String,Float>] = SeatMomentArms().library
        totalPossibleNumberOfSeats = seatMomentArmsArray.count - 1
        totalCurrentNumberOfSeats = cabinConfig    }
    
    
    
    //------------------------ Begin Initiliser methods etc ------------------------//


    
    //initial value initialiser
    init(cabinConfig:Int,eweBasic:Float,eweXCG:Float,eweYCG:Float){
        self.cabinConfig = cabinConfig
        self.eweBasic = eweBasic
        self.eweXCG = eweXCG
        self.eweYCG = eweYCG
        
        //the total possible number of seats is controlled by the number of seat Moment arms stored in the SeatMomentArms Class. Therefore an instance is created, and the count is returned
        //the count of the array - 1 as there is a nil seat at index 0 to allow the seat index to match the seat numbering system of the aircraft
        let seatMomentArmsArray: [Dictionary<String,Float>] = SeatMomentArms().library
        totalPossibleNumberOfSeats = seatMomentArmsArray.count - 1
        totalCurrentNumberOfSeats = cabinConfig
        
        //initialise the arrays for seat data to the correct size length 
        //note: the enum SeatState default value is ".Disabled"
        for index in 0...totalPossibleNumberOfSeats {
            //creat an instance of a SeatState Enum (initialised to "Disabled" by default)
            var seat = SeatState()
            //append the new seat to the seats array to the size of the number of seats
            seatStates.append(seat)
            
            //initiales the pax Arrays to the size of the number of seats
            paxWeights.append(0)
            paxXmoments.append(0)
            paxYmoments.append(0)
        }
        
        
        //initialise the zone arrays to the corret size
        for index in 0...numberOfZoneAreas {
            zoneAreaWeights.append(0)
        }
    }
    
    func setPaxWeight(ForSeatIndex index: Int, to weight:Float) {
        //first save the weight of the pax to the pax weight array 
        paxWeights[index] = weight
        
        //update the paxXmoments array at this index
        paxXmoments[index] = Seat(index: index).xMomentArm! * weight
        paxYmoments[index] = Seat(index: index).yMomentArm! * weight

    }

    //recieves a state and a button and sets the button image according to the state its in
    //Static therefore it does not required an instance of AircraftData to be used
    class func setSeatImage(toState state: SeatState, forSeat seat: UIButton){
        //get the seat index
        let index = seat.tag
        
        switch state{
        case SeatState.Present:
            //return button to its normal opaque self
            seat.alpha = 1
            
            //get the UIImage for present state
            let presentImage = Seat(index: index).presentImage!

            //return button to normal image if its coming from an Assigned state
            seat.setImage(presentImage, forState: UIControlState.Normal)

        case SeatState.Assigned:
            //get the UIImage for absent state
            let absentImage = Seat(index: index).absentImage!
            
            //return button to normal image if its coming from an Assigned state
            seat.setImage(absentImage, forState: UIControlState.Normal)
            
            //also ensure that button's alpha is returned to 1 (incase it is coming from a disabled state)
            seat.alpha = 1
        default:
            //for Disabled state:
            //button.setImage(UIImage(named: "single seat"), forState: UIControlState.Normal)
            seat.alpha = 0.4
        }
    }
}
    
