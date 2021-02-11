//
//  AddCategoryView.swift
//  MyCoreData
//
//  Created by Ivan Ruiz Monjo on 10/2/21.
//

import SwiftUI

struct AddCategoryView: View {

    var didAddCategoryCompletion: (Category) -> ()

    @StateObject private var viewModel = AddCategoryViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var categoryTitle = ""
    @State private var selectedImage = 0
    @State private var updatePersistentStore = true
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Category details")) {
                    TextField("Enter category title", text: $categoryTitle)
                    Picker(selection: $selectedImage, label: Text("Category Image")) {
                        ForEach(Array(viewModel.images.enumerated()), id: \.offset) { offset, image in
                            Image(systemName: image)
                        }
                    }
                    HStack {
                        Button(action: { updatePersistentStore.toggle() }) {
                            Image(systemName: updatePersistentStore ? "checkmark" : "xmark")
                        }
                        Text("Update persistent store")
                    }
                }
                Section(header: Text("Existing categories")) {
                    ForEach(viewModel.categories) { category in
                        HStack {
                            Image(systemName: category.imageName ?? "")
                            Text(category.title ?? "")
                        }
                    }.onDelete(perform: viewModel.delete)
                }
            }
            .listStyle(GroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add new category")
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") { presentationMode.wrappedValue.dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let category = viewModel.save(name: categoryTitle, imageIndex: selectedImage, updatePersistentStore: updatePersistentStore)
                        didAddCategoryCompletion(category)
                    }
                }
            }
        }
    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView(didAddCategoryCompletion: { _ in })
    }
}
