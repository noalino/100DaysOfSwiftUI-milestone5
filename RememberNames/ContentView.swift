//
//  ContentView.swift
//  RememberNames
//
//  Created by Noalino on 23/02/2024.
//

import PhotosUI
import SwiftUI

struct ImageWithName: Identifiable {
    let id = UUID()
    let name: String
    let image: Image
}

struct ContentView: View {
    @State private var items: [ImageWithName] = []
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedItemName: String = ""
    @State private var showDialog = false

    @ViewBuilder
    var ListView: some View {
        if items.isEmpty {
            ContentUnavailableView("No names", systemImage: "photo.badge.plus", description: Text("Tap \"Add a name\" to import a name"))
        } else {
            List(items) { item in
                HStack(spacing: 6) {
                    item.image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(.circle)

                    Spacer()

                    Text(item.name)
                }
            }
        }
    }

    var body: some View {
        NavigationStack {
            ListView
                .toolbar {
                    PhotosPicker("Add a name", selection: $selectedItem)
                        .onChange(of: selectedItem) {
                            guard let selectedItem else { return }
                            // Delay to make sure picker is dismissed
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showDialog = true
                            }
                        }
                }
                .navigationTitle("RememberNames")
                .alert("Enter a name", isPresented: $showDialog) {
                    TextField("Enter a name", text: $selectedItemName)
                    Button("Save") { saveItem() }
                    Button("Cancel", role: .cancel) { }
                }
        }
    }

    func saveItem() {
        Task {
            guard let image = try await selectedItem?.loadTransferable(type: Image.self) else { return }

            items.append(ImageWithName(name: selectedItemName, image: image))

            cleanSelection()
        }
    }

    func cleanSelection() {
        selectedItem = nil
        selectedItemName = ""
    }
}

#Preview {
    ContentView()
}
