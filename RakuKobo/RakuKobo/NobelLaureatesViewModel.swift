//
//  NobelLaureatesViewModel.swift
//  RakuKobo
//
//  Created by Sachin Kumar Patra on 12/11/20.
//

import Foundation
import Combine
import CoreLocation

class NobelLaureatesViewModel: ObservableObject {
    var nobels = [Nobel]()
    @Published private (set) var filteredList = [Nobel]()
    @Published var selectedYear: String = ""
    @Published var coordi: CLLocationCoordinate2D?
    @Published var lat: Double?
    @Published var lng: Double?
    
    private var disposeBag = Set<AnyCancellable>()

    init() {
        let url = Bundle.main.url(forResource: "nobel-prize-laureates", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        self.nobels = try! JSONDecoder().decode([Nobel].self, from: data)
        self.filteredList = self.nobels
        
        Publishers.CombineLatest3($selectedYear, $lat, $lng)
            .subscribe(on: DispatchQueue.global())
            .map{(year, latti, langi) -> [Nobel] in
                guard !year.isEmpty, let lattitude = latti, let longitude = langi else {
                    return self.nobels
                }
                let result = self.nobels.filter{
                    $0.year == year
                        && Double.equal($0.location.lat, lattitude, precise: 1)
                        && Double.equal($0.location.lng, longitude, precise: 1)
                }
                return result
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { (value) in
                self.filteredList = value
            })
            .store(in: &disposeBag)
    }
}
