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
    static func equal(_ lhs: Double, _ rhs: Double, precise value: Int? = nil) -> Bool {
        guard let value = value else {
            return lhs == rhs
        }
        
        return lhs.cutOffDecimalsAfter(value) == rhs.cutOffDecimalsAfter(value)
    }
    
    func precised(_ value: Int = 1) -> Double {
        let offset = pow(10, Double(value))
        return (self * offset).rounded() / offset
    }
    
    func cutOffDecimalsAfter(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self*divisor).rounded(.towardZero) / divisor
    }
}

extension Color {
    
    public static var sectionHeaderBackground: Color {
        Color("SectionHeaderBackground")
    }
    
    public static var sectionHeaderText: Color {
        Color("SectionHeaderText")
    }
    
    public static var invisible: Color {
        Color("Invisible")
    }
}
