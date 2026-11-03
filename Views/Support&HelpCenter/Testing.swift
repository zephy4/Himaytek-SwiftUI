import SwiftUI

struct SingleSelectionList: View {
    let items = [
        "Billing & Payment", "Technical Support", "Account Issues",
        "General Inquiry",
    ]
    @State private var selectedItem: String? = nil

    var body: some View {
        VStack(spacing: 12) {
            ForEach(items, id: \.self) { item in
                HStack {
                    Text(item)
                        .font(.custom("Urbanist-Regular", size: 16))
                        .foregroundColor(.primary)

                    Spacer()

                    // Show checkmark icon when selected
                    if selectedItem == item {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(
                            selectedItem == item
                                ? Color.accentColor.opacity(0.1)
                                : Color.gray.opacity(0.1)
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            selectedItem == item
                                ? Color.accentColor : Color.clear,
                            lineWidth: 1.5
                        )
                )
                .contentShape(Rectangle())  // Makes the entire card row tappable
                .onTapGesture {
                    selectedItem = item
                }
            }
        }
        .padding(.horizontal)
    }

}



#Preview {
        SingleSelectionList()
    
}
