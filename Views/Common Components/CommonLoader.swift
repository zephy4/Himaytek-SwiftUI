//
//  CommonLoader.swift
//  Himaytek
//
//  Created by Ismaeel on 28/08/2026.
//

import SwiftUI

struct CommonLoader: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 14)
            .frame(width: 200, height: 120)
            .foregroundStyle(.black.opacity(0.8))
            .overlay {
                VStack {
                    ProgressView()
                        .colorInvert()
                    Text("Loading...")
                        .foregroundStyle(.white)
                        .font(.custom("Urbanist-Regular", size: 18))
                }
            }
    }
}

#Preview {
    CommonLoader()
}
