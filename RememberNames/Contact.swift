//
//  Person.swift
//  RememberNames
//
//  Created by Noalino on 25/02/2024.
//

import SwiftData
import SwiftUI

@Model
class Contact {
    var name: String
    @Attribute(.externalStorage) var photo: Data

    var image: Image? {
        guard let uiImage = UIImage(data: photo) else { return nil }
        return Image(uiImage: uiImage)
    }

    init(name: String, photo: Data) {
        self.name = name
        self.photo = photo
    }
}
