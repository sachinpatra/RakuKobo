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
    @Published var lat: Double = 0.0
    @Published var lng: Double = 0.0
    
    var searchSubject = CurrentValueSubject<String, Never>("")
    private var disposeBag = Set<AnyCancellable>()

    init() {
        let url = Bundle.main.url(forResource: "nobel-prize-laureates", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        self.nobels = try! JSONDecoder().decode([Nobel].self, from: data)
        
        searchSubject
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { (value) in
                if value.isEmpty {
                    self.filteredList = self.nobels
                } else {
                    self.filteredList = self.nobels.filter{ $0.name.contains(value) }
                }
            })
            .store(in: &disposeBag)
    }
}
