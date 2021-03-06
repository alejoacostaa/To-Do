//
//  ContentView.swift
//  To-Do
//
//  Created by Alejo Acosta on 15/05/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var vm = viewModel()
    @State private var showingAddSheet = false
    @State private var addCategory = false
    //In order to iterate through both the To Do Items as well as the categories, we fetch all entities with CoreData
    @FetchRequest(entity: ToDoItem.entity(), sortDescriptors: []) var toDoItems : FetchedResults<ToDoItem>
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) var categories : FetchedResults<Category>
    

    var body: some View {
        NavigationView {
                List {
                        Section(header: Text("Grouped Tasks")) {
                            ForEach(categories, id: \.self) { category in
                                let filteredTasks = self.vm.getTasksForCategory(moc: self.viewContext, category: category.categoryName!)
                                NavigationLink(destination: TasksListView(vm: self.vm, tasks: filteredTasks, categoryName: category.categoryName!).environment(\.managedObjectContext, self.viewContext)) {
                                    
                                    Text(category.categoryName!)
                                }
                            }
                            .onDelete(perform: deleteCategories)
                        }
                        Section(header: Text("All Tasks")) {
                            ForEach(toDoItems, id: \.self) { toDoItem in

                                TaskView(vm: self.vm, title: toDoItem.title!, priority: toDoItem.priority!, date: toDoItem.date!, isCompleted: toDoItem.completed)
                            }
                            .onDelete(perform: deleteTasks)
                        }
            }
                .listStyle(GroupedListStyle())
                .navigationTitle("To-Do!")

                .navigationBarItems(leading: EditButton(), trailing: HStack(spacing: 20) {
                    Button(action: {self.addCategory = true}, label: {
                        Image(systemName: "folder.badge.plus")
                    })
                    Button(action: {self.showingAddSheet = true}, label: {
                        Image(systemName: "plus")
                    })
                })
                
                .sheet(isPresented: $addCategory) {
                    AddNewCategoryView(vm: vm).environment(\.managedObjectContext, self.viewContext)
                }
                
                .sheet(isPresented: $showingAddSheet) {
                    AddTaskView(vm: vm, categories: self.categories).environment(\.managedObjectContext, self.viewContext)
                }
        }

    }
    
    
    //Ideally, this should go in the viewModel so as to respect the MVVM architectural pattern, but im pretty low on time right now so in a future version, Ill move it :)
    func deleteCategories(at offsets: IndexSet) {
        for offset in offsets {
            self.vm.deleteCategories(moc: self.viewContext, category: categories[offset].categoryName!)
            let cat = categories[offset]
            viewContext.delete(cat)
        }
        
        try? viewContext.save()
       
    }
    
    func deleteTasks(at offsets: IndexSet) {
        for offset in offsets {
            let task = toDoItems[offset]
            viewContext.delete(task)
        }
        try? viewContext.save()
    }
    

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
