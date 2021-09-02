//
//  DetailsTextTableViewCell.swift
//  Marvel
//
//  Created by Yasin Nazlican on 21.08.2021.
//

import UIKit

public final class DetailsTextTableViewCell: UITableViewCell {
    
    // MARK: Private UI Variables
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.Label.numberOfLines
        return label
    }()
    
    // MARK: Public Variables
    
    public var labelText: NSAttributedString? {
        didSet {
            label.attributedText = labelText
        }
    }
    
    // MARK: Life-Cycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Subviews
    
    private func setupSubviews() {
        /// Setup Main
        backgroundColor = Constants.Main.backgroundColor
        selectionStyle = Constants.Main.selectionStyle
        
        /// Add subviews
        contentView.addSubview(label)
        
        /// Add constraints to container view
        label.lockAllSidesToSuperView(Constants.commonMargins)
    }
}

private enum Constants {
        
    static let commonMargins: CGFloat = 8.0
    
    enum Main {
        
        static let backgroundColor: UIColor = .clear
        static let selectionStyle: UITableViewCell.SelectionStyle = .none
    }
    
    enum Label {
        
        static let numberOfLines = 0
    }
}
