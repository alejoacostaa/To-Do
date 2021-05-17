//
//  AddTaskView.swift
//  To-Do
//
//  Created by Alejo Acosta on 15/05/2021.
//

import SwiftUI
import CoreData
struct AddTaskView: View {
    //CoreDatas managedObjectEnvironment
    @StateObject var vm : viewModel
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    var categories : FetchedResults<Category>
    @State private var taskTitle : String = ""
    @State private var taskPriority : String = "Low"
    
    @State private var chosenCategory : String? = ""
    
    @State private var taskDate : Date = Date()
    

    let priorities = ["Low", "High"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Task info")) {
                    TextField("Task title", text: $taskTitle)
                    
                }
                Section {
                    DatePicker("Date", selection: $taskDate)
                }
                
                Section {
                    Picker(
                        selection: $taskPriority,
                        label: Text("Priority")
                    ) {
                        ForEach(self.priorities, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                }
                
                
                Section {
                    Picker(
                        selection: $chosenCategory,
                        label: Text("Category")
                    ) {
                        ForEach(self.categories, id: \.categoryName) { cat in
                            Text(cat.categoryName ?? "Unknown").tag(cat.id)
                        }
                    }
                }
                    
                    
                    
                
                
                Section {
                    Button("Save") {
                        self.vm.addTask(moc: self.moc, title: self.taskTitle, date: self.taskDate, priority: self.taskPriority, chosenCategory: chosenCategory!)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(self.taskTitle.isEmpty)
                    
                }
            }
            .navigationTitle("Add Task")
        }
    }
}

//struct AddTaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTaskView(vm: viewModel(), categories: FetchedResults<Category>)
//    }
//}
