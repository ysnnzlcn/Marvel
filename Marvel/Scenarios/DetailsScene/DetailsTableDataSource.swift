//
//  DetailsTableDataSource.swift
//  Marvel
//
//  Created by Yasin Nazlican on 20.08.2021.
//

import UIKit

public final class DetailsTableDataSource: BaseTableViewDataSource<DetailsTableCellType> {
    
    // MARK: Private Variables
    
    private let viewModel: DetailsViewModel
    
    // MARK: Life-Cycle
    
    public init(_ viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
}

extension DetailsTableDataSource: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.state.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.state.sections[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.state.sections[indexPath.section].items[indexPath.row]
        switch item.cell {
        case .imageAndDescriptionCell(let cellViewModel):
            let cell: DetailsImageAndDescriptionCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = cellViewModel
            return cell
            
        case .textCell(let text):
            let cell: DetailsTextTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.labelText = text
            return cell
            
        case .comicCell(let cellViewModel):
            let cell: ComicsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.viewModel = cellViewModel
            return cell
        }
    }
}

public enum DetailsTableCellType {
    
    case imageAndDescriptionCell(_ cellViewModel: DetailsImageAndDescriptionCellViewModel)
    case textCell(_ text: NSAttributedString)
    case comicCell(_ cellViewModel: ComicsTableViewCellViewModel)
}
