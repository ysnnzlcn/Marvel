//
//  HomeViewController.swift
//  Marvel
//
//  Created by Yasin Nazlican on 02.09.2021.
//

import UIKit

public protocol HomeViewControllerDelegate: class {
    
    func didSelectItem(_ sender: HomeViewController, model: HeroModel)
}

public final class HomeViewController: UIViewController {

    // MARK: Private UI Variables
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = Constants.TableView.separatorStyle
        tableView.backgroundColor = Constants.TableView.backgroundColor
        tableView.alwaysBounceVertical = Constants.TableView.alwaysBounceVertical
        tableView.keyboardDismissMode = Constants.TableView.keyboardDismissMode
        tableView.register(HeroTableViewCell.self)
        return tableView
    }()
    
    // MARK: Private Variables
    
    private let viewModel: HomeViewModel
    private lazy var tableDataSource = HomeTableDataSource(viewModel)
    private lazy var tableDelegate = HomeTableDelegate(viewModel)
    
    // MARK: Public Variables
    
    public weak var delegate: HomeViewControllerDelegate?
    
    // MARK: Life-Cycle
    
    public init(viewModel: HomeViewModel) {
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
        viewModel.getHeroes()
    }
    
    // MARK: Setup Views
    
    private func setupViews() {
        /// Setup main
        title = Constants.MainView.title
        view.backgroundColor = Constants.MainView.backgroundColor
        
        /// Setup table view
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
        
        /// Setup sub views
        view.addSubview(tableView)
        
        /// Add constraints
        
        tableView.addSideConstraints(
            top: (view.versionSafeTopAnchor(), Constants.margins),
            bottom: (view.bottomAnchor, Constants.margins),
            left: (view.leftAnchor, Constants.margins),
            right: (view.rightAnchor, Constants.margins)
        )
    }
    
    // MARK: Setup View Model
    
    private func addChangeHandlers() {
        viewModel.addChangeHandler { [weak self] change in
            guard let self = self else { return }
            
            switch change {
            case .toggleLoader(let show):
                show ? GlobalLoadingView.simple.show() : GlobalLoadingView.simple.hide()
                
            case .insertCells(let indexes):
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexes, with: .automatic)
                self.tableView.endUpdates()
            
            case .showDetails(let hero):
                self.delegate?.didSelectItem(self, model: hero)
                
            case .failed(let message):
                let cancelAction = AlertAction(title: Constants.Alert.cancelActionTitle) {
                    self.viewModel.emit(change: .failed(message)) /// Show pop-up again since there isn't any other fetch functionality.
                }
                let retryAction = AlertAction(title: Constants.Alert.retryActionTitle) {
                    self.viewModel.getHeroes()
                }
                GlobalAlert.complexAlert(title: "", message: message, firstAction: cancelAction, secondAction: retryAction).show(self)
            }
        }
    }
}

private enum Constants {
    
    static let margins: CGFloat = 0.0
    
    enum MainView {
        
        static let title = "Heroes"
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
