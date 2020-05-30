import Foundation

//: # Protocols
//: Protocols are, as per Apple's definition in the _Swift Programming Language_ book:
//:
//: "... a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol."
//:
//: The below example shows a protocol that requires conforming types have a particular property defined.

protocol FullyNamed {
    var fullName: String { get }
}

// struct STRUCT: PROTOCOL... is the adoption

struct Person: FullyNamed {
    var fullName: String
}

let johnny = Person(fullName: "Johnny Hicks")
let ben = Person(fullName: "Ben")

//print(johnny.fullName)
// outputs "Johnny Hicks"

class StarShip: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    // Computed Property
    var fullName: String {
        return (prefix != nil ? prefix! + " ": "") + self.name
    }
}

var ncc1701 = StarShip(name: "Enterprise", prefix: "USS")
ncc1701.fullName

var firefly = StarShip(name: "Serenity")
firefly.fullName

//: Protocols can also require that conforming types implement certain methods.

protocol GeneratesRandomNumbers {
    func random() -> Int
}

class OneThroughTen: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...10)
    }
}

let rand = OneThroughTen()
rand.random()

//: Using built-in Protocols

extension StarShip: Equatable {
    // static property - on the class itself, not an instance
    static func == (lhs: StarShip, rhs: StarShip) -> Bool {
        if lhs.fullName == rhs.fullName {
            return true
        } else {
            return false
        }
    }
}

if ncc1701 == firefly {
    print("same ship")
}

//: ## Protocols as Types

class Dice {
    let sides: Int
    let generator: GeneratesRandomNumbers
    
    init(sides: Int, generator: GeneratesRandomNumbers) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() % sides) + 1
    }
}

var d6 = Dice(sides: 6, generator: OneThroughTen())

for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

