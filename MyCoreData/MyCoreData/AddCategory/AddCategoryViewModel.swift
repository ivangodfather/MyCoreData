//
//  AddCategoryViewModel.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 10/2/21.
//

import Foundation

final class AddCategoryViewModel: ObservableObject {
    let images = ["hammer.fill", "house.fill", "desktopcomputer", "cart.fill", "photo", "wand.and.rays", "slider.horizontal.3"]
    @Published var categories = [Category]()

    init() {
        categories = StoreManager.shared.getCategories()
    }

    func save(name: String, imageIndex: Int) -> Category {
        let imageName = images[imageIndex]
        return StoreManager.shared.addCategory(title: name, imageName: imageName)
    }

    func delete(indexSet: IndexSet) {
        indexSet.forEach { index in
            StoreManager.shared.deleteCategory(category: categories[index])
        }
        categories = StoreManager.shared.getCategories()
    }
}
