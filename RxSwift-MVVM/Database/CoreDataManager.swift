
import Foundation
import CoreData

final class CoreDataManager {
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "RxSwift_MVVM")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Operations
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func deleteAllData(entity: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try self.persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                self.persistentContainer.viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    func createRow(entitiy: String) -> NSManagedObject {
        let context = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entitiy, in: context)
        return NSManagedObject(entity: entity!, insertInto: context)
    }
    
    func fetchAllRows(entity: String) -> [Any]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PostItemDb")
        request.returnsObjectsAsFaults = false
        do {
            return try self.persistentContainer.viewContext.fetch(request)
            
        } catch {
            return nil
        }
    }
}
