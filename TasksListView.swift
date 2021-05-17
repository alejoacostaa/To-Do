//
//  TasksListView.swift
//  To-Do
//
//  Created by Alejo Acosta on 16/05/2021.
//

import SwiftUI

struct TasksListView: View {
    @StateObject var vm : viewModel
    @FetchRequest(entity: ToDoItem.entity(), sortDescriptors: []) var toDoItems : FetchedResults<ToDoItem>
    @Environment(\.managedObjectContext) var moc
    var tasks : [ToDoItem]
    var categoryName : String
    
    
        
    
    var body: some View {
            List {
                ForEach(tasks, id:\.self) { task in
                    TaskView(vm: self.vm, title: task.title!, priority: task.priority!, date: task.date!, isCompleted: task.completed).environment(\.managedObjectContext, self.moc)
                }
                .onDelete(perform: deleteTasks)
            }
            .navigationTitle("\(categoryName)")
    }
    

    
    func deleteTasks(at offsets: IndexSet) {
        for offset in offsets {
            let task = toDoItems[offset]
            moc.delete(task)
        }
        try? moc.save()
    }
}

//struct TasksListView_Previews: PreviewProvider {
//    let testItem = ToDoItem(context: <#T##NSManagedObjectContext#>)
//    static var previews: some View {
//        TasksListView(tasks: [ToDoItem(])
//    }
//}
