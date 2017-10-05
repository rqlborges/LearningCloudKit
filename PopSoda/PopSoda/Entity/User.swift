import Foundation
import CloudKit

struct User {
    let id: CKRecordID?
    let name: String
    var drinks: [Drink]
    var drinksString: [String]
    
    init (name:String, drinks:[String], id:CKRecordID){
        self.name = name
        self.drinksString = drinks
        self.drinks = []
        self.id = id
        
        for drink in drinks {
            self.drinks.append(Drink(name:drink))
        }
        
    }
    
    init (name:String, drinks:[String]){
        self.name = name
        self.drinksString = drinks
        self.drinks = []
        self.id = nil
        
        for drink in drinks {
            self.drinks.append(Drink(name:drink))
        }
        
    }
    
    init (name:String, drinks:[Drink]){
        self.name = name
        self.drinks = drinks
        self.drinksString = []
        self.id = nil
    }
    
    init (name:String) {
        self.name = name
        self.drinks = []
        self.drinksString = []
        self.id = nil
    }
    
    func string() -> String {
        return "\(name)"
    }
}

