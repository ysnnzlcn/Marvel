//
//  HomeTableDataSource.swift
//  Marvel
//
//  Created by Yasin Nazlican on 02.09.2021.
//

import UIKit

public final class HomeTableDataSource: BaseTableViewDataSource<HomeTableCellType> {
    
    // MARK: Private Variables
    
    private let viewModel: HomeViewModel
    
    // MARK: Life-Cycle
    
    public init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
}

extension HomeTableDataSource: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.state.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.state.items[indexPath.row].cell {
        case .heroCell(let cellViewModel):
            let cell: HeroTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = cellViewModel
            viewModel.cellsDequeued(at: indexPath.row)
            return cell
        }
    }
}

public enum HomeTableCellType {
    
    case heroCell(_ cellViewModel: HeroTableViewCellViewModel)
}
