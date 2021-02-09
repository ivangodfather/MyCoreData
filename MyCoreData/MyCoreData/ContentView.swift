//
//  ContentView.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 26/1/21.
//

import SwiftUI

struct ContentView: View {
  @State var data: [ToDo] = []

  var body: some View {
    NavigationView {
      List {
        ForEach(data, id: \.self) { todo in
          NavigationLink(
            destination: ToDoView(todo: todo),
            label: {
              Text(todo.title ?? "")
            })
        }.onDelete(perform: { indexSet in
          StoreManager.shared.deleteTodos(indexSet: indexSet)
          refresh()
        })
      }.listStyle(PlainListStyle())
      .onAppear {
        refresh()
      }
      .navigationBarItems(trailing: Button(action: {
        StoreManager.shared.saveToDo(title: Int.random(in: 1...100).description)
        refresh()
      }, label: {
        Image(systemName: "plus")
      }))
    }
  }

  private func refresh() {
    data = StoreManager.shared.getToDos()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}


