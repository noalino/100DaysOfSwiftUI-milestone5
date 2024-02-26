//
//  ContactDetailsView.swift
//  RememberNames
//
//  Created by Noalino on 26/02/2024.
//

import SwiftUI

struct ContactDetailsView: View {
    var title: String
    var image: Image?

    var body: some View {
        image?
            .resizable()
            .scaledToFit()
            .navigationTitle(title)
    }
}

#Preview {
    ContactDetailsView(title: "John", image: Image(systemName: "person"))
}
