//
//  LocationMapView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 08.11.2024.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    @State private var coordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        @State private var errorMessage: String?
        let query: String
    
    var body: some View {
        VStack {
            if errorMessage == nil {
                Map(coordinateRegion: $coordinateRegion)
                    .onAppear {
                        searchLocation(query: query)
                    }
            }
        }
    }
    
    private func searchLocation(query: String) {
            let searchRequest = MKLocalSearch.Request()
            searchRequest.naturalLanguageQuery = query
            
            let search = MKLocalSearch(request: searchRequest)
            search.start { response, error in
                if let coordinate = response?.mapItems.first?.placemark.coordinate {
                    DispatchQueue.main.async {
                        coordinateRegion.center = coordinate
                    }
                } else if let error = error {
                    DispatchQueue.main.async {
                        errorMessage = "Помилка пошуку локації: \(error.localizedDescription)"
                    }
                } else {
                    DispatchQueue.main.async {
                        errorMessage = "Локація не знайдена"
                    }
                }
            }
        }
}

