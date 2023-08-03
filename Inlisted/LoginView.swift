//
//  LoginView.swift
//  Inlisted
//
//  Created by Brandon D Hollins on 8/3/23.
//

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isJobSeekerHomeView = false
    @State private var isBusinessOwnerHomeView = false

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()
                .border(Color.gray, width: 0.5)
            SecureField("Password", text: $password)
                .padding()
                .border(Color.gray, width: 0.5)
            Button("Log In", action: login)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            NavigationLink(destination: JobSeekerHomeView(), isActive: $isJobSeekerHomeView) {
                EmptyView()
            }
            NavigationLink(destination: BusinessOwnerHomeView(), isActive: $isBusinessOwnerHomeView) {
                EmptyView()
            }
        }
        .padding()
    }

    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        let app = App(id: "YOUR_REALM_APP_ID") // replace with your Realm app ID
        app.login(credentials: Credentials.emailPassword(email: email, password: password)) { (result) in
            switch result {
            case .failure(let error):
                errorMessage = "Failed to log in: \(error.localizedDescription)"
            case .success(let user):
                // User logged in successfully!
                // Now you can access the user's data in the Realm database
                navigateUser(user: user)
            }
        }
    }

    func navigateUser(user: User) {
        let userType = user.customData["userType"] as? String // replace with your actual key
        switch userType {
        case "job seeker":
            isJobSeekerHomeView = true
        case "business owner":
            isBusinessOwnerHomeView = true
        default:
            break
        }
    }
}
#Preview {
    LoginView()
}
