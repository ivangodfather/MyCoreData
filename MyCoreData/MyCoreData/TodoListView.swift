//
//  ContentView.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 26/1/21.
//

import SwiftUI

struct TodoListView: View {
  @StateObject var viewModel = TodoListViewModel()

  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.todos, id: \.title) { todo in
          NavigationLink(
            destination: EditTodoView(todo: todo),
            label: {
              Text(todo.title ?? "")
            })
        }.onDelete(perform: { indexSet in
          StoreManager.shared.deleteTodos(indexSet: indexSet)
          viewModel.refresh()
        })
      }.listStyle(PlainListStyle())
      .navigationBarItems(trailing:
                            HStack {
                              Button(action: {
                                StoreManager.shared.saveToDo(title: Int.random(in: 1...100).description)
                                viewModel.refresh()
                              }, label: {
                                Image(systemName: "plus")
                              })
                              Button(action: viewModel.refresh) {
                                Image(systemName: "lasso")
                              }
                            })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    TodoListView()
  }
}


