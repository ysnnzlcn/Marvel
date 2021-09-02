//
//  DetailsTableDelegate.swift
//  Marvel
//
//  Created by Yasin Nazlican on 20.08.2021.
//

import UIKit

public final class DetailsTableDelegate: NSObject {
    
    // MARK: Private Variables
    private let viewModel: DetailsViewModel
    
    // MARK: Life-Cycle
    public init(_ viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
}

extension DetailsTableDelegate: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.state.sections[indexPath.section].items[indexPath.row].cell {
        case .imageAndDescriptionCell:
            return Constants.HeaderImageCell.height
            
        case .textCell:
            return UITableView.automaticDimension
            
        case .comicCell:
            return Constants.ComicCell.height
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = viewModel.state.sections[section]
        guard section.shouldShowHeader else { return nil }
        let attributedTitle = section.title?.attributed(font: Constants.Header.font)
        return DetailsHeaderView(title: attributedTitle)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel.state.sections[section].shouldShowHeader else { return 0 }
        return UITableView.automaticDimension
    }
}

private enum Constants {
    
    enum Header {
        
        static let font: UIFont = .boldPoppins(18)
    }
    
    enum HeaderImageCell {
        
        static let height: CGFloat = 400.0
    }
    
    enum ComicCell {
        
        static let height: CGFloat = 80.0
    }
}
