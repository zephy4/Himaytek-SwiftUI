//
//  SelectCarDesign.swift
//  Himaytek
//
//  Created by Ismaeel on 18/09/2026.
//

import SwiftUI

struct SelectCarDesign: View {
    @StateObject var vm = SelectCarDesignViewModel()
    var body: some View {
        VStack {
            NewCommonAppbar(title: "Select Body Shape")
            ScrollView {
                ForEach(vm.designs) { items in
                    HStack {
                        Image(items.icon ?? "")
                            .padding(8)
                            .background(.gray.opacity(0.1))
                            .cornerRadius(10)
                        Text(items.title ?? "")
                            .font(.custom("Urbanist-Regular", size: 14))
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                vm.selectedItem == items
                                    ? Color.accentColor
                                    : Color.gray.opacity(0.1),
                            )
                            .foregroundStyle(.white)

                    )
                    .contentShape(Rectangle())
                    .onTapGesture {
                        vm.selectedItem = items
                    }
                }

            }

        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()

    }
}

#Preview {
    SelectCarDesign()
}
