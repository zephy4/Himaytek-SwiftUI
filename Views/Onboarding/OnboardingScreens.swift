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
                        topText: "sayhello",
                        bottomText: "worryFree"
                    )
                    onboardingElement(
                        image: "onboarding2",
                        topText: "carService",
                        bottomText: "fingertips"
                    )
                    onboardingElement(
                        image: "onboarding3",
                        topText: "sayLess",
                        bottomText: "all"
                    )

                }.tabViewStyle(.page)

                Spacer()
                CommonButton(
                    text: "signin",
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
            Text(LocalizedStringKey(topText))
                .font(.custom("Urbanist-SemiBold", size: 28))
                .foregroundStyle(.accent)
            Text(LocalizedStringKey(bottomText))
                .font(.custom("Urbanist-SemiBold", size: 26))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
        }

    }
}

#Preview {
    OnboardingScreens()
}
