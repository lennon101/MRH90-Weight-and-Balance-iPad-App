//
//  ZoneMomentArms.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 4/02/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import Foundation

    //NB: a Zone spans the whole seat row. a Zone Area is the left/center/right of that zone 

struct ZoneMomentArms {
    let library: [Dictionary<String,Float>] = [
        ["":0], //this index is left empty as a tag of 0 is the default tag for all views and so therefore cannot be used
        
        //Zone A (Row 1)
        //Left (1)                    Center (2)            Right (3)
        ["XCG":5.130,"YCG":-0.834], ["XCG":5.130,"YCG":0], ["XCG":5.130,"YCG":0.834],
        
        //Zone B (Row 2)
        //Left (4)                    Center (5)            Right (6)
        ["XCG":5.610,"YCG":-0.834], ["XCG":5.610,"YCG":0], ["XCG":5.610,"YCG":0.834],
        
        //Zone C (Row 3)
        //Left (7)                    Center (8)            Right (9)
        ["XCG":6.100,"YCG":-0.834], ["XCG":6.100,"YCG":0], ["XCG":6.100,"YCG":0.834],
        
        //Zone D (Row 4)
        //Left (10)                    Center (11)          Right (12)
        ["XCG":6.570,"YCG":-0.834], ["XCG":6.570,"YCG":0], ["XCG":6.570,"YCG":0.834],
        
        //Zone E (Row 5)
        //Left (13)                    Center (14)          Right (15)
        ["XCG":7.050,"YCG":-0.834], ["XCG":7.050,"YCG":0], ["XCG":7.050,"YCG":0.834],
        
        //Zone F (Row 6)
        //Left (16)                    Center (17)          Right (18)
        ["XCG":7.530,"YCG":-0.834], ["XCG":7.530,"YCG":0], ["XCG":7.530,"YCG":0.834],
        
        //Zone G (Row 7)
        //Left (19)                    Center (20)          Right (21)
        ["XCG":8.280,"YCG":-0.834], ["XCG":8.280,"YCG":0], ["XCG":8.280,"YCG":0.834],
        
        //Zone H (Row 8)
        //Left (22)                    Center (23)          Right (24)
        ["XCG":8.760,"YCG":-0.834], ["XCG":8.760,"YCG":0], ["XCG":8.760,"YCG":0.834],
        
        //Zone I (Row 9)
        //Left (25)                    Center (26)          Right (27)
        ["XCG":9.240,"YCG":-0.834], ["XCG":9.240,"YCG":0], ["XCG":9.240,"YCG":0.834],
        
        //Zone J (Row 10)
        //Left (28)                    Center (29)          Right (30)
        ["XCG":9.720,"YCG":-0.834], ["XCG":9.720,"YCG":0], ["XCG":9.720,"YCG":0.834],
        
        //Zone K (ramp)
        //Left (31)                    Center (32)          Right (33)
        ["XCG":10.90,"YCG":-0.834], ["XCG":10.90,"YCG":0], ["XCG":10.90,"YCG":0.834],
    ]
}