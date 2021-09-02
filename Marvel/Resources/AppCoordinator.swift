//
//  AppCoordinator.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import UIKit

public final class AppCoordinator: Coordinator {
    
    // MARK: Public Properties

    public let window: UIWindow
    public private(set) lazy var rootViewController = UINavigationController()
    
    // MARK: Life-Cycle

    public init(window: UIWindow) {
        self.window = window
    }

    public override func start() {
        let homeCoordinator = HomeCoordinator(rootViewController: rootViewController)
        addChildCoordinator(homeCoordinator)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        homeCoordinator.start()
    }
}
