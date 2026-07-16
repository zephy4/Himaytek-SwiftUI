import SwiftUI

struct SignupView: View {

    @StateObject var vm = SignupViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                headings
                Spacer(minLength: 30)
                nameSection
                emailSection.padding(.vertical, 12)
                passwordsSection
                Spacer(minLength: 15)
                CommonButton(
                    text: "Sign up",
                    destination: EmptyView(),
                    action: {

                    },
                    isNavigation: false
                )
                registerWith
                    .padding(.vertical, 16)
                SocialButton(icon: "google", social: "Google", action: {})
                SocialButton(icon: "apple", social: "Apple", action: {})
                SocialButton(
                    icon: "avatar",
                    social: "Guest",
                    action: {
                        //                        vm.isGuest = true
                    }
                )
                Spacer(minLength: 14)
                alreadyAccount

            }
        }
        .navigationBarBackButtonHidden()
    }

    //MARK: COMPONENTS

    var headings: some View {
        VStack {
            Image("applogo2")
            Spacer(minLength: 30)
            HStack {
                Text("Welcome to").font(.custom("Urbanist-Bold", size: 24))
                Text("Himaytek")
                    .foregroundStyle(.accent)
                    .font(.custom("Urbanist-Bold", size: 24))
            }.padding(.vertical, 10)
            Text("Create Your Account")
                .font(.custom("Urbanist-Regular", size: 18))

        }
    }

    var nameSection: some View {
        VStack(alignment: .leading) {
            Text("Name")
                .font(.custom("Urbanist-Regular", size: 12))
                .foregroundStyle(.gray)

            TextField("Your Name", text: $vm.nameField)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .keyboardType(.default)
                .font(.custom("Urbanist-Regular", size: 14))

        }.padding(.horizontal, 20)
    }

    var emailSection: some View {
        VStack(alignment: .leading) {
            Text("Email")
                .font(.custom("Urbanist-Regular", size: 12))
                .foregroundStyle(.gray)

            TextField("Enter your Email Address", text: $vm.nameField)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .font(.custom("Urbanist-Regular", size: 14))
                .autocorrectionDisabled()

        }.padding(.horizontal, 20)
    }

    var passwordsSection: some View {
        VStack(alignment: .leading) {
            Text("Password")
                .font(.custom("Urbanist-Regular", size: 12))
                .foregroundStyle(.gray)

            HStack {
                TextField("Password", text: $vm.nameField)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .font(.custom("Urbanist-Regular", size: 14))
                    .frame(width: 169)
                Spacer()
                TextField("Confirm Password", text: $vm.nameField)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .font(.custom("Urbanist-Regular", size: 14))
                    .frame(width: 169)

            }
        }.padding(.horizontal, 20)
    }

    var registerWith: some View {
        HStack(spacing: 16) {

            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)

            Text("Or Register with")
                .font(.custom("Urbanist-Medium", size: 14))
                .foregroundColor(.gray)
                .layoutPriority(1)

            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
        }
        .padding(.horizontal, 20)
    }

    var alreadyAccount: some View {
        HStack {
            Text("Already have an Account?")
                .foregroundStyle(.gray)
                .font(.custom("Urbanist-Regular", size: 14))
            NavigationLink(destination: LoginView()) {
                Text("Login")
                    .font(.custom("Urbanist-Bold", size: 14))
            }
        }
    }
}

#Preview {
    SignupView()
}
