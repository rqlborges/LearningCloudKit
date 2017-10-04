import Foundation

enum DrinkKey: String {
    case name
}

struct Drink {
    let name: String
    
    func string() -> String {
        return "\(name)"
    }
}

