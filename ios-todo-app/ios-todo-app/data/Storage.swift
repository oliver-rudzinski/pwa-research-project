//
//  Storage.swift
//  ios-todo-app
//
//  Created by Oliver Rudzinski on 09.11.19.
//  Copyright © 2019 Oliver Rudzinski. All rights reserved.
//

import CoreData
import Foundation

class Storage {
    
    init() {}

    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ios_todo_app")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    static func saveContext () {
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
    
    
    static func createToDo(toDoText: String, completion: (ToDo) -> Void) {
        guard let toDoEntity = NSEntityDescription.entity(forEntityName: "ToDo", in: context) else { return }
        
        let newToDo = ToDo.init(entity: toDoEntity, insertInto: context)
        
        newToDo.id = UUID()
        newToDo.text = toDoText
        newToDo.done = false
        newToDo.priority = false
        
        saveContext()
        print("[STORAGE] Created To-Do '\(toDoText)' with ID \(String(describing: newToDo.id))")
        completion(newToDo)
    }
    
    static func loadToDos(completion: ([ToDo]) -> Void) {
        let request: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        
        do {
            let toDosFromDisk = try context.fetch(request)
            completion(toDosFromDisk)
            
            print("[STORAGE] Loaded to-dos:")
            for toDo in toDosFromDisk {
                print("\(String(describing: toDo.id)): '\(String(describing: toDo.text))'")
            }
        } catch {
            fatalError("[STORAGE/Error]: Could not load to-do entities from disk: \(error)")
        }
    }
    
    static func editToDoText(toDo: ToDo, newToDoText: String?) {
        toDo.text = newToDoText
        saveContext()
    }
    
    static func changeStatus(toDo: ToDo, done: Bool) {
        toDo.done = done
        saveContext()
    }
    
    static func changePriority(toDo: ToDo, priority: Bool) {
        toDo.priority = priority
        saveContext()
    }
    
    static func removeToDo(toDo: ToDo) {
        print("[STORAGE: Deleting to-do '\(String(describing: toDo.text))' with ID \(String(describing: toDo.id))]...")
        context.delete(toDo)
        saveContext()
        print("[STORAGE]: Deleted.")
    }
    
}
