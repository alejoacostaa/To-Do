//
//  AddNewCategoryView.swift
//  To-Do
//
//  Created by Alejo Acosta on 16/05/2021.
//

import SwiftUI

struct AddNewCategoryView: View {
    @State private var categoryName = ""
    @StateObject var vm : viewModel
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Category name", text: $categoryName)
                }
                Button(action: {
                    vm.addCategory(moc: self.moc, categoryTitle: categoryName)
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Save Category!")
                    
                })
                .disabled(self.categoryName.isEmpty)
            }
            .navigationTitle("Add Category")
        }

    }
}


struct AddNewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCategoryView(vm: viewModel())
    }
}
