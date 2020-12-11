//
//  NobelLaureatesView.swift
//  RakuKobo
//
//  Created by Sachin Kumar Patra on 12/11/20.
//

import SwiftUI
import LocationPicker


struct NobelLaureatesView: View {
    @EnvironmentObject private var viewModel: NobelLaureatesViewModel
    @State var selectedLocation: Location?
    @State var showSearchView: Bool = false

    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List {
                    if showSearchView {
                        Section(header: Text("Find nobel laureates")) {
                            Picker(selection: $viewModel.selectedYear, label: Text("Select awarded year").foregroundColor(.blue)) {
                                ForEach((1900..<2021).map{String($0)}, id: \.self) {
                                    Text($0)
                                }
                            }
                            NavigationLink(destination: LocationPicker(location: $selectedLocation)
                                            .navigationBarHidden(true)
                                            .edgesIgnoringSafeArea(.vertical)) {
                                Text("Select location")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    
                    ForEach(viewModel.filteredList, id: \.id) { nobel in
                        Section {
                            Text(nobel.surname)
                            Text(nobel.firstname)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Nobel Laureates")
                .navigationBarItems(trailing: Button(action: {
                    if let firstNobel = viewModel.filteredList.first {
                        proxy.scrollTo(firstNobel.id)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        showSearchView.toggle()
                    }
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                }))
            }
        }
    }
}

struct NobelLaureatesView_Previews: PreviewProvider {
    static var previews: some View {
        NobelLaureatesView()
    }
}
