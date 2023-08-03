//
//  JobSeekerOnboarding1View.swift
//  Inlisted
//
//  Created by Brandon D Hollins on 8/3/23.
//

struct JobSeekerOnboardingView: View {
    var email: String
    var userType: String
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthdate = Date()
    @State private var profilePictureURL = ""
    @State private var bio = ""
    @State private var skills = ""

    var body: some View {
        VStack {
            TextField("First Name", text: $firstName)
                .padding()
                .border(Color.gray, width: 0.5)
            TextField("Last Name", text: $lastName)
                .padding()
                .border(Color.gray, width: 0.5)
            DatePicker("Birthdate", selection: $birthdate, displayedComponents: .date)
                .padding()
                .border(Color.gray, width: 0.5)
            TextField("Profile Picture URL", text: $profilePictureURL)
                .padding()
                .border(Color.gray, width: 0.5)
            TextField("Bio", text: $bio)
                .padding()
                .border(Color.gray, width: 0.5)
            TextField("Skills", text: $skills)
                .padding()
                .border(Color.gray, width: 0.5)
            Button("Complete Onboarding", action: completeOnboarding)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
    }

    func completeOnboarding() {
        let app = App(id: "YOUR_REALM_APP_ID") // replace with your Realm app ID
        let user = app.currentUser!
        let config = user.configuration(partitionValue: "user=\(user.id)")
        let realm = try! Realm(configuration: config)

        let jobSeekerProfile = JobSeekerProfile()
        jobSeekerProfile.email = email
        jobSeekerProfile.userType = userType
        jobSeekerProfile.firstName = firstName
        jobSeekerProfile.lastName = lastName
        jobSeekerProfile.birthdate = birthdate
        jobSeekerProfile.profilePictureURL = profilePictureURL
        jobSeekerProfile.bio = bio
        jobSeekerProfile.skills = skills

        try! realm.write {
            realm.add(jobSeekerProfile)
        }
    }
}
#Preview {
    JobSeekerOnboarding1View()
}
