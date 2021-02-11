//
//  StoreManager.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 26/1/21.
//

import Foundation
import CoreData

final class StoreManager {

    static let shared = StoreManager()
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "MyCoreData")
        persistentContainer.loadPersistentStores { desc, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = false
    }

    func saveToDo(title: String, category: Category) {
        let todo = ToDo(context: persistentContainer.viewContext)
        todo.title = title
        todo.category = category
        save()
    }

    func getToDos() -> [ToDo] {
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    func deleteTodo(todo: ToDo) {
        persistentContainer.viewContext.delete(todo)
        save()
    }

    func deleteTodos(indexSet: IndexSet) {
        let items = getToDos()
        indexSet.forEach { index in
            let item = items[index]
            deleteTodo(todo:item)
        }
        save()
    }

    func updateToDo() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
    }

    func addCategory(title: String, imageName: String) -> Category {
        let category = Category(context: persistentContainer.viewContext)
        category.title = title
        category.imageName = imageName
        save()
        return category
    }

    func getCategories() -> [Category] {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

    func deleteCategory(category: Category) {
        persistentContainer.viewContext.delete(category)
        save()
    }

    private func save() {
        guard persistentContainer.viewContext.hasChanges else {
            return
        }
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save \(error)")
        }
    }

    func setQueryGeneration() {
        let currentToken = persistentContainer.viewContext.queryGenerationToken
        print(currentToken?.description)
        try! persistentContainer.viewContext.setQueryGenerationFrom(currentToken)
    }

    func setLastQueryGeneration() {
        let currentToken = NSQueryGenerationToken.current
        try! persistentContainer.viewContext.setQueryGenerationFrom(currentToken)
    }



}
