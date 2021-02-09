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
    self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true

  }

  func saveToDo(title: String) {
    let todo = ToDo(context: persistentContainer.viewContext)
    todo.title = title
    do {
      try persistentContainer.viewContext.save()
    } catch {
      print("Failed to save \(error)")
    }
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
    do {
      try persistentContainer.viewContext.save()
    } catch {
      print(error.localizedDescription)
    }
  }

  func deleteTodos(indexSet: IndexSet) {
    let items = getToDos()
    indexSet.forEach { index in
      let item = items[index]
      deleteTodo(todo:item)
    }
  }

  func updateToDo() {
    do {
      try persistentContainer.viewContext.save()
    } catch {
      persistentContainer.viewContext.rollback()
    }
  }
}
