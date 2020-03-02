//
//  CoreDataStack.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 3/2/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "workWithTableView(SwiftBook)")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
             
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
   static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Сохранение удалось")
            } catch {
                let nserror = error as NSError
                fatalError("Сохранение НЕ удалось \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
