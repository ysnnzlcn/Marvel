//
//  HomeTableDelegate.swift
//  Marvel
//
//  Created by Yasin Nazlican on 02.09.2021.
//

import UIKit

public final class HomeTableDelegate: NSObject {
    
    // MARK: Private Variables
    
    private let viewModel: HomeViewModel
    
    // MARK: Life-Cycle
    
    public init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}

extension HomeTableDelegate: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.itemSelected(at: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.Cell.height
    }
}

private enum Constants {
            
    enum Header {
        
        static let font: UIFont = .boldPoppins(18)
    }
    
    enum Cell {
        
        static let height: CGFloat = 110.0
    }
}
