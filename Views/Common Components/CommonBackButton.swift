import SwiftUI

struct CommonBackButton: View {
    var action: () -> Void
    var body: some View {

        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.1))
                .frame(width: 50, height: 50)
                .overlay {
                    Image(systemName: "chevron.left")
                }
                .shadow(radius: 20)
        }

    }
}

#Preview {
    CommonBackButton(action: {})
}
