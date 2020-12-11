//
//  RakuKoboApp.swift
//  RakuKobo
//
//  Created by Sachin Kumar Patra on 12/11/20.
//

import SwiftUI

@main
struct RakuKoboApp: App {
    @StateObject private var viewModel = NobelLaureatesViewModel()

    var body: some Scene {
        WindowGroup {
            NobelLaureatesView()
                .environmentObject(viewModel)
        }
    }
}
