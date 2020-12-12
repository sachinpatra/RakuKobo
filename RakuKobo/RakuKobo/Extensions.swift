//
//  Extensions.swift
//  RakuKobo
//
//  Created by Sachin Kumar Patra on 12/12/20.
//

import SwiftUI
import UIKit

extension UIApplication {

    func visibleViewController() -> UIViewController? {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return nil }
        guard let rootViewController = window.rootViewController else { return nil }
        return UIApplication.getVisibleViewControllerFrom(vc: rootViewController)
    }

    private static func getVisibleViewControllerFrom(vc:UIViewController) -> UIViewController {
        if let navigationController = vc as? UINavigationController,
            let visibleController = navigationController.visibleViewController  {
            return UIApplication.getVisibleViewControllerFrom( vc: visibleController )
        } else if let tabBarController = vc as? UITabBarController,
            let selectedTabController = tabBarController.selectedViewController {
            return UIApplication.getVisibleViewControllerFrom(vc: selectedTabController )
        } else {
            if let presentedViewController = vc.presentedViewController {
                return UIApplication.getVisibleViewControllerFrom(vc: presentedViewController)
            } else {
                return vc
            }
        }
    }
}

extension Double {
  func roundTo(places:Int) -> Double {
    guard self != 0.0 else {
        return 0
    }
    let divisor = pow(10.0, Double(places) - ceil(log10(fabs(self))))
    return (self * divisor).rounded() / divisor
  }
}
