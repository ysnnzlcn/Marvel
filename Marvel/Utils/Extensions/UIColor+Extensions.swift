//
//  UIColor+Extensions.swift
//  Marvel
//
//  Created by Yasin Nazlican on 31.08.2021.
//

import UIKit

public extension UIColor {

    // MARK: Private Static Predefined Colors
    
    private static let azure = UIColor(red: 42 / 255, green: 207 / 255, blue: 207 / 255, alpha: 1)
    private static let darkPurple = UIColor(red: 59 / 255, green: 48 / 255, blue: 84 / 255, alpha: 1)
    private static let redOrange = UIColor(red: 244 / 255, green: 98 / 255, blue: 98 / 255, alpha: 1)
    private static let veryDarkGrey = UIColor(red: 53 / 255, green: 50 / 255, blue: 62 / 255, alpha: 1)
    private static let veryLightGrey = UIColor(red: 229 / 255, green: 229 / 255, blue: 229 / 255, alpha: 1)
    private static let mildGrey = UIColor(red: 191 / 255, green: 191 / 255, blue: 191 / 255, alpha: 1)
    
    // MARK: Public Predefined Colors
    
    static let primary = UIColor.azure
    static let secondary = UIColor.darkPurple
    static let errorColor = UIColor.redOrange
    static let textColor = UIColor.veryDarkGrey
    static let backgroundColor = UIColor.veryLightGrey
    static let placeholderColor = UIColor.mildGrey
}
