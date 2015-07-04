//
//  ZoneArea.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 4/02/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import Foundation

//IMPORTANT!!! NO INSTANCE IS EVER CREATED OF THIS STRUCTURE. it is purely used as a process to drill down into the data that is contained within each Zone. Any mutable data is stored in a single instance of AircraftData

struct ZoneArea {
    let xMomentArm: Float?
    let yMomentArm: Float?
    
    init(index: Int){
        //get the reference to the ZoneMomentsArms Array
        let zoneMomentArms = ZoneMomentArms().library
        
        //use the index to get reference to the zone. this also finds if its the left/center/right area
        let zoneAreaDict = zoneMomentArms[index]
        
        xMomentArm = zoneAreaDict["XCG"] as Float!
        yMomentArm = zoneAreaDict["YCG"] as Float!
        
    }
}