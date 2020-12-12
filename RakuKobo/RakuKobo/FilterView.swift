//
//  FilterView.swift
//  RakuKobo
//
//  Created by Sachin Kumar Patra on 12/12/20.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: NobelLaureatesViewModel
    @State var selectedLocation: Location?
    @State var showLatLng: Bool = false

    var body: some View {
        NavigationView {
            List {
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
                if let coordi = viewModel.coordi {
                    HStack {
                        Text("Latitude")
                        Spacer()
                        Text("\(coordi.latitude)")
                    }
                    HStack {
                        Text("Longitude")
                        Spacer()
                        Text("\(coordi.longitude)")
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Find Nobel Laureates", displayMode: .inline)
            .onChange(of: selectedLocation) { (value) in
                viewModel.coordi = value?.coordinate
                
                print((value?.coordinate))
                print( value!.coordinate.latitude.cutOffDecimalsAfter(1))
                print( value!.coordinate.longitude.cutOffDecimalsAfter(1))
            }
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }),trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Apply")
            }).disabled(viewModel.selectedYear.isEmpty
                            && viewModel.coordi == nil)
            )
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
