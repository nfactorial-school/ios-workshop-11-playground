//: [Previous](@previous)
//: # Enumerations
//:
//: ## Enumeration Syntax
//: Use `enum` to create an enumeration.
enum CompassPoint {
    case north
    case south
    case east
    case west
}
//: Multiple cases can appear on a single line, separated by commas:
enum CompassPoint2 {
    case north, south, east, west
}
//: Setting var to an enum case value
var directionToHead: CompassPoint = .west
//: Once directionToHead is declared as a CompassPoint, you can set it to a different CompassPoint value using a shorter dot syntax:
directionToHead = .east
//: ## Matching Enumeration Values with a Switch Statement
//: You can match individual enumeration values with a switch statement:
//: You can read this code as:
//: “Consider the value of directionToHead. In the case where it equals .north, print "Lots of planets have a north". In the case where it equals .south, print "Watch out for penguins".” ... and so on.
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}

switch directionToHead {
case .north:
    print("Heading to the north")
default:
    print("Heading to... wait")
}

//: ## Raw values
//: Enumeration cases can come prepopulated with default values (called raw values), which are all of the same type.
//: Raw value type must conform to RawRepresentable protocol. Type conforming to it by default are strings, characters, or any of the integer or floating-point number types. Each raw value must be unique within its enumeration declaration.
enum Rank: Int {
    case ace = 1
    case two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9, ten = 10
    case jack = 11, queen = 12, king = 13
}

//: When you’re working with enumerations that store integer or string raw values, you don’t have to explicitly assign a raw value for each case. When you don’t, Swift automatically assigns the values for you.
enum Rank2: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
}
import UIKit

enum CompassPoint3: String {
    case north, south, east, west
}
//: ## Enum methods
//: Like classes and all other named types, enumerations can have methods associated with them.
enum Rank3: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
            case .ace:
                return "ace"
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            default:
                // Using rawValue
                return String(self.rawValue)
        }
    }
}

print(Rank3.ace.simpleDescription())

//: ## Associated Values
//: If an enumeration has raw values, those values are determined as part of the declaration, which means every instance of a particular enumeration case always has the same raw value. Another choice for enumeration cases is to have values associated with the case—these values are determined when you make the instance, and they can be different for each instance of an enumeration case. You can think of the associated values as behaving like stored properties of the enumeration case instance. For example, consider the case of requesting the sunrise and sunset times from a server. The server either responds with the requested information, or it responds with a description of what went wrong.
enum ServerResponse {
    case success(String, String)
    case failure(String)
}

let success = ServerResponse.success("6:00 am", "8:09 pm")
let failure = ServerResponse.failure("Out of cheese.")

let success2 = ServerResponse.success("4:00 am", "10:09 pm")
let failure2 = ServerResponse.failure("Not found")

let response = success
switch response {
    case let .success(sunrise, sunset):
        print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
    case let .failure(message):
        print("Failure...  \(message)")
}

//: [Next](@next)

