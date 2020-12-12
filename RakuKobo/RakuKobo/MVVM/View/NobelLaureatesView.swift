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
            ZStack {
                if viewModel.filteredList.isEmpty {
                    Text("No Results Found")
                        .font(.headline)
                        .foregroundColor(.red)
                } else {
                    Form {
                        ForEach(Array(viewModel.filteredList.keys), id: \.self) { key in
                            DisclosureGroup {
                                ForEach(viewModel.filteredList[key] ?? [], id: \.id) { nobel in
                                    VStack {
                                        HStack {
                                            Text("Name:")
                                            Spacer()
                                            Text(nobel.name)
                                        }
                                        HStack {
                                            Text("Firstname:")
                                            Spacer()
                                            Text(nobel.firstname)
                                        }
                                        HStack {
                                            Text("Surname:")
                                            Spacer()
                                            Text(nobel.surname)
                                        }
                                        HStack {
                                            Text("Gender:")
                                            Spacer()
                                            Text(nobel.gender)
                                        }
                                        Group {
                                        HStack {
                                            Text("City:")
                                            Spacer()
                                            Text(nobel.city)
                                        }
                                        HStack {
                                            Text("Year:")
                                            Spacer()
                                            Text(nobel.year)
                                        }

                                        HStack {
                                            Text("Born:")
                                            Spacer()
                                            Text(nobel.born)
                                        }
                                        HStack {
                                            Text("Died:")
                                            Spacer()
                                            Text(nobel.died)
                                        }

                                        HStack {
                                            Text("Latitude:")
                                            Spacer()
                                            Text("\(nobel.location.lat)")
                                        }
                                        HStack {
                                            Text("Longitude:")
                                            Spacer()
                                            Text("\(nobel.location.lng)")
                                        }
                                        }
                                    }
                                    .shadow(radius: 1)
                                }
                            }
                            label: {
                                Text(key)
                                    .foregroundColor(.sectionHeaderBackground)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Nobel Laureates")
            .navigationBarItems(leading: Button(action: {
                viewModel.selectedYear = ""
                viewModel.coordi = nil
            }, label: {
                Text("Clear Filter")
            }), trailing: Button(action: {
                showFilterView.toggle()
            }, label: {
                Text("Filter")
            }))
            .sheet(isPresented: $showFilterView) {
                FilterView()
                    .environmentObject(viewModel)
                    .modifier(DisableModalDismiss(disabled: true))
            }
        }
    }
}

struct NobelLaureatesView_Previews: PreviewProvider {
    static var previews: some View {
        NobelLaureatesView()
    }
}
