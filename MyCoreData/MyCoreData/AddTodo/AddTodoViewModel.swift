//
//  AddTodoViewModel.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 10/2/21.
//

import Foundation

final class AddTodoViewModel: ObservableObject {

    @Published var categories = [Category]()

    init() {
        refresh()
    }

    func refresh() {
        categories = StoreManager.shared.getCategories()
    }

    func save(categoryIndex: Int, description: String) {
        let category = categories[categoryIndex]
        StoreManager.shared.saveToDo(title: description, category: category)
    }
}
