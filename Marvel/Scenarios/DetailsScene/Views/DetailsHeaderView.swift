//
//  DetailsHeaderView.swift
//  Marvel
//
//  Created by Yasin Nazlican on 20.08.2021.
//

import UIKit

public final class DetailsHeaderView: UIView {
    
    // MARK: Private UI Variables
    
    private lazy var label = UILabel()
    
    // MARK: Private Variables
    
    private let title: NSAttributedString?
    
    // MARK: Life-Cycle
    
    public init(title: NSAttributedString?) {
        self.title = title
        super.init(frame: .zero)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        /// Main
        backgroundColor = Constants.Main.backgroundColor
        
        /// Label
        addSubview(label)
        label.lockAllSidesToSuperView(Constants.Label.margin)
        label.attributedText = title
    }
}

private enum Constants {
        
    static let commonMargins: CGFloat = 8.0
    
    enum Main {
        
        static let backgroundColor: UIColor = .backgroundColor
    }
    
    enum Label {
        
        static let margin: CGFloat = 8.0
    }
}
