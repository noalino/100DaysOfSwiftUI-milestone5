//
//  Person.swift
//  RememberNames
//
//  Created by Noalino on 25/02/2024.
//

import MapKit
import SwiftData
import SwiftUI

@Model
class Contact {
    var name: String
    @Attribute(.externalStorage) var photo: Data
    var latitude: Double
    var longitude: Double

    var image: Image? {
        guard let uiImage = UIImage(data: photo) else { return nil }
        return Image(uiImage: uiImage)
    }

    init(name: String, photo: Data, latitude: Double, longitude: Double) {
        self.name = name
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
    }
}
