//
//  SeatCoGs.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 29/01/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import Foundation


//IMPORTANT!!! AN INSTANCE OF THIS CLASS IS ONLY CREATED IN THE SEAT CLASS STRUCTURE AND THEN IMMEDIATELY DESTROYED. it is purely used as a process to drill down into the data that is contained within each seat. Any mutable data is stored in an instance of AircraftData

//This structure stores all seat Center Of Gravity (CoG) values. It was found during the building process that xCode could not handle the large expression as a single term and therefore the library was broken up into separate pices and assembled as one in the init()


struct SeatMomentArms {
    
    let library: [Dictionary<String,Float>] = [
        ["":0], //this index is left empty as a tag of 0 is the default tag for all views and so therefore cannot be used
        
        [ "XCG":5.132, "YCG":-0.834 ],
        [ "XCG":5.132, "YCG":0.834],
        [ "XCG":5.614, "YCG":-0.834],
        [ "XCG":5.614, "YCG":0.834]
    ]
    
    let library2: [Dictionary<String,Float>] = [

        [   //seat 5
            "XCG":6.097,
            "YCG":-0.834
        ],
        
        [   //seat 6
            "XCG":6.097,
            "YCG":0.834
        ],
        
        [   //seat 7 (R4 LHS seat for 16 seat cabin config)
            "XCG":6.580,
            "YCG":-0.934
        ],
        
        [   //seat 8 (R4 RHS seat for 16 seat cabin config)
            "XCG":6.580,
            "YCG":0.934
        ],
    
        [   //seat 9
            "XCG":8.274,
            "YCG":-0.834
        ],
    ]
    
    let library3: [Dictionary<String,Float>] = [
        
        [   //seat 10
            "XCG":8.274,
            "YCG":0.834
        ],
        
        [   //seat 11
            "XCG":8.757,
            "YCG":-0.834
        ],
        
        [   //seat 12
            "XCG":8.757,
            "YCG":0.834
        ],
        
        [   //seat 13
            "XCG":9.240,
            "YCG":-0.834
        ],
        
        [   //seat 14
            "XCG":9.240,
            "YCG":0.834
        ]
    ]
    
    let library4: [Dictionary<String,Float>] = [
        
        [   //seat 15
            "XCG":9.270,
            "YCG":-0.834
        ],
        
        [   //seat 16
            "XCG":9.723,
            "YCG":0.834
        ],
        
        [   //seat 17
            "XCG":6.566,
            "YCG":-0.208
        ],
        
        [   //seat 18
            "XCG":6.566,
            "YCG":0.208
        ],
        
        [   //seat 19
            "XCG":7.048,
            "YCG":-0.208
        ]
    ]
    
    let library5: [Dictionary<String,Float>] = [
        
        [   //seat 20
            "XCG":7.048,
            "YCG":0.208
        ],
        
        [   //seat 21 (R6 LHS)
            "XCG":7.531,
            "YCG":-0.208
        ],
        
        [   //seat 22 (R6 RHS)
            "XCG":7.531,
            "YCG":0.208
        ],
        
        [   //seat 23 (3rd Crew Member)
            "XCG":4.635,
            "YCG":0
        ],
        
        [   //seat 24 (Co-Pilot)
            "XCG":3.870,
            "YCG":-0.635
        ],
        
        [   //seat 25 (Pilot)
            "XCG":3.870,
            "YCG":0.635
        ]
    ]
    
    init(){
        //assemble all the library into a single library
        //this was done as the compiler could not handle the large amount of indexes 
        library += library2
        library += library3
        library += library4
        library += library5
    }
    
}