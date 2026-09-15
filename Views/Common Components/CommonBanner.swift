//
//  CommonBanner.swift
//  Himaytek
//
//  Created by Ismaeel on 28/08/2026.
//

import SwiftUI

struct CommonBanner: View {
    @State var isError: Bool = false
    @State var message: String = "This is an error"
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .frame(width: .infinity, height: 60)
            .foregroundStyle(isError ? .red : .green)
            .shadow(radius: 20)
            .padding()
            .offset(y: message.isEmpty == false ? 328 : 0000)
            .overlay {
                HStack(alignment: .center) {
                    Spacer().frame(width: 40)
                    Image(

                        systemName:
                            isError
                            ? "exclamationmark.transmission" : "checkmark.seal"
                    ).foregroundStyle(.white)
                        .font(.custom("Urbanist-Bold", size: 16))
                    Spacer().frame(width: 10)
                    Text(message ?? "")
                        .font(.custom("Urbanist-Bold", size: 16))
                        .foregroundStyle(.white)
                    Spacer()
                }.offset(
                    y: message.isEmpty == false ? 328 : 5000
                )

            }
            .animation(
                .default,
                value: message.isEmpty == false
            )
    }
}

#Preview {
    CommonBanner()
}
