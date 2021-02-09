//
//  TodoListViewModel.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 9/2/21.
//

import Foundation
import SwiftUI

final class TodoListViewModel: ObservableObject {

  @Published var todos: [ToDo] = []

  init() {
    refresh()
  }

  func refresh() {
    todos = StoreManager.shared.getToDos()
  }
}
