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
                if let lat = viewModel.lat, let lng = viewModel.lng {
                    HStack {
                        Text("Latitude")
                        Spacer()
                        Text("\(lat)")
                    }
                    HStack {
                        Text("Longitude")
                        Spacer()
                        Text("\(lng)")
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Find Nobel Laureates", displayMode: .inline)
            .onChange(of: selectedLocation) { (value) in
                viewModel.lat = value?.coordinate.latitude
                viewModel.lng = value?.coordinate.longitude
                
                print((value?.coordinate.latitude))
                print(value?.coordinate.longitude)
                print( abs((value?.coordinate.latitude)!))
                print( abs((value?.coordinate.longitude)!))

            }
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }),trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Apply")
            }))
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
