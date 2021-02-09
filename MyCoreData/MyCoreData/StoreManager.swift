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
  let container: NSPersistentContainer

  init() {
    container = NSPersistentContainer(name: "MyCoreData")
    container.loadPersistentStores { desc, error in
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }

  func saveToDo(title: String) {
    let todo = ToDo(context: container.viewContext)
    todo.title = title
    do {
      try container.viewContext.save()
    } catch {
      print("Failed to save \(error)")
    }
  }

  func getToDos() -> [ToDo] {
    let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
    do {
      return try container.viewContext.fetch(fetchRequest)
    } catch {
      print(error.localizedDescription)
    }
    return []
  }

  func deleteTodo(todo: ToDo) {
    container.viewContext.delete(todo)
    do {
      try container.viewContext.save()
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
      try container.viewContext.save()
    } catch {
      container.viewContext.rollback()
    }
  }
}
