import Foundation

enum UserKey: String {
    case name
}

struct User {
    let name: String
    
    func string() -> String {
        return "\(name)"
    }
}

