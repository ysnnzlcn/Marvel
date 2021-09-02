//
//  NSAttributedString+Extensions.swift
//  Marvel
//
//  Created by Yasin Nazlican on 01.09.2021.
//

import UIKit

public extension String {
    
    func attributed(
        color: UIColor = .textColor,
        font: UIFont
    ) -> NSAttributedString {
        NSAttributedString(string: self, attributes: [
            .foregroundColor: color,
            .font: font
        ])
    }
}
