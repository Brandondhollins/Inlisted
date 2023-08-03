//
//  ContentView.swift
//  Inlisted
//
//  Created by Brandon D Hollins on 8/3/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LoginView()) {
                    Text("Log In")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                NavigationLink(destination: SignUpView()) {
                    Text("Sign Up")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}












