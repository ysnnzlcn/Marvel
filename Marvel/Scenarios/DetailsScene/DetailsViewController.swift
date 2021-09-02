//
//  DetailsViewController.swift
//  Marvel
//
//  Created by Yasin Nazlican on 20.08.2021.
//

import UIKit

public final class DetailsViewController: UIViewController {
    
    // MARK: Private UI Variables
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = Constants.TableView.separatorStyle
        tableView.backgroundColor = Constants.TableView.backgroundColor
        tableView.alwaysBounceVertical = Constants.TableView.alwaysBounceVertical
        tableView.keyboardDismissMode = Constants.TableView.keyboardDismissMode
        tableView.register(DetailsImageAndDescriptionCell.self)
        tableView.register(DetailsTextTableViewCell.self)
        tableView.register(ComicsTableViewCell.self)
        return tableView
    }()
    
    // MARK: Private Variables
    
    private let viewModel: DetailsViewModel
    private lazy var tableDataSource = DetailsTableDataSource(viewModel)
    private lazy var tableDelegate = DetailsTableDelegate(viewModel)
    
    // MARK: Life-Cycle
    
    public init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addChangeHandlers()
        viewModel.didLoad()
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        /// Setup main
        title = viewModel.title
        view.backgroundColor = Constants.MainView.backgroundColor
        
        /// Setup table view
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
        
        /// Setup sub views
        view.addSubview(tableView)
        
        /// Add constraints
        tableView.lockAllSidesToSuperView()
    }
    
    // MARK: Setup View Model
    
    private func addChangeHandlers() {
        viewModel.addChangeHandler { [weak self] change in
            guard let self = self else { return }
            
            switch change {
            case .toggleLoader(let show):
                show ? GlobalLoadingView.simple.show() : GlobalLoadingView.simple.hide()
                
            case .updateTable:
                self.tableView.reloadData()
                
            case .failed(let message):
                let cancelAction = AlertAction(title: Constants.Alert.cancelActionTitle, action: nil)
                let retryAction = AlertAction(title: Constants.Alert.retryActionTitle) {
                    self.viewModel.didLoad()
                }
                GlobalAlert.complexAlert(title: "", message: message, firstAction: cancelAction, secondAction: retryAction).show(self)
            }
        }
    }
}

private enum Constants {
    
    static let margins: CGFloat = 0.0
    
    enum MainView {
        
        static let backgroundColor: UIColor = .backgroundColor
    }
    
    enum TableView {
        
        static let keyboardDismissMode: UIScrollView.KeyboardDismissMode = .onDrag
        static let separatorStyle: UITableViewCell.SeparatorStyle = .none
        static let backgroundColor: UIColor = .backgroundColor
        static let alwaysBounceVertical = true
    }
    
    enum Alert {
        
        static let cancelActionTitle = "Cancel"
        static let retryActionTitle = "Retry"
    }
}

