//
//  ContactDetailsView.swift
//  RememberNames
//
//  Created by Noalino on 26/02/2024.
//

import MapKit
import SwiftUI

struct ContactDetailsView: View {
    var title: String
    var image: Image?
    var coordinate: CLLocationCoordinate2D

    var position: MapCameraPosition {
        MapCameraPosition.region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
            )
        )
    }

    var body: some View {
        VStack {
            Map(initialPosition: position) {
                Annotation(title, coordinate: coordinate) {
                    Image(systemName: "star.circle")
                        .resizable()
                        .foregroundStyle(.red)
                        .frame(width: 44, height: 44)
                        .background(.white)
                        .clipShape(.circle)
                }
            }

            image?
                .resizable()
                .scaledToFit()
                .navigationTitle(title)
        }
    }
}

#Preview {
    ContactDetailsView(title: "John", image: Image(systemName: "person"), coordinate: CLLocationCoordinate2D(latitude: 37, longitude: -122))
}
