//
//  TodoListViewModel.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 9/2/21.
//

import Foundation
import SwiftUI
import CoreData

final class TodoListViewModel: ObservableObject {

    @Published var todos: [ToDo] = []

    init() {
        refresh()
        let notificationName = NSManagedObjectContext.didSaveObjectsNotification
        NotificationCenter.default.addObserver(self, selector: #selector(contextDidSave(_:)), name: notificationName, object: StoreManager.shared.persistentContainer.viewContext)
    }

    func refresh() {
        todos = StoreManager.shared.getToDos()
    }

    func delete(indexSet: IndexSet) {
        StoreManager.shared.deleteTodos(indexSet: indexSet)
    }

    func addRandom() {
        let tasks = ["dog", "cat", "friend", "house", "street"]
        let verbs = ["clean", "pet", "play", "buy", "run"]
        let title = verbs.randomElement()! + " " + tasks.randomElement()!
        guard let category = StoreManager.shared.getCategories().randomElement() else {
            return
        }
        StoreManager.shared.saveToDo(title: title, category: category)
    }

    @objc private func contextDidSave(_ notification: Notification) {
        refresh()
        let keys: [NSManagedObjectContext.NotificationKey] = [.deletedObjects, .insertedObjects,  .updatedObjects]
        keys.forEach { key in
            let objects = notification.userInfo?[key.rawValue] as? Set<ToDo>
            objects?.forEach {
                print(key.rawValue + " " + ($0.title ?? ""))
            }
        }
    }
}
