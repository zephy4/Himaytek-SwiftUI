import SwiftUI

struct OnboardingScreens: View {
    @State var showLogin: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 20)
                Image("applogo")
                Spacer()
                TabView {
                    onboardingElement(
                        image: "onboarding1",
                        topText: "Say Hello",
                        bottomText: "to worry-free \n car maintenance!"
                    )
                    onboardingElement(
                        image: "onboarding2",
                        topText: "Car Service?",
                        bottomText: "at your fingertips!"
                    )
                    onboardingElement(
                        image: "onboarding3",
                        topText: "Say less",
                        bottomText: "we have it all\nservices!"
                    )

                }.tabViewStyle(.page)

                Spacer()
                CommonButton(
                    text: "Sign in",
                    destination: EmptyView(),
                    action: {
                        showLogin = true
                    },
                    isNavigation: false
                )

            }.navigationDestination(isPresented: $showLogin) {
                LoginView()

            }
        }
    }
}

struct onboardingElement: View {
    @State var image: String
    @State var topText: String
    @State var bottomText: String
    var body: some View {
        VStack {
            Image(image)
            Text(topText)
                .font(.custom("Urbanist-SemiBold", size: 28))
                .foregroundStyle(.accent)
            Text(bottomText)
                .font(.custom("Urbanist-SemiBold", size: 26))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
        }

    }
}

#Preview {
    OnboardingScreens()
}
