//
//  Common.swift
//  RakuKobo
//
//  Created by Sachin Kumar Patra on 12/12/20.
//

import Foundation
import SwiftUI

struct DisableModalDismiss: ViewModifier {
    let disabled: Bool
    func body(content: Content) -> some View {
        disableModalDismiss()
        return AnyView(content)
    }

    func disableModalDismiss() {
        guard let visibleController = UIApplication.shared.visibleViewController() else { return }
        visibleController.isModalInPresentation = disabled
    }
}
