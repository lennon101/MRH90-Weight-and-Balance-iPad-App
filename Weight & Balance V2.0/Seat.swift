//
//  Seat.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 29/01/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import Foundation
import UIkit

//IMPORTANT!!! NO INSTANCE IS EVER CREATED OF THIS STRUCTURE. it is purely used as a process to drill down into the data that is contained within each seat. Any mutable data is stored in a single instance of AircraftData

struct Seat {
    let xMomentArm: Float?
    let yMomentArm: Float?
    
    var presentImage: UIImage?
    var absentImage: UIImage?
    
    init(index: Int){
        //create instance of SeatCoGs library so we can access it
        let seatMomentArms = SeatMomentArms().library
        
        //create instance of SeatImages library so we can access it
        let seatImages = SeatImages().SeatImagesArray!
        
        //now get reference to the seat we want by using the index that was passed to this structure
        let seatMomentArm = seatMomentArms[index]
        let seatImage = seatImages[index]
    
        xMomentArm = seatMomentArm["XCG"] as Float!
        yMomentArm = seatMomentArm["YCG"] as Float!
        
        presentImage = UIImage(named: seatImage["Present"] as String!)
        absentImage = UIImage(named: seatImage["Absent"] as String!)
    }
}

