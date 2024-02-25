//
//  RememberNamesApp.swift
//  RememberNames
//
//  Created by Noalino on 23/02/2024.
//

import SwiftUI

@main
struct RememberNamesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Contact.self)
    }
}
