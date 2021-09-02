//
//  SceneDelegate.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setup(windowScene)
    }
    
    private func setup(_ windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
    }
}
