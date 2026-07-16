import SwiftUI

struct OTPVerifyView: View {
    @StateObject var vm = OTPVerifyViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            ScrollView {
                backButton
                headers
                Spacer(minLength: 40)
                OTPTextFieldView()
                Spacer(minLength: 20)
                CommonButton(
                    text: "Verify",
                    destination: EmptyView(),
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
            Text("OTP Verification")
                .font(.custom("Urbanist-Bold", size: 28))

            Spacer(minLength: 15)
            Text("otp_verification")
                .font(.custom("Urbanist-Regular", size: 16))
        }
    }

    var backButton: some View {
        HStack {
            CommonBackButton(action: { dismiss() })
            Spacer()
        }.padding(.horizontal, 20)
    }

    var footers: some View {
        HStack {
            Text("Didn't received code?").font(
                .custom("Urbanist-Regular", size: 14)
            )
            Button("Resend") {
                dismiss()
            }.font(
                .custom("Urbanist-Bold", size: 14)
            )
        }
    }

    struct OTPTextFieldView: View {
        @State private var otopCode: String = ""
        @FocusState private var isFocused: Bool

        private let codeLength = 4

        var body: some View {
            ZStack {

                TextField("", text: $otopCode)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .focused($isFocused)
                    .frame(width: 1, height: 1)
                    .opacity(0.01)
                    .onChange(of: otopCode) { newValue in

                        if newValue.count > codeLength {
                            otopCode = String(newValue.prefix(codeLength))
                        }
                    }

                HStack(spacing: 16) {
                    ForEach(0..<codeLength, id: \.self) { index in
                        let digit = getDigit(at: index)
                        let isActive = isBoxFocused(at: index)

                        ZStack {

                            RoundedRectangle(cornerRadius: 14)
                                .stroke(
                                    isActive
                                        ? Color.accentColor
                                        : Color.gray.opacity(0.5),
                                    lineWidth: isActive ? 2 : 1
                                )
                                .frame(width: 70, height: 60)

                            Text(digit)
                                .font(.title.bold())
                                .foregroundColor(.primary)
                        }
                        .onTapGesture {
                            isFocused = true
                        }
                    }
                }
            }
            .onAppear {
                isFocused = true
            }
        }

        private func getDigit(at index: Int) -> String {
            guard index < otopCode.count else { return "" }
            let stringIndex = otopCode.index(
                otopCode.startIndex,
                offsetBy: index
            )
            return String(otopCode[stringIndex])
        }

        private func isBoxFocused(at index: Int) -> Bool {
            guard isFocused else { return false }
            return index == otopCode.count
                || (index == codeLength - 1 && otopCode.count == codeLength)
        }
    }

}

#Preview {
    OTPVerifyView()
}
