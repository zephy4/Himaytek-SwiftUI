import PhotosUI
import _PhotosUI_SwiftUI
import UIKit

enum PhotoPickerHelper {
    static func loadImage(from item: PhotosPickerItem) async -> UIImage? {
        guard let data = try? await item.loadTransferable(type: Data.self) else {
            return nil
        }
        return UIImage(data: data)
    }
}
