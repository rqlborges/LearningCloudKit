import UIKit
import CloudKit
import UserNotifications

class DrinkManager {
    
    // Singleton instance of the User Manager
    static let shared = UserManager()
    
    // Represents the default container specified in the iCloud section of the Capabilities tab for the project.
    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    
    let DrinkType = "Drink"
    
    // Initializer for the default container and for the 2 CloudKit Databases.
    init() {
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    // Persistance CRUD - Save Drink.
    func save(drink: Drink) {
        let record = CKRecord(recordType: DrinkType)
        record[.name] = drink.name
        
        publicDB.save(record) { (record, error) in
            guard error == nil else {
                print("Problema ao salvar o usuário")
                return
            }
            print("Usuário salvo com sucesso")
        }
    }
    
    // Persistance CRUD - Get All Drinks.
    func fetchData(callback: @escaping ([Drink]?, Error?)->Void) {
        
        // Creates the predicate for true value
        let predicate = NSPredicate(value: true)
        
        // Creates the query for fetching the right data.
        let query = CKQuery(recordType: DrinkType, predicate: predicate)
        
        // Performs the query search in the publicDB
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            
            // Throws error to callback, passing a nil response and custom error.
            guard error == nil else {
                callback(nil, error)
                return
            }
            
            // Creates a NSError with code 500 Generic error. passing a nil response
            guard let drinkRecords = records else {
                let e = NSError(domain: "", code: 500, userInfo: nil)
                callback(nil, e)
                return
            }
            
            // Get the students data and build all objects for sending the response.
            let drinks = drinkRecords.map({ (record) -> Drink in
                let name = record.value(forKey: "name") as? String ?? ""
                return Drink(name: name)
            })
            
            // Callback return with users setted.
            callback(drinks, nil)
        }
    }
}
