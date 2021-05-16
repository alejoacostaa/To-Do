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
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Title")
                TextField("Category name", text: $categoryName)
                Spacer()
                
                HStack {
                    Button(action: {
                        vm.addCategory(moc: self.moc, categoryTitle: categoryName)
                    }, label: {
                        Text("Save Category!")
                        
                    })
                    .disabled(self.categoryName.isEmpty)
                }
                Spacer()
            }
            .navigationTitle("Add Category")
            .padding()
        }
    }
}

struct AddNewCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCategoryView(vm: viewModel())
    }
}
