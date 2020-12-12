//
//  LocationPicker.swift
//  RakuKobo
//
//  Created by Sachin Kumar Patra on 12/12/20.
//

import SwiftUI
import MapKit

struct LocationPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    typealias UIViewControllerType = UINavigationController
    
    @Binding var location: Location?
    
    func makeUIViewController(context: Context) -> UINavigationController {
        
        let locationPickerVC = LocationPickerViewController()
        locationPickerVC.showCurrentLocationButton = true
        locationPickerVC.useCurrentLocationAsHint = true
        locationPickerVC.mapType = .standard
        
        locationPickerVC.completion = {
            self.location = $0
            self.presentationMode.wrappedValue.dismiss()
        }
        
        let navvc = UINavigationController(rootViewController: locationPickerVC)
        
        let backButtonImage = UIImage(named: "back_white")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.addTarget(context.coordinator, action: #selector(context.coordinator.backAction), for: .touchUpInside)
        locationPickerVC.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        return navvc
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: UIViewControllerRepresentableContext<LocationPicker>) {
    }

    func makeCoordinator() -> LocationPicker.Coordinator {
        Coordinator(locationPicker: self)
    }
  
    class Coordinator {
        var picker: LocationPicker

        init(locationPicker: LocationPicker) {
            self.picker = locationPicker
        }

        @objc func backAction(_ sender: UIButton) {
            picker.presentationMode.wrappedValue.dismiss()
         }
    }
}
