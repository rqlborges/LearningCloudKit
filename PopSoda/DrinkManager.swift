import UIKit
import CloudKit
import UserNotifications

class DrinkManager {
    
    // Singleton instance of the User Manager
    static let shared = DrinkManager()
    
    // Represents the default container specified in the iCloud section of the Capabilities tab for the project.
    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    
    let MackStudentType = "MackStudent"
    
    // MARK: - Initializers
    init() {
        container = CKContainer.default()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    func save(mackStudent: MackStudent) {
        let record = CKRecord(recordType: MackStudentType)
        record[.tia] = mackStudent.tia
        record[.name] = mackStudent.name
        
        publicDB.save(record) { (record, error) in
            guard error == nil else {
                print("Problema ao tentar salvar o registro")
                return
            }
            
            print("Registro salvo com sucesso")
        }
    }
    
    func fetchMackStudent(callback: @escaping ([MackStudent]?, Error?)->Void) {
        // 1
        let predicate = NSPredicate(value: true)
        
        // 2
        let query = CKQuery(recordType: MackStudentType, predicate: predicate)
        
        //3
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            guard error == nil else {
                callback(nil, error)
                return
            }
            
            guard let studentRecords = records else {
                let e = NSError(domain: "", code: 500, userInfo: nil)
                callback(nil, e)
                return
            }
            
            let students = studentRecords.map({ (record) -> MackStudent in
                let tia = record.value(forKey: "tia") as? String ?? ""
                let name = record.value(forKey: "name") as? String ?? ""
                
                return MackStudent(tia: tia, name: name)
            })
            
            callback(students, nil)
        }
    }
    
    func startObservingChanges() {
        
        if let sid = UserDefaults.standard.value(forKey: "subscriptionID") as? String {
            print("Notificação já registrada \(sid)")
            //            return
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (authorized, error) in
            guard error == nil, authorized else {
                return
            }
            
            self.getNotificationSettings()
            
            let subscription = CKQuerySubscription(recordType: self.MackStudentType, predicate: NSPredicate(value: true), options: [.firesOnRecordCreation])
            
            let info = CKNotificationInfo()
            info.alertLocalizationKey = "mackstudents_updated_alert"
            info.alertLocalizationArgs = ["name"]
            info.soundName = "default"
            info.desiredKeys = ["name"]
            subscription.notificationInfo = info
            
            self.publicDB.save(subscription, completionHandler: { (savedSubscription, error) in
                guard let savedSubscription = savedSubscription, error == nil else {
                    print("Problema na Subscription \(error!)")
                    return
                }
                
                UserDefaults.standard.set(savedSubscription.subscriptionID, forKey: "subscriptionID")
            })
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
        }
    }
}
