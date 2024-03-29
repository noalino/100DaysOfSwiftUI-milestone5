//
//  ContactsView.swift
//  RememberNames
//
//  Created by Noalino on 25/02/2024.
//

import MapKit
import SwiftData
import SwiftUI

struct ContactsView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Contact.name)]) var contacts: [Contact]

    var body: some View {
        if contacts.isEmpty {
            ContentUnavailableView("No names", systemImage: "photo.badge.plus", description: Text("Tap \"Add a name\" to import a name"))
        } else {
            List(contacts) { contact in
                NavigationLink {
                    ContactDetailsView(title: contact.name, image: contact.image, coordinate: CLLocationCoordinate2D(latitude: contact.latitude, longitude: contact.longitude))
                } label: {
                    HStack {
                        contact.image?
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(.circle)

                        Spacer()

                        Text(contact.name)
                    }
                }
            }
        }
    }
}

#Preview {
    ContactsView()
}
