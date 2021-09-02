//
//  UITableViewCell+Extensions.swift
//  Marvel
//
//  Created by Yasin Nazlican on 01.09.2021.
//

import UIKit

protocol Reusable: class {
    
    static var reuseIdentifier: String { get }
}

extension Reusable {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}

protocol NibLoadableView {
    
    static var nibName: String { get }
}

extension NibLoadableView  {
    
    static var nibName: String {
        String(describing: self)
    }
}

extension UITableViewCell: NibLoadableView {}
