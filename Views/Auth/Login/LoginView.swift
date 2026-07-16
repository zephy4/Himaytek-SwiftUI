import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModel()
    @State var isChecked: Bool = false
    @State private var isPasswordVisible: Bool = false
    let placeholder: String = ""
    @State var text: String = ""

    var body: some View {
        NavigationStack {
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
                            text: "Sign in",
                            destination: EmptyView(),
                            action: {
                                vm.onLoginTap()
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
                }).navigationBarBackButtonHidden()
            }
            .fullScreenCover(isPresented: $vm.isGuest) {
                Text("Continue As guest")
            }
        }
    }

    //MARK: Components
    var header: some View {
        VStack {
            Image("applogo2")
                .padding(.vertical, 20)
            HStack {
                Text("Welcome to").font(
                    .custom("Urbanist-SemiBold", size: 28)
                )
                Text("appName").font(
                    .custom("Urbanist-SemiBold", size: 28)
                )
                .foregroundStyle(.accent)
            }
            Text("Protect your car with trusted professionals")
                .font(.custom("Urbanist-Light", size: 16))

        }
    }

    var phoneSection: some View {
        VStack(alignment: .leading) {
            Text("Phone Number")
                .font(.custom("Urbanist-Regular", size: 12))
                .foregroundStyle(.gray)

            TextField("Enter your phone number", text: $vm.phoneField)
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
                .font(.custom("Urbanist-Regular", size: 14))

        }.padding(.horizontal, 20)

    }

    var passwordSection: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Password")
                .font(.custom("Urbanist-Regular", size: 12))
                .foregroundStyle(.gray)

            HStack {
                if isPasswordVisible {
                    TextField("Enter your password", text: $vm.passwordField)
                        // Optimized
                        .autocapitalization(.none)
                        .font(.custom("Urbanist-Regular", size: 14))
                    autocorrectionDisabled()
                } else {
                    SecureField("Enter your password", text: $vm.passwordField)
                        .font(.custom("Urbanist-Regular", size: 14))
                    // Optimized
                }

                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
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
                    isChecked.toggle()
                }) {
                    Image(
                        systemName: isChecked
                            ? "checkmark.square.fill" : "square"
                    )
                    .foregroundColor(isChecked ? .accentColor : .gray)
                    .font(.system(size: 16))

                }
                Text("Remember me")
                    .font(.custom("Urbanist-Regular", size: 12))
            }
            Spacer()

            NavigationLink("Forgot Password?") {
                ForgetPasswordView()

            }.font(.custom("Urbanist-Regular", size: 12))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }

    var orSection: some View {
        HStack {
            Divider()
            Text("Or")
                .foregroundStyle(.gray)
                .font(.custom("Urbanist-Regular", size: 14))
                .padding(.horizontal, 20)
            Divider()
        }
    }

    var createAccountButton: some View {
        VStack {
            Spacer(minLength: 80)
            NavigationLink("Create an Account") {
                SignupView()
            }
            .font(.custom("Urbanist-Bold", size: 14))

        }
    }

}
struct SocialButton: View {
    let icon: String
    let social: String
    var action: () -> Void  // Add an action so the button actually works!

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(icon)
                    .imageScale(.medium)
                Text("Continue with \(social)")
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
    LoginView()
}
