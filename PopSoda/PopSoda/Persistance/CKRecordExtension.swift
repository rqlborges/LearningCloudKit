import Foundation
import CloudKit

/* CKRecord Extensions */

extension CKRecord {
    
    // Subscription method for CKRecord for passing a Enumeration of the Drink Keys.
    subscript(key: EntityKey) -> Any? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue as? CKRecordValue
        }
    }
    
}
