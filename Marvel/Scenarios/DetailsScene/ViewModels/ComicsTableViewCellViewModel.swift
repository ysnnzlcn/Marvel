//
//  ComicsTableViewCellViewModel.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import UIKit

public final class ComicsTableViewCellViewModel {
    
    // MARK: Public Constants
    
    public let model: ComicModel
    
    // MARK: Life-Cycle
    
    public init(model: ComicModel) {
        self.model = model
    }
    
    // MARK: Public Read-Only Variables
    
    public var descriptionText: NSAttributedString {
        let finalText = NSMutableAttributedString()
        
        /// Set title
        finalText.append("\(model.title)\n".attributed(font: Constants.Title.font))
        
        /// Set overview
        var description = model.description ?? ""
        if description.isEmpty {
            description = Constants.Description.noDescriptionText
        }
        finalText.append(description.attributed(font: Constants.Description.font))
        
        return finalText
    }
}

private enum Constants {
    
    enum Title {
        
        static let font: UIFont = .boldPoppins(14)
    }
    
    enum Description {
        
        static let font: UIFont = .regularPoppins(12)
        static let noDescriptionText = "No description provided."
    }
}
