// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//testing for if a string is convertible to an Int
//test if values entered into text fields are convertible to string
func textIsValid (text:String) ->Bool {
    let test:Int? = text.toInt()
    var result: Bool
    
    if test != nil {
        result = true
    }else {
        result = false
    }
    
    return result
}

textIsValid("")



//making an array 
var testArray: [Int] = []

for index in 0...23 {
    testArray.append(0)
}

testArray.count
testArray[23]


//enums 
enum seatXCG: Float {
    case seat1 = 23.4
    case seat2 = 45.8
}

//dictionary
//an array of dictionary's
let library1 = [ ["XCG":4.635, "YCG":0], ["XCG":4.635, "YCG":0] ]

let seat = library1[1]
let seatDouble = seat["XCG"] as Double!

seatDouble

var x:Double = -91.74

x += 91.74


//singletons 
class NestedSingleton {
    var testProperty: Int = 12
    
    class var sharedInstance : NestedSingleton {
        
        struct Static {
            static let instance : NestedSingleton = NestedSingleton()
        }
        return Static.instance
    }
}

let nestedSingleton = NestedSingleton.sharedInstance

nestedSingleton.testProperty

let nestedSingledtonV2 = NestedSingleton.sharedInstance

nestedSingledtonV2.testProperty = 13
nestedSingleton.testProperty
nestedSingledtonV2.testProperty

//NSStrings and optionals 
let string: NSString = "hey"
string.floatValue
let numberFormatter = NSNumberFormatter()
let number = numberFormatter.numberFromString("15.5")
numberFormatter.numberFromString("hey")

1%2

