//
//  ViewModel.swift
//  To-Do
//
//  Created by Alejo Acosta on 15/05/2021.
//

import Foundation
import CoreData


class viewModel : ObservableObject {
    
    func addTask(moc : NSManagedObjectContext, title : String, date : Date, priority : String, chosenCategory : String) {
       // let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ToDoItem")
        //let predicate = NSPredicate(format: "title == %@", title)
        //fetchRequest.predicate = predicate
        //let results = try? moc.fetch(fetchRequest)
        
        let task : ToDoItem
        let fetchUser: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        fetchUser.predicate = NSPredicate(format: "title == %@", title)
        
        let results = try? moc.fetch(fetchUser)

        
        
        
        if results?.count == 0 {
            // here you are inserting
            print("Inserting")
            let newTask = ToDoItem(context: moc)
            newTask.title = title
            newTask.date = date
            newTask.priority = priority
            newTask.completed = false
            newTask.category = chosenCategory
            try? moc.save()
         } else {
            // here you are updating
            print("Editing")
            task = (results?.first)!
            task.title = title
            task.date = date
            task.priority = priority
            task.category = chosenCategory
            try? moc.save()
         }
        
        
        
        
        
        
        
        
        
//        let newTask = ToDoItem(context: moc)
//        newTask.title = title
//        newTask.date = date
//        newTask.priority = priority
//        newTask.completed = false
//        newTask.category = chosenCategory
//        try? moc.save()
    }
    
    
    func addCategory(moc : NSManagedObjectContext, categoryTitle : String) {
        let newCategory = Category(context: moc)
        newCategory.id = UUID()
        newCategory.categoryName = categoryTitle
        try? moc.save()
    }
    
    func deleteTasks(moc : NSManagedObjectContext, at offsets: IndexSet, tasks : [ToDoItem]) {
        for offset in offsets {
            let task = tasks [offset]
            moc.delete(task)
        }
        try? moc.save()
    }
    
    
    
    
    
    func getTasksForCategory(moc : NSManagedObjectContext, category : String) -> [ToDoItem] {
        let fetchRequest = NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
        let filterPredicate = NSPredicate(format: "category == %@", category)
        fetchRequest.predicate = filterPredicate
        do {
            if let results = try moc.fetch(fetchRequest) as? [ToDoItem] {
                return results
            }
        } catch {
            fatalError("Error fetching")
        }
    }
    
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
            print("Deleted all my data in myEntity error : \(error) \(error.userInfo)")
        }
    }
    
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


