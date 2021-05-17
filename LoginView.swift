//
//  LoginView.swift
//  To-Do
//
//  Created by Alejo Acosta on 16/05/2021.
//

import SwiftUI

import SwiftUI
 
struct LoginView: View {
     
    @State private var email = ""
    @State private var password = ""
    @State private var showingApp = false
    @State private var showingFailAlert = false
    
    
    let finalEmail = "admin"
    let finalPassword = "admin"
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack() {
            Text("Welcome, Ensolvers!")
                .font(.largeTitle).foregroundColor(Color.white)
                .padding([.top, .bottom], 40)
                .shadow(radius: 10.0, x: 20, y: 10)
             
            Image("logo")
                .resizable()
                .frame(width: 250, height: 250)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10.0, x: 20, y: 10)
                .padding(.bottom, 50)
             
            VStack(alignment: .leading, spacing: 15) {
                TextField("Email", text: self.$email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
                 
                SecureField("Password", text: self.$password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }.padding([.leading, .trailing], 27.5)
             
            Button(action: Submit) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(15.0)
                    .shadow(radius: 10.0, x: 20, y: 10)
            }
            .padding(.top, 50)
            .fullScreenCover(isPresented: $showingApp) {
                ContentView().environment(\.managedObjectContext, self.moc)
            }
             
             
            Spacer()
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all))
        .alert(isPresented: $showingFailAlert) {
            Alert(title: Text("Error"), message: Text("Invalid email/password"), dismissButton: .default(Text("Try again !")))
        }
         
    }
     
    func Submit() {
        if(self.email.lowercased() == finalEmail && self.password.lowercased() == finalPassword) {
            self.showingApp.toggle()
        } else {
            self.showingFailAlert.toggle()
        }
        
    }
}
 

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
