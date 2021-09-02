//
//  GradientView.swift
//  Marvel
//
//  Created by Yasin Nazlican on 02.09.2021.
//

import UIKit

public final class GradientView: UIView {
    
    public var startColor: UIColor = .white { didSet { updateColors() }}
    public var endColor: UIColor = .clear { didSet { updateColors() }}
    public var startLocation: Double = 0.05 { didSet { updateLocations() }}
    public var endLocation: Double = 0.95 { didSet { updateLocations() }}
    public var horizontalMode: Bool = false { didSet { updatePoints() }}
    public var diagonalMode: Bool = false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    private func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    
    private func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    private func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }
}
