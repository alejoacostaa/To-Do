//
//  TaskView.swift
//  To-Do
//
//  Created by Alejo Acosta on 15/05/2021.
//

import SwiftUI

struct TaskView: View {
    @StateObject var vm : viewModel
    @Environment(\.managedObjectContext) var moc
    var title : String
    var priority : String
    var date : Date
    @State var isCompleted : Bool
    var body: some View {
    
        
        HStack {
            Rectangle()
            
                .fill(self.priority == "High" ? Color.red : Color.green)
                .frame(width: 8, height: 40)
            VStack (alignment: .leading){
                Text(self.title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("Task due on: \(self.getDateFormatted(date: self.date))" )
                    .foregroundColor(.secondary)
            }
            
            Image(systemName: self.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(self.isCompleted ? .green : .red)
                .padding(.leading, 20)
                .onTapGesture {
                    print("tapped")
                    self.isCompleted.toggle()
                    self.vm.updateCompletion(moc: self.moc, title: self.title)
                }
        }
    }
    
    
    func getDateFormatted(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY, MMM d, hh:mm"
        return dateFormatter.string(from: date)
        
    }
}

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView(vm: viewModel(), title: "Workout", priority: "Highh", date: Date(), isCompleted: false)
    }
}
