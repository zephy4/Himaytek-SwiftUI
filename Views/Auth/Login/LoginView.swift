import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModel()

    var body: some View {
        ZStack {
            ScrollView(content: {
                header
                Spacer().frame(height: 50)
                phoneSection
                Spacer().frame(height: 12)
                passwordSection
                rememberMe
                if vm.isLoading {
                    ProgressView()
                } else {

                    CommonButton(
                        text: "signin",
                        destination: EmptyView(),
                        action: {
                            Task {
                                await vm.onLoginTap()
                            }
                        },
                        isNavigation: false
                    )
                }
                orSection
                SocialButton(icon: "google", social: "Google", action: {})
                SocialButton(icon: "apple", social: "Apple", action: {})
                SocialButton(
                    icon: "avatar",
                    social: "Guest",
                    action: {
                        vm.isGuest = true
                    }
                )
                createAccountButton
            })
        }
        .navigationBarBackButtonHidden()
        .overlay(content: {
            if vm.isLoading {
                CommonLoader()
            }
        })
        .fullScreenCover(isPresented: $vm.isGuest) {
            Text("guest")
        }
    }

    //MARK: Components
    var header: some View {
        VStack {
            Image("applogo2")
                .padding(.vertical, 20)
            HStack {
                Text("welcome").font(
                    .custom("Urbanist-SemiBold", size: 28)
                )
                Text("appName").font(
                    .custom("Urbanist-SemiBold", size: 28)
                )
                .foregroundStyle(.accent)
            }
            Text("trustProfessionals")
                .font(.custom("Urbanist-Light", size: 16))

        }
    }

    var phoneSection: some View {
        VStack(alignment: .leading) {
            Text("phoneNumber")
                .font(.custom("Urbanist-Regular", size: 12))
                .foregroundStyle(.gray)

            TextField("enterPhone", text: $vm.phoneField)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .font(.custom("Urbanist-Regular", size: 14))

        }.padding(.horizontal, 20)

    }

    var passwordSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("password")
                .font(.custom("Urbanist-Regular", size: 12))
                .foregroundStyle(.gray)

            HStack {
                if vm.isPasswordVisible {
                    TextField("enterPassword", text: $vm.passwordField)
                        // Optimized
                        .autocapitalization(.none)
                        .font(.custom("Urbanist-Regular", size: 14))
                    autocorrectionDisabled()
                } else {
                    SecureField(
                        LocalizedStringKey("enterPass"),
                        text: $vm.passwordField
                    )
                    .font(.custom("Urbanist-Regular", size: 14))
                    // Optimized
                }

                Button(action: {
                    vm.isPasswordVisible.toggle()
                }) {
                    Image(
                        systemName: vm.isPasswordVisible ? "eye.slash" : "eye"
                    )
                    .foregroundColor(.gray)
                    .font(.system(size: 18, weight: .medium))
                }
            }
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(10)

        }
        .padding(.horizontal, 20)
    }
    var rememberMe: some View {
        HStack {
            HStack {
                Button(action: {
                    vm.isChecked.toggle()
                }) {
                    Image(
                        systemName: vm.isChecked
                            ? "checkmark.square.fill" : "square"
                    )
                    .foregroundColor(vm.isChecked ? .accentColor : .gray)
                    .font(.system(size: 16))

                }
                Text("remeberMe")
                    .font(.custom("Urbanist-Regular", size: 12))
            }
            Spacer()

            NavigationLink("forgetpass") {
                ForgetPasswordView()

            }.font(.custom("Urbanist-Regular", size: 12))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }

    var orSection: some View {
        HStack {
            Divider()
            Text("or")
                .foregroundStyle(.gray)
                .font(.custom("Urbanist-Regular", size: 14))
                .padding(.horizontal, 20)
            Divider()
        }
    }

    var createAccountButton: some View {
        VStack {
            Spacer(minLength: 80)
            NavigationLink("create") {
                SignupView()
            }
            .font(.custom("Urbanist-Bold", size: 14))

        }
    }

}
struct SocialButton: View {
    let icon: String
    let social: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(icon)
                    .imageScale(.medium)
                Text("continue\(social)")
                    .font(.custom("Urbanist-Regular", size: 14))
                    .foregroundStyle(.black)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
