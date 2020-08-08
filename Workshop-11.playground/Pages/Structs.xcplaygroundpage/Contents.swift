import UIKit

//: [Previous](@previous)

//: # Structs vs Classes
//: Structures and classes are general-purpose, flexible constructs that become the building blocks of your program’s code. You define properties and methods to add functionality to your structures and classes using the same syntax you use to define constants, variables, and functions.
//: ## Structs.
//: Define properties to store values, define methods, define initializers, conform to protocols.
//: Have synthesized memberwise initializers.
struct PersonS: Paying {
    let firstName: String
    let lastName: String
    
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
    func pay() {
        print("pay")
    }
}

let personS = PersonS(firstName: "John", lastName: "Appleesed")
print(personS.fullName())

//: Don't support inheritance.
//struct Tenant: PersonS {
//
//}

//: ## Class
//: Define properties to store values, define methods, define initializers, conform to protocols.
//: Don't have synthesized memberwise initializers.

class PersonC: Paying {
    let firstName: String
    let lastName: String
    
    // Classes don't have syntesized memberwise initializers
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func fullName() -> String {
        return "\(firstName) \(lastName)"
    }
    
    func pay() {
        print("pay")
    }
}

let personC = PersonC(firstName: "John", lastName: "Appleesed")

print(personC.fullName())

//: Classes support inheritance
class TenantC: PersonC {
    let apartment: String
    var deposit: Int?
    
    // we need to initialize all the stored properties as well as in structures.
    init(firstName: String, lastName: String, apartment: String) {
        self.apartment = apartment
        super.init(firstName: firstName, lastName: lastName)
    }
}

let tenant = TenantC(firstName: "123", lastName: "123", apartment: "123")



//: All the swift primitives are structs
let number: Int
let string: String
let array: Array<Int> // === let array: [Int]
let dictionary: Dictionary<String, Int> // === let dictionary: [String: Int]

//: [Next](@next)





protocol Paying {
    func pay()
}
