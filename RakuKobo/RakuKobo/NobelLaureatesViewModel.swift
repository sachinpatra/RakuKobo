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
    
    private var disposeBag = Set<AnyCancellable>()

    init() {
        let url = Bundle.main.url(forResource: "nobel-prize-laureates", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        self.nobels = try! JSONDecoder().decode([Nobel].self, from: data)
        self.filteredList = self.nobels
        
        Publishers.CombineLatest($selectedYear, $coordi)
            .subscribe(on: DispatchQueue.global())
            .map{(year, coordinate) -> [Nobel] in
                guard !year.isEmpty, let cordi = coordinate else {
                    return self.nobels
                }
                let result = self.nobels.filter{
                    $0.year == year
                        && Double.equal($0.location.lat, cordi.latitude, precise: 1)
                        && Double.equal($0.location.lng, cordi.longitude, precise: 1)
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
