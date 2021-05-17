//
//  ViewModel.swift
//  To-Do
//
//  Created by Alejo Acosta on 15/05/2021.
//

import Foundation
import CoreData


class viewModel : ObservableObject {
    
    //Inserts a task through CoreData
    func addTask(moc : NSManagedObjectContext, title : String, date : Date, priority : String, chosenCategory : String) {
       
        let newTask = ToDoItem(context: moc)
        newTask.title = title
        newTask.date = date
        newTask.priority = priority
        newTask.completed = false
        newTask.category = chosenCategory
        try? moc.save()
    }
    
    //Inserts a Category through CoreData
    func addCategory(moc : NSManagedObjectContext, categoryTitle : String) {
        let newCategory = Category(context: moc)
        newCategory.id = UUID()
        newCategory.categoryName = categoryTitle
        try? moc.save()
    }
   
    
    
    
    
    //Returns an array with all the tasks for a given category
    func getTasksForCategory(moc : NSManagedObjectContext, category : String) -> [ToDoItem] {
        let fetchRequest = NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
        let filterPredicate = NSPredicate(format: "category == %@", category)
        fetchRequest.predicate = filterPredicate
        do {
            if let results = try moc.fetch(fetchRequest) as? [ToDoItem] {
                return results
            }
        } catch {
            fatalError("Error fetching data")
        }
    }
    //Deletes all the tasks associated with a given category
    func deleteCategories(moc : NSManagedObjectContext, category : String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ToDoItem")
        let predicate = NSPredicate(format: "category == %@", category)
        fetchRequest.predicate = predicate
        do {
            let results = try moc.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    moc.delete(managedObjectData)
                }
            }
            try? moc.save()
        } catch let error as NSError {
            print("Error deleting data: \(error)")
        }
    }
    
    
    //Marks a Task as Completed/Uncompleted
    func updateCompletion(moc : NSManagedObjectContext, title : String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ToDoItem")
        let predicate = NSPredicate(format: "title == %@", title)
        fetchRequest.predicate = predicate
        
        do {
          let results = try moc.fetch(fetchRequest) as? [ToDoItem]
            results?[0].completed.toggle()
            try? moc.save()
        } catch {
          print("failed to fetch record from CoreData")
        }
        
    }
}


