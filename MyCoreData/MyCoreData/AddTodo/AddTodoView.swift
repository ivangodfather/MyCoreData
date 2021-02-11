//
//  AddTodoView.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 10/2/21.
//

import SwiftUI

struct AddTodoView: View {
    @State private var description = ""
    @State private var showAddCategory = false
    @StateObject private var viewModel = AddTodoViewModel()
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedCategory = 0

    var body: some View {
        List {
            Section(header: Text("Category"), footer: Button("Create new category") { showAddCategory.toggle() }) {
                Picker(selection: $selectedCategory, label: Text("Select a category")) {
                    ForEach(Array(viewModel.categories.enumerated()), id: \.offset) { offset, category in
                        HStack {
                            Image(systemName: category.imageName ?? "")
                            Text(category.title ?? "")
                        }.tag(offset)
                    }
                }
            }

            Section(header: Text("Details")) {
                TextField("Enter description", text: $description)
            }
            Section(header: Text("Other")) {
                Button(action: {
                    StoreManager.shared.setLastQueryGeneration()
                    viewModel.refresh()
                }) {
                    Text("Refresh store")
                }
            }
        }
        .sheet(isPresented: $showAddCategory, onDismiss: {}) {
            AddCategoryView(didAddCategoryCompletion: { category in
                showAddCategory = false
                viewModel.refresh()
                selectedCategory = viewModel.categories.firstIndex { $0 == category } ?? 0
            })
        }
        .listStyle(GroupedListStyle())
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Add to do")
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        viewModel.save(categoryIndex: selectedCategory, description: description)

                }) {
                    Text("Save").bold()
                }
            }
        }

    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
