import Combine
import Foundation
import SwiftUI

class HomeVModel: ObservableObject {

    @Published var searchEditor: String = ""

    var categories: [CategoriesModel] = [
        CategoriesModel(
            id: "1",
            title: "Paint Protection",
            avatar: "protection"
        ),
        CategoriesModel(
            id: "2",
            title: "Car wash",
            avatar: "wash"
        ),
        CategoriesModel(
            id: "3",
            title: "Maintenance",
            avatar: "maintenance"
        ),
        CategoriesModel(
            id: "4",
            title: "Paint Protection",
            avatar: "protection"
        ),
    ]

}
