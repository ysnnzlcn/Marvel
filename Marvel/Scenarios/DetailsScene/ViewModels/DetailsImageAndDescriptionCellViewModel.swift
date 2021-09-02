//
//  DetailsImageAndDescriptionCellViewModel.swift
//  Marvel
//
//  Created by Yasin Nazlican on 21.08.2021.
//

import UIKit

public final class DetailsImageAndDescriptionCellViewModel {
    
    // MARK: Public Constants
    
    public let model: HeroModel
    
    // MARK: Life-Cycle
    
    public init(model: HeroModel) {
        self.model = model
    }
    
    // MARK: Public Read-Only Variables
    
    public var titleText: NSAttributedString? {
        model.name.attributed(font: Constants.Title.font)
    }
}

private enum Constants {
    
    enum Title {
        
        static let font: UIFont = .boldPoppins(18)
    }
}
