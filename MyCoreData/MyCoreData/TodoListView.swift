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
                }.onDelete(perform: viewModel.delete)
            }
            .navigationBarTitle("To do list")
            .listStyle(GroupedListStyle())
            .navigationBarItems(leading: leadingNavigationItems,
                                trailing: trailingNavigationItems)
        }.onAppear(perform: viewModel.refresh)
    }

    var trailingNavigationItems: some View {
        HStack {
            Button(action: viewModel.refresh) {
                Image(systemName: "clock.arrow.2.circlepath")
            }
        }
    }

    var leadingNavigationItems: some View {
        Button(action: viewModel.addRandom) {
            Image(systemName: "folder.badge.questionmark")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}


