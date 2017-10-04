import Foundation
import CloudKit

/* CKRecord Extensions */

extension CKRecord {
    
    // Subscription method for CKRecord for passing a Enumeration of the User Keys.
    subscript(key: UserKey) -> Any? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue as? CKRecordValue
        }
    }
    
    // Subscription method for CKRecord for passing a Enumeration of the Drink Keys.
    subscript(key: DrinkKey) -> Any? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue as? CKRecordValue
        }
    }
    
}
