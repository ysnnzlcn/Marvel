//
//  HomeCoordinator.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import UIKit

fileprivate enum HomeControllers {
    
    case home
    case details(_ heroModel: HeroModel)
}

public final class HomeCoordinator: Coordinator {
    
    // MARK: Properties
    
    public let rootViewController: UINavigationController

    // MARK: Life-Cycle

    public init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }

    public override func start() {
        let homeViewController = makeController(type: .home)
        rootViewController.setViewControllers([homeViewController], animated: false)
    }
    
    private func makeController(type: HomeControllers) -> UIViewController {
        switch type {
        case .home:
            let viewModel = HomeViewModel(service: RestServices())
            let controller = HomeViewController(viewModel: viewModel)
            controller.delegate = self
            return controller
            
        case .details(let heroModel):
            let viewModel = DetailsViewModel(service: RestServices(), heroModel: heroModel)
            return DetailsViewController(viewModel: viewModel)
        }
    }
    
    private func push(_ controller: UIViewController) {
        rootViewController.pushViewController(controller, animated: true)
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    
    public func didSelectItem(_ sender: HomeViewController, model: HeroModel) {
        let detailsViewController = makeController(type: .details(model))
        push(detailsViewController)
    }
}
