//
//  ContentView.swift
//  RememberNames
//
//  Created by Noalino on 23/02/2024.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    @State private var selectedImage: PhotosPickerItem?
    @State private var name: String = ""
    @State private var showDialog = false

    let locationFetcher = LocationFetcher()

    var body: some View {
        NavigationStack {
            ContactsView()
                .toolbar {
                    PhotosPicker("Add a name", selection: $selectedImage)
                        .onChange(of: selectedImage) {
                            guard selectedImage != nil else { return }
                            locationFetcher.start()
                            // Delay to make sure picker is dismissed
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showDialog = true
                            }
                        }
                }
                .navigationTitle("RememberNames")
                .alert("Enter a name", isPresented: $showDialog) {
                    TextField("Enter a name", text: $name)
                    Button("Save") { saveItem() }
                    Button("Cancel", role: .cancel) { }
                }
        }
    }

    func saveItem() {
        Task {
            guard let imageData = try await selectedImage?.loadTransferable(type: Data.self) else { return }

            guard let location = locationFetcher.lastKnownLocation else {
                print("Unknown location")
                return
            }

            modelContext.insert(Contact(name: name, photo: imageData, latitude: location.latitude, longitude: location.longitude))

            cleanSelection()
        }
    }

    func cleanSelection() {
        selectedImage = nil
        name = ""
    }
}

#Preview {
    ContentView()
}
