//
//  BusinessOnboarding1View.swift
//  Inlisted
//
//  Created by Brandon D Hollins on 8/3/23.
//

struct BusinessOnboardingView: View {
    var email: String
    var userType: String
    @State private var businessName = ""
    @State private var profilePictureURL = ""
    @State private var bio = ""
    @State private var openRoles = ""

    var body: some View {
        VStack {
            TextField("Business Name", text: $businessName)
                .padding()
                .border(Color.gray, width: 0.5)
            TextField("Profile Picture URL", text: $profilePictureURL)
                .padding()
                .border(Color.gray, width: 0.5)
            TextField("Bio", text: $bio)
                .padding()
                .border(Color.gray, width: 0.5)
            TextField("Open Roles", text: $openRoles)
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

        let businessProfile = BusinessProfile()
        businessProfile.email = email
        businessProfile.userType = userType
        businessProfile.businessName = businessName
        businessProfile.profilePictureURL = profilePictureURL
        businessProfile.bio = bio
        businessProfile.openRoles = openRoles

        try! realm.write {
            realm.add(businessProfile)
        }
    }
}

#Preview {
    BusinessOnboarding1View()
}
