//
//  ToDoView.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 27/1/21.
//

import SwiftUI

struct EditTodoView: View {
  @State var todo: ToDo
  @State var todoTitle: String = ""
  @Environment(\.presentationMode) var presentationMode

  var titleBinding: Binding<String> {
       Binding<String>(
           get: { todoTitle },
           set: { todoTitle = $0 })
  }

    var body: some View {
      Form {
        TextField("Title", text: titleBinding)
        Button("Save") {
          StoreManager.shared.persistentContainer.performBackgroundTask { context in
            do {
             let item = try? context.existingObject(with: todo.objectID) as? ToDo
              item?.title = todoTitle
            } catch {

            }
            do {
              try context.save()
              DispatchQueue.main.async {
                presentationMode.wrappedValue.dismiss()
              }
            } catch {
              print(error)
            }
          }
        }
      }
      .onAppear {
        todoTitle = todo.title ?? ""
      }.navigationTitle("Edit ToDo")
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
