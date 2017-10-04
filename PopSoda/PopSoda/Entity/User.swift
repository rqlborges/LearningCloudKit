import Foundation

enum UserKey: String {
    case userName
}

struct User {
    let name: String
    
    func string() -> String {
        return "\(name)"
    }
}

