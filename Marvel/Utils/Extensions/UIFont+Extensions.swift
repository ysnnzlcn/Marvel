//
//  UIFont+Extensions.swift
//  Marvel
//
//  Created by Yasin Nazlican on 31.08.2021.
//

import UIKit

public enum PoppinsFontTypes: String {
    
    case Black, Bold, ExtraBold, ExtraLight, Light, Medium, Regular, Semibold, Thin
    
    func font(size: CGFloat) -> UIFont {
        UIFont(name: "Poppins-\(self.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
}

public extension UIFont {
    
    static func poppins(type: PoppinsFontTypes, size: CGFloat) -> UIFont {
        type.font(size: size)
    }
    
    static func boldPoppins(_ size: CGFloat) -> UIFont {
        .poppins(type: .Bold, size: size)
    }
    
    static func regularPoppins(_ size: CGFloat) -> UIFont {
        .poppins(type: .Regular, size: size)
    }
}
