//
//  ContentView.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 26/1/21.
//

import SwiftUI
import ToastUI

struct TodoListView: View {
    @StateObject var viewModel = TodoListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.todos, id: \.title) { todo in
                    NavigationLink(destination: EditTodoView(todo: todo)) {
                        HStack {
                            Image(systemName: todo.category?.imageName ?? "")
                            Text((todo.title ?? "").capitalized)
                        }
                    }
                }.onDelete(perform: viewModel.delete)
            }
            .toolbar { MyToolBarContent(viewModel: viewModel) }
        }
        .onAppear(perform: viewModel.refresh)

    }

    struct MyToolBarContent: ToolbarContent {
        let viewModel: TodoListViewModel

        var body: some ToolbarContent {
            ToolbarItem(placement: .principal) {
                Text("To do list")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: viewModel.refresh) {
                    Image(systemName: "clock.arrow.2.circlepath")
                }
            }
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: viewModel.addRandom) {
                    Image(systemName: "folder.badge.questionmark")
                }
                NavigationLink(destination: AddTodoView()) {
                    Image(systemName: "plus.rectangle.on.rectangle")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}


