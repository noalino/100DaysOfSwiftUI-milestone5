//
//  ContentView.swift
//  RememberNames
//
//  Created by Noalino on 23/02/2024.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ImageWithName: Identifiable {
    let id = UUID()
    let name: String
    let image: Image
}

struct ContentView: View {
    @State private var items: [ImageWithName] = []
    @State private var selectedItem: PhotosPickerItem?

    @ViewBuilder
    var ListView: some View {
        if items.isEmpty {
            ContentUnavailableView("No names", systemImage: "photo.badge.plus", description: Text("Tap \"Add a name\" to import a name"))
        } else {
            List(items) { item in
                HStack {
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
                    .onChange(of: selectedItem, addImage)
            }
            .navigationTitle("RememberNames")
        }
    }

    func addImage() {
        Task {
            guard let image = try await selectedItem?.loadTransferable(type: Image.self) else { return }
            items.append(ImageWithName(name: "test", image: image))
        }
    }
}

#Preview {
    ContentView()
}
