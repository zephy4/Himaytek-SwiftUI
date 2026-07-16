import SwiftUI

struct ForgetPasswordView: View {
    @StateObject var vm = ForgetPasswordViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            ScrollView {
                backButton
                headers
                Spacer(minLength: 40)
                phoneSection
                Spacer(minLength: 20)
                CommonButton(
                    text: "Send Code",
                    destination: OTPVerifyView(),
                    isNavigation: true
                )
            }
            footers
        }
        .navigationBarBackButtonHidden()
    }

    //MARK: Components

    var headers: some View {
        VStack(alignment: .leading) {
            Text("Forgot Password?")
                .font(.custom("Urbanist-Bold", size: 28))

            Spacer(minLength: 15)
            Text("dontworry_forget")
                .font(.custom("Urbanist-Regular", size: 16))
        }
    }

    var backButton: some View {
        HStack {
            CommonBackButton(action: { dismiss() })
            Spacer()
        }.padding(.horizontal, 20)
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
                .keyboardType(.numberPad)
                .font(.custom("Urbanist-Regular", size: 14))

        }.padding(.horizontal, 20)
    }
    var footers: some View {
        HStack {
            Text("Remember Password?").font(
                .custom("Urbanist-Regular", size: 14)
            )
            Button("Login") {
                dismiss()
            }.font(
                .custom("Urbanist-Regular", size: 14)
            )
        }
    }
}

#Preview {
    ForgetPasswordView()
}

/*
 i am attaching a reference picture from pinterest and the actual pictures of the product.
 I want you to make a new  image using the products actual images and the reference image of the pinterest and generate a full final product image

 remember to avoid Hallucinations. Do not over HDR the pictures. keep original tone and lightning.
 Do not guess details. Only include exactly these elements

 */
