import Foundation

struct User {
    let name: String
    var drinks: [Drink]
    var drinksString: [String]
    
    init (name:String, drinks:[String]){
        self.name = name
        self.drinksString = drinks
        self.drinks = []
        
        for drink in drinks {
            self.drinks.append(Drink(name:drink))
        }
        
    }
    
    init (name:String, drinks:[Drink]){
        self.name = name
        self.drinks = drinks
        self.drinksString = []
    }
    
    init (name:String) {
        self.name = name
        self.drinks = []
        self.drinksString = []
    }
    
    func string() -> String {
        return "\(name)"
    }
}

