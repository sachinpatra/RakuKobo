//
//  NobelLaureatesView.swift
//  RakuKobo
//
//  Created by Sachin Kumar Patra on 12/11/20.
//

import SwiftUI


struct NobelLaureatesView: View {
    @EnvironmentObject private var viewModel: NobelLaureatesViewModel
    @State var showFilterView: Bool = false

    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List {
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
                        showFilterView.toggle()
                    }
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                }))
                .sheet(isPresented: $showFilterView) {
                    FilterView().environmentObject(viewModel)
                }
            }
        }
    }
}

struct NobelLaureatesView_Previews: PreviewProvider {
    static var previews: some View {
        NobelLaureatesView()
    }
}
