//
//  GlobalLoadingView.swift
//  Marvel
//
//  Created by Yasin Nazlican on 01.09.2021.
//

import UIKit

enum GlobalLoadingView {
    case simple
    case withMessage(_ message: String)
    case withImageAndMessage(_image: String, message: String)
    
    private static let viewTag = 1234
    static var oneUseDimAlpha: CGFloat = 0.2
    
    func show() {
        switch self {
        case .simple:
            showWaitingView()
        case .withMessage(let message):
            showWaitingView(image: nil, message: message)
        case .withImageAndMessage(let image, let message):
            showWaitingView(image: image, message: message)
        }
    }
    
    private func showWaitingView(image: String? = nil, message: String? = nil) {
        guard let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first else { return }
        DispatchQueue.main.async {
            var bgView = keyWindow.viewWithTag(GlobalLoadingView.viewTag)
            
            if bgView == nil {
                bgView = UIView(frame: keyWindow.frame)
                bgView?.tag = GlobalLoadingView.viewTag
                bgView?.backgroundColor = .clear
                
                let bgDimView = UIView(frame: keyWindow.frame)
                bgDimView.backgroundColor = UIColor.backgroundColor.withAlphaComponent(GlobalLoadingView.oneUseDimAlpha)
                GlobalLoadingView.oneUseDimAlpha = 0.2
                bgView?.addSubview(bgDimView)
                
                let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 180, height: 120))
                if #available(iOS 13.0, *) {
                    activityIndicator.style = UIActivityIndicatorView.Style.large
                } else {
                    activityIndicator.style = .whiteLarge
                }
                activityIndicator.color = .textColor
                activityIndicator.startAnimating()
                bgView?.addSubview(activityIndicator)
                
                let messageLabel = UILabel(frame: CGRect(x: 0, y: 75, width: 180, height: 40))
                messageLabel.backgroundColor = UIColor.clear
                messageLabel.textAlignment = .center
                messageLabel.text = message
                messageLabel.font = .poppins(type: .Semibold, size: 14)
                messageLabel.textColor = .textColor
                messageLabel.numberOfLines = 0
                activityIndicator.addSubview(messageLabel)
                activityIndicator.center = bgView!.center
                
                keyWindow.addSubview(bgView!)
            }
            
            UIView.animate(withDuration: 0.4, delay: 0, options: .beginFromCurrentState, animations: {
                bgView?.alpha = 1
            }, completion: nil)
        }
    }
    
    func hide() {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if let keyWindow = keyWindow {
            DispatchQueue.main.async {
                let bgView = keyWindow.viewWithTag(GlobalLoadingView.viewTag)
                bgView?.removeFromSuperview()
            }
        }
    }
    
}
