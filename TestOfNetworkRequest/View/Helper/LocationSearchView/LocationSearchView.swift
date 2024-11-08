//
//  LocationSearchView.swift
//  TestOfNetworkRequest
//
//  Created by Orest Palii on 08.11.2024.
//

import SwiftUI
import MapKit

struct LocationSearchView: View {
    @Binding var query: String
    @State private var isLocationSelected: String = ""
    @ObservedObject private var locationSearchService = LocationSearchService()

    var body: some View {
        VStack {
            HStack{
                Image(systemName: "mappin.and.ellipse")
                    .foregroundStyle(Color(uiColor: .tertiaryLabel))
                TextField("Введіть локацію", text: $query)
                    .onChange(of: query) { newValue, oldValue in
                        if newValue != isLocationSelected{
                            isLocationSelected = ""
                        }
                        locationSearchService.updateQuery(newValue)
                        print(locationSearchService.searchResults.count)
                    }
            }
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(45)
            
            if isLocationSelected.isEmpty{
                VStack(alignment: .leading){
                    ForEach(locationSearchService.searchResults.prefix(3), id: \.self) { result in
                        VStack(alignment: .leading) {
                            Text(result.title).font(.headline)
                            Text(result.subtitle).font(.subheadline).foregroundColor(.gray)
                        }
                        .onTapGesture {
                            isLocationSelected = query
                            query = result.title
                            locationSearchService.searchResults.removeAll()
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .listStyle(.plain)
            }
        }
    }
}

class LocationSearchService: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchResults: [MKLocalSearchCompletion] = []
    private let searchCompleter: MKLocalSearchCompleter

    override init() {
        self.searchCompleter = MKLocalSearchCompleter()
        super.init()
        self.searchCompleter.delegate = self
        self.searchCompleter.resultTypes = .address
    }

    func updateQuery(_ query: String) {
        searchCompleter.queryFragment = query
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.searchResults = completer.results
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Помилка пошуку локації: \(error.localizedDescription)")
    }
}

#Preview {
    LocationSearchView(query: .constant(""))
}
