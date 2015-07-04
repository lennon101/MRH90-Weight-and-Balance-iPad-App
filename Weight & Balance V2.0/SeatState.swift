//
//  SeatState.swift
//  Weight & Balance V2.0
//
//  Created by Dane Lennon on 27/01/2015.
//  Copyright (c) 2015 RAMSPO. All rights reserved.
//

import Foundation
import UIKit

enum SeatState{
    case Present
    case Assigned
    case Absent
    case Rotated
    
    init (){
        //initialis all SeatState Enums to Normal
        self = .Absent
    }
}