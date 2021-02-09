//
//  ToDoView.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 27/1/21.
//

import SwiftUI

struct ToDoView: View {
  @State var todo: ToDo

  var titleBinding: Binding<String> {
       Binding<String>(
           get: { return todo.title ?? "" },
           set: { todo.title = $0 })
  }

    var body: some View {
      Form {
        TextField("Title", text: $todo.title.bound)
      }
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
      ToDoView(todo: ToDo(context: StoreManager.shared.container.viewContext))
    }
}
