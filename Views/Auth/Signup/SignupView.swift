import SwiftUI

struct SignupView: View {

    @StateObject var vm = SignupViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            headings
            Spacer(minLength: 30)
            nameSection
            emailSection.padding(.vertical, 12)
            phoneSection
            passwordsSection.padding(.vertical, 12)
            Spacer(minLength: 15)
            CommonButton(
                text: "signup",
                destination: EmptyView(),
                action: {
                    Task {
                        await vm.register()
                    }
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
                action: {}
            )
            Spacer(minLength: 14)
            alreadyAccount
        }
        .overlay(content: {
            if vm.isLoading {
                CommonLoader()
            }
            if vm.errorMessage?.isEmpty == false {
                CommonBanner(isError: true, message: vm.errorMessage ?? "")
            }
        })
        .navigationBarBackButtonHidden()
    }

    //MARK: COMPONENTS

    var headings: some View {
        VStack {
            Image("applogo2")
            Spacer(minLength: 30)
            HStack {
                Text("welcome").font(.custom("Urbanist-Bold", size: 24))
                Text("appName")
                    .foregroundStyle(.accent)
                    .font(.custom("Urbanist-Bold", size: 24))
            }.padding(.vertical, 10)
            Text("create")
                .font(.custom("Urbanist-Regular", size: 18))

        }
    }

    var nameSection: some View {
        VStack(alignment: .leading) {
            Text("name")
                .font(.custom("Urbanist-Regular", size: 12))
                .foregroundStyle(.gray)

            TextField("yourName", text: $vm.nameField)
                .padding()
                .background(.gray.opacity(0.1)) 
                .cornerRadius(10)
                .keyboardType(.default)
                .font(.custom("Urbanist-Regular", size: 14))

        }.padding(.horizontal, 20)
    }

    var emailSection: some View {
        VStack(alignment: .leading) {
            Text("email")
                .font(.custom("Urbanist-Regular", size: 12))
                .foregroundStyle(.gray)

            TextField("enterEmail", text: $vm.emailField)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .keyboardType(.emailAddress)
                .font(.custom("Urbanist-Regular", size: 14))
                .autocorrectionDisabled()

        }.padding(.horizontal, 20)
    }

    var phoneSection: some View {
        VStack(alignment: .leading) {
            Text("Phone Number")
                .font(.custom("Urbanist-Regular", size: 12))
                .foregroundStyle(.gray)

            TextField("Phone Number", text: $vm.mobileNumberField)
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
            Text("password")
                .font(.custom("Urbanist-Regular", size: 12))
                .foregroundStyle(.gray)

            HStack {
                TextField("password", text: $vm.passwordField)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .font(.custom("Urbanist-Regular", size: 14))
                    .frame(width: 169)
                Spacer()
                TextField("confirmPass", text: $vm.confirmPasswordField)
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

            Text("orRegister")
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
            Text("alreadyAccount")
                .foregroundStyle(.gray)
                .font(.custom("Urbanist-Regular", size: 14))
            Button("login") {
                dismiss()
            }
            .font(.custom("Urbanist-Bold", size: 14))
        }
    }
}

#Preview {
    NavigationStack {
        SignupView()
    }
}
