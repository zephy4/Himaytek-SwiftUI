//
//  SelectCarDesignViewModel.swift
//  Himaytek
//
//  Created by Ismaeel on 18/09/2026.
//

import Combine
import SwiftUI

class SelectCarDesignViewModel: ObservableObject {

    @Published var designs: [SelectCarDesignModel] = [
        SelectCarDesignModel(title: "Coupe", icon: "car"),
        SelectCarDesignModel(title: "Sedan", icon: "car"),
        SelectCarDesignModel(title: "SUV (5 seats)", icon: "suv-car"),
        SelectCarDesignModel(title: "SUV (7 seats)", icon: "suv-car"),
    ]
    
    @Published var selectedItem: SelectCarDesignModel? = nil
}
