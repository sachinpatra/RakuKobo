//
//  NobelLaureatesViewModel.swift
//  RakuKobo
//
//  Created by Sachin Kumar Patra on 12/11/20.
//

import Foundation
import Combine

class NobelLaureatesViewModel: ObservableObject {
    var nobels = [Nobel]()
    @Published private (set) var filteredList = [Nobel]()
    @Published var selectedYear: String = ""
    @Published var lat: Float?
    @Published var lng: Float?
    
    private var disposeBag = Set<AnyCancellable>()

    init() {
        let url = Bundle.main.url(forResource: "nobel-prize-laureates", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        self.nobels = try! JSONDecoder().decode([Nobel].self, from: data)
        self.filteredList = self.nobels
        
        Publishers.CombineLatest3($selectedYear, $lat, $lng)
            .map{(year, latti, langi) -> [Nobel] in
                guard !year.isEmpty else {
                    return self.nobels
                }
                let result = self.nobels.filter{ $0.year == year }
                return result
            }
            .sink(receiveValue: { (value) in
                self.filteredList = value
            })
            .store(in: &disposeBag)
       
    }
}
