import Foundation

enum DrinkKey: String {
    case drinkName
}

struct Drink {
    let name: String
    
    func string() -> String {
        return "\(name)"
    }
}

