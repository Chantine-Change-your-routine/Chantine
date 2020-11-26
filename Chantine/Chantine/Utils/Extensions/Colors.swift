//
//  Colors.swift
//  Chantine
//
//  Created by Pedro Sousa on 23/11/20.
//

import UIKit

extension UIColor {
    static let actionColor = UIColor(red: 0.88, green: 0.55, blue: 0.14, alpha: 1.00)
    static let primaryColor = UIColor(red: 1.00, green: 0.98, blue: 0.89, alpha: 1.00)
    static let blackColor = UIColor(red: 0.20, green: 0.18, blue: 0.17, alpha: 1.00)
    static let blueLightColor = UIColor(red: 0.82, green: 0.98, blue: 1.00, alpha: 1.00)
    static let blueCheckColor = UIColor(red: 0.22, green: 0.86, blue: 0.88, alpha: 1.00)
    static let blueDarkColor = UIColor(red: 0.38, green: 0.68, blue: 0.72, alpha: 1.00)
    static let yellowLightColor =  UIColor(red: 0.99, green: 0.95, blue: 0.79, alpha: 1.00)
    static let yellowDarkColor = UIColor(red: 1.00, green: 0.83, blue: 0.00, alpha: 1.00)
    static let greenLightColor = UIColor(red: 0.90, green: 0.99, blue: 0.86, alpha: 1.00)
    static let greenDarkColor = UIColor(red: 0.38, green: 0.72, blue: 0.47, alpha: 1.00)
    static let lavenderLightColor = UIColor(red: 0.89, green: 0.93, blue: 0.96, alpha: 1.00)
    static let lavenderDarkColor = UIColor(red: 0.67, green: 0.78, blue: 0.89, alpha: 1.00)
    
    public convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        var rgbValue: UInt64 = 0

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
        return
    }
}
