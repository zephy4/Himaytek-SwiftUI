import SwiftUI

struct OTPVerifyView: View {
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
                CommonButton(text: "Send Code") {
                }
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
