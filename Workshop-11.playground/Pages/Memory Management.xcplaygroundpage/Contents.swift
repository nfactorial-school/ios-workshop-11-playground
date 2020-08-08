//: [Previous](@previous)

//: # Reference vs Value type
//: ## Classes are reference type
//: Modifying instances of class
class SomeClass {
    var property = "initial"
}

// allocating SomeClass object in heap and setting object1 variable to a reference to it
let object1 = SomeClass()

// copying object1 reference to variable object2
let object2 = object1

object1.property = "changed"

print("object1 property: \(object1.property)")
print("object2 property: \(object2.property)")

//: ## Structs are value type
//: Modifying instances of struct

struct SomeStruct {
    var property = "initial"
}

// allocating SomeStruct instance in frame and setting structInstance1 to it (not a reference)
var structInstance1 = SomeStruct()

// copying structInstance1 to structInstance2, so now we have two instances of SomeStruct, not one
var structInstance2 = structInstance1

structInstance1.property = "changed"

print("structInstance1 property: \(structInstance1.property)")
print("structInstance2 property: \(structInstance2.property)")

//: Modifying string

var string1 = "initial"
var string2 = string1
string1 = "changed"

print("string1: \(string1)")
print("string2: \(string2)")

//: Modifying array

var array1 = ["1", "2"]
var array2 = array1

array1.append("3")

print("array1: \(array1)")
print("array2: \(array2)")

//: var vs let with reference and value types
let object3 = SomeClass()
// You can modify objects even if they are 'let' variables
object3.property = ""
//object3 = SomeClass()

let structInstance3 = SomeStruct()
// You can't modify objects even if they are 'let' variables
//structInstance3.property = ""
//structInstance3 = SomeStruct()

// Could you tell why this happens?

//: #Automatic reference counting (ARC)
//: Basic example:
print("\nBasic Example:\n")
class FooClass {
    // deinit is called when object is removed from heap
    deinit {
        print("FooClass deinit")
    }
}

// creating a FooClass object and setting fooObject1 to a reference #1
var fooObject1: FooClass? = FooClass()
// creating reference #2
var fooObject2 = fooObject1
// creating reference #3
var fooObject3 = fooObject1

// removing reference #1
fooObject1 = nil
// removing reference #2
fooObject2 = nil
// removing reference #3
fooObject3 = nil

//: Intermediate Example
print("\nIntermediate Example:\n")
class BarClass {
    // Declaration of an instance variable (property), which is a reference to an object of FooClass.
    var fooObject: FooClass?
    
    deinit {
        print("BarClass deinit")
    }
}

// creating a FooClass object and setting foo1Object1 to a reference #1
var foo1Object1: FooClass? = FooClass()

// creating an object of BarClass and setting barObject to a reference to it
var barObject: BarClass? = BarClass()

// creating reference #2 by setting barObject's property fooObject to a reference #2
barObject?.fooObject = foo1Object1

// barObject -> foo1Object1

// removing reference #1
foo1Object1 = nil
// removing reference #2 (along with removing barObject by removing a single reference to it)
barObject = nil

//: Advanced Example
print("\nAdvanced Example:\n")

class XClass {
    var fooObject: FooClass?
    
    func closure() -> (() -> Void) {
        return {
            // capturing foo2Object1. You just need to call it once to capture it.
            print(self.fooObject!)
        }
    }
    
    deinit {
        print("XClass deinit")
    }
}

var foo2Object1: FooClass? = FooClass()

var xObject: XClass? = XClass()
xObject?.fooObject = foo2Object1

var closure = xObject?.closure()

xObject = nil
foo2Object1 = nil

// closure -> xObject -> fooObject
closure = nil

//: ## Simulating memory leaks
//: Basic example
print("\nSimulating memory leaks:\n")
print("\nBasic example:\n")

class Person {
    var apartment: Apartment?
    
    deinit {
        print("Person deinit")
    }
}

class Apartment {
    weak var tenant: Person?
    
    deinit {
        print("Apartment deinit")
    }
}

// reference #1 to Person
var person: Person? = Person()
// reference #1 to Apartment
var apartment: Apartment? = Apartment()

// reference #2 to person
apartment?.tenant = person
// reference #2 to apartment
person?.apartment = apartment

// removing reference #1 to person
person = nil
// removing reference #1 to apartment
apartment = nil

//: Example with protocol
print("\nExample with protocol:\n")

protocol ManagerDelegate: AnyObject {}

class Manager {
    weak var delegate: ManagerDelegate?
    
    deinit {
        print("Manager deinit")
    }
}

class View: ManagerDelegate {
    var manager: Manager?
    
    deinit {
        print("View deinit")
    }
}

// reference #1 to manager
var manager: Manager? = Manager()
// reference #2 to view
var view: View? = View()

// reference #2 to manager
view?.manager = manager
// reference #2 to view
manager?.delegate = view

// removing reference #1 to manager
manager = nil
// removing reference #1 to view
view = nil

//: Example with closure
print("\nExample with closure:\n")

class ZClass {
    let title = "132"
    var printTitle: (() -> Void)?
    
    init() {
        printTitle = { [weak self] in
            // capturing self (reference to the object)
            if let self = self {
                print(self.title)
            }
        }
    }
    
    deinit {
        print("ZClass deinit")
    }
}

// reference #1 to object of ZClass (and secretly reference #2 too)
var zObject: ZClass? = ZClass()

zObject = nil
