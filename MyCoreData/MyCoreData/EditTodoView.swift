//
//  ToDoView.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 27/1/21.
//

import SwiftUI
import CoreData

struct EditTodoView: View {

  var titleBinding: Binding<String> {
       Binding<String>(
        get: { item.title ?? "" },
        set: { item.title = $0 })
  }

  @Environment(\.presentationMode) var presentationMode
  let parentContext: NSManagedObjectContext
  let item: ToDo
  let context: NSManagedObjectContext

  init(todo: ToDo) {
    parentContext = todo.managedObjectContext!
    let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    childContext.parent = parentContext
    item = try! childContext.existingObject(with: todo.objectID) as! ToDo
    context = childContext
  }

    var body: some View {
      Form {
        TextField("Title", text: titleBinding)
        Button("Save") {
          defer {
            presentationMode.wrappedValue.dismiss()
          }
          guard context.hasChanges else {
            return
          }
          do {
            try context.save()
            try parentContext.save()
          } catch {
            print("err")
            return
          }
        }
      }
      .navigationTitle("Edit ToDo")
    }
}

extension Optional where Wrapped == String {
    private var _bound: String? {
        get {
            self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}

struct ToDoView_Previews: PreviewProvider {
    static var previews: some View {
      EditTodoView(todo: ToDo(context: StoreManager.shared.persistentContainer.viewContext))
    }
}
