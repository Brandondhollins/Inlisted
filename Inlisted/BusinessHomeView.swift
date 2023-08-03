//
//  BusinessHomeView.swift
//  Inlisted
//
//  Created by Brandon D Hollins on 8/3/23.
//

struct BusinessOwnerHomeView: View {
    @State private var isContentView = false

    var body: some View {
        VStack {
            Text("Welcome to the Business Owner Home View!")
            // Add more components for the business owner home view here
            Button("Log Out", action: logout)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            NavigationLink(destination: ContentView(), isActive: $isContentView) {
                EmptyView()
            }
        }
    }

    func logout() {
        let app = App(id: "YOUR_REALM_APP_ID") // replace with your Realm app ID
        app.currentUser?.logOut { (_) in
            // User logged out successfully!
            isContentView = true
        }
    }
}

#Preview {
    BusinessHomeView()
}
