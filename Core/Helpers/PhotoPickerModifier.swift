import PhotosUI
import SwiftUI

struct PhotoPickerModifier: ViewModifier {
    @Binding var isPresented: Bool
    @Binding var image: UIImage?
    @Binding var selectedItem: PhotosPickerItem?

    func body(content: Content) -> some View {
        content
            .photosPicker(
                isPresented: $isPresented,
                selection: $selectedItem,
                matching: .images
            )
            .onChange(of: selectedItem) { _, newItem in
                guard let newItem else { return }
                Task {
                    image = await PhotoPickerHelper.loadImage(from: newItem)
                }
            }
    }
}

extension View {
    func photoPicker(
        isPresented: Binding<Bool>,
        image: Binding<UIImage?>,
        selectedItem: Binding<PhotosPickerItem?>
    ) -> some View {
        modifier(
            PhotoPickerModifier(
                isPresented: isPresented,
                image: image,
                selectedItem: selectedItem
            )
        )
    }
}
