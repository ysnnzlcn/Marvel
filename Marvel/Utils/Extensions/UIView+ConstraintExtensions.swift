//
//  UIView+ConstraintExtensions.swift
//  Marvel
//
//  Created by Yasin Nazlican on 01.09.2021.
//

import UIKit

public typealias YAnchorAndConstant = (yAnchor: NSLayoutYAxisAnchor, constant: CGFloat)
public typealias XAnchorAndConstant = (xAnchor: NSLayoutXAxisAnchor, constant: CGFloat)
public typealias DimensionAndMultiplier = (dimension: NSLayoutDimension, multiplier: CGFloat)
public typealias DimensionAndMultiplierOrConstant = (dAndM: DimensionAndMultiplier?, constant: CGFloat?)
public typealias CenterAxisParameters = (view: UIView, attributes: NSLayoutConstraint.Attribute, multiplier: CGFloat)

public extension UIView {
    
    func addSideConstraints(
        top: YAnchorAndConstant? = nil,
        bottom: YAnchorAndConstant? = nil,
        left: XAnchorAndConstant? = nil,
        right: XAnchorAndConstant? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top.yAnchor, constant: top.constant).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom.yAnchor, constant: bottom.constant).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left.xAnchor, constant: left.constant).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right.xAnchor, constant: right.constant).isActive = true
        }
    }
    
    func addSizeConstraints(
        height: DimensionAndMultiplierOrConstant? = nil,
        width: DimensionAndMultiplierOrConstant? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let height = height {
            if let dimensionAndMultiplier = height.dAndM {
                self.heightAnchor.constraint(equalTo: dimensionAndMultiplier.dimension, multiplier: dimensionAndMultiplier.multiplier).isActive = true
            } else if let constant = height.constant {
                self.heightAnchor.constraint(equalToConstant: constant).isActive = true
            }
        }
        
        if let width = width {
            if let dimensionAndMultiplier = width.dAndM {
                self.widthAnchor.constraint(equalTo: dimensionAndMultiplier.dimension, multiplier: dimensionAndMultiplier.multiplier).isActive = true
            } else if let constant = width.constant {
                self.widthAnchor.constraint(equalToConstant: constant).isActive = true
            }
        }
    }
    
    func addCenterConstraints(
        centerX: NSLayoutXAxisAnchor? = nil,
        centerY: NSLayoutYAxisAnchor? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    func addCenterConstraints(
        centerX: CenterAxisParameters? = nil,
        centerY: CenterAxisParameters? = nil
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX {
            superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: centerX.view, attribute: centerX.attributes, multiplier: centerX.multiplier, constant: 0))
        }
        
        if let centerY = centerY {
            superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal, toItem: centerY.view, attribute: centerY.attributes, multiplier: centerY.multiplier, constant: 0))
        }
    }
    
    func lockAllSidesToSuperView(_ space: CGFloat = 0) {
        guard let superView = superview else { return }
        addSideConstraints(
            top: (superView.versionSafeTopAnchor(), space),
            bottom: (superView.versionSafeBottomAnchor(), -space),
            left: (superView.versionSafeLeftAnchor(), space),
            right: (superView.versionSafeRightAnchor(), -space)
        )
    }
    
    func versionSafeLeftAnchor() -> NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.leftAnchor
        } else {
            return self.leftAnchor
        }
    }
    
    func versionSafeRightAnchor() -> NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.rightAnchor
        } else {
            return self.rightAnchor
        }
    }
    
    func versionSafeTopAnchor() -> NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    
    func versionSafeBottomAnchor() -> NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
}
