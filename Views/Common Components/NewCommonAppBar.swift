//
//  NewCommonAppBar.swift
//  Himaytek
//
//  Created by Ismaeel on 18/09/2026.
//

import SwiftUI

struct NewCommonAppbar: View {
    @Environment(\.dismiss) var dismiss
    @State var title: String
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            }
            Spacer()
            Text(title)
                .font(.custom("Urbanist-Regular", size: 16))
            Spacer()
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    NewCommonAppbar(title: "Title")
}
