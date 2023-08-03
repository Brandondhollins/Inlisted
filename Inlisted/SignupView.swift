//
//  SignupView.swift
//  Inlisted
//
//  Created by Brandon D Hollins on 8/3/23.
//

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userType = ""
    @State private var errorMessage = ""
    @State private var isJobSeekerOnboardingView = false
    @State private var isBusinessOnboardingView = false

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
            Picker("User Type", selection: $userType) {
                Text("Job Seeker").tag("job seeker")
                Text("Business Owner").tag("business owner")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Button("Sign Up", action: signUp)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            NavigationLink(destination: JobSeekerOnboardingView(email: email, userType: userType), isActive: $isJobSeekerOnboardingView) {
                EmptyView()
            }
            NavigationLink(destination: BusinessOnboardingView(email: email, userType: userType), isActive: $isBusinessOnboardingView) {
                EmptyView()
            }
        }
        .padding()
    }

    func signUp() {
        guard !email.isEmpty, !password.isEmpty, !userType.isEmpty else {
            errorMessage = "Please fill in all fields."
            return
        }
        let app = App(id: "YOUR_REALM_APP_ID") // replace with your Realm app ID
        app.emailPasswordAuth.registerUser(email: email, password: password) { (error) in
            if let error = error {
                errorMessage = "Failed to sign up user: \(error.localizedDescription)"
                return
            }
            // User signed up successfully!
            // Now you can navigate the user to the onboarding screen
            switch userType {
            case "job seeker":
                isJobSeekerOnboardingView = true
            case "business owner":
                isBusinessOnboardingView = true
            default:
                break
            }
        }
    }
}

#Preview {
    SignupView()
}
