import UIKit
import CloudKit

class UserManager {
    
    // Singleton instance of the User Manager
    static let shared = UserManager()
    
    // Represents the default container specified in the iCloud section of the Capabilities tab for the project.
    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    
    let UserType = "User"
    
    // Initializer for the default container and for the 2 CloudKit Databases.
    init() {
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    // Persistance CRUD - Save User.
    func save(user: User) {
        let record = CKRecord(recordType: UserType)
        record[.name] = user.name
        record[.drinks] = user.drinksString
        
        publicDB.save(record) { (record, error) in
            guard error == nil else {
                print("Problema ao salvar o usuário")
                return
            }
            print("Usuário salvo com sucesso")
        }
    }
    
    // Persistance CRUD - Get All Users
    func fetchData(name: String, callback: @escaping ([User]?, Error?)->Void) {
        // Creates the predicate for true value
        let predicate = NSPredicate(format: "name == %@", "Erick")
        
        // Creates the query for fetching the right data.
        let query = CKQuery(recordType: UserType, predicate: predicate)
        
        // Performs the query search in the publicDB
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            
            // Throws error to callback, passing a nil response and custom error.
            guard error == nil else {
                callback(nil, error)
                return
            }
            
            // Creates a NSError with code 500 Generic error. passing a nil response
            guard let userRecords = records else {
                let e = NSError(domain: "", code: 500, userInfo: nil)
                callback(nil, e)
                return
            }
            
            // Get the students data and build all objects for sending the response.
            let users = userRecords.map({ (record) -> User in
                let name = record.value(forKey: "name") as? String ?? ""
                let drinksString = record.value(forKey: "drinks") as? [String] ?? []
                return User(name: name, drinks: drinksString)
            })
            
            // Callback return with users setted.
            callback(users, nil)
        }
    }
}

