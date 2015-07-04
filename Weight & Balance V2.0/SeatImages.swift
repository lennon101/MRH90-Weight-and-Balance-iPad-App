//
//  SeatImages.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 9/02/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import Foundation

struct SeatImages {
    //the seats for the present state
    let presentLHS = "singleSeatLHS"
    let presentRHS = "singleSeatRHS"
    
    //the seats for the absent state
    let assignedLHS = "singleSeatLHSAssigned"
    let assignedRHS = "singleSeatRHSAssigned"
    
    //pilot seats
    let pilot = "pilotSeat"
    let pilotAssigned = "pilotSeatAssigned"
    
    //3rd crew-member seat
    let crewMember = "3rdCrewMemberSeat"
    let crewMemberAssigned = "3rdCrewMemberSeatAssigned"
    
    var SeatImagesArray: [Dictionary<String,String>]?
    
    init () {
    SeatImagesArray = [
        ["":""], //left blank to conform to seat tags starting at index 1
        
        ["Present":presentLHS, "Absent" : assignedLHS],        //1
        ["Present":presentRHS, "Absent" : assignedRHS],     //2
        ["Present":presentLHS,"Absent" : assignedLHS],        //3
        ["Present":presentRHS,"Absent" : assignedRHS],     //4
        ["Present":presentLHS,"Absent" : assignedLHS],        //5
        ["Present":presentRHS,"Absent" : assignedRHS],     //6
        ["Present":presentLHS,"Absent" : assignedLHS],        //7
        ["Present":presentRHS,"Absent" : assignedRHS],     //8
        ["Present":presentLHS,"Absent" : assignedLHS],        //9
        ["Present":presentRHS,"Absent" : assignedRHS],     //10
        ["Present":presentLHS,"Absent" : assignedLHS],        //11
        ["Present":presentRHS,"Absent" : assignedRHS],     //12
        ["Present":presentLHS,"Absent" : assignedLHS],        //13
        ["Present":presentRHS,"Absent" : assignedRHS],     //14
        ["Present":presentLHS,"Absent" : assignedLHS],        //15
        ["Present":presentRHS,"Absent" : assignedRHS],     //16
        
        //Seats facing out
        ["Present":presentRHS,"Absent" : assignedRHS],        //17
        ["Present":presentLHS,"Absent" : assignedLHS],     //18
        ["Present":presentRHS,"Absent" : assignedRHS],        //19
        ["Present":presentLHS,"Absent" : assignedLHS],     //20
        ["Present":presentRHS,"Absent" : assignedRHS],        //21
        ["Present":presentLHS,"Absent" : assignedLHS],     //22
        
        ["Present":crewMember,"Absent" : crewMemberAssigned],        //23
        ["Present":pilot,"Absent" : pilotAssigned],     //24
        ["Present":pilot,"Absent" : pilotAssigned],        //25

    ]
    }
}