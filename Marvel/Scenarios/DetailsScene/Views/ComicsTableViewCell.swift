//
//  ComicsTableViewCell.swift
//  Marvel
//
//  Created by Yasin Nazlican on 2.09.2021.
//

import UIKit
import SDWebImage

public class ComicsTableViewCell: UITableViewCell {
    
    // MARK: Private UI Variables
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.ImageView.cornerRadius
        imageView.layer.borderWidth = Constants.ImageView.borderWidth
        imageView.layer.borderColor = Constants.ImageView.borderColor
        imageView.clipsToBounds = Constants.ImageView.clipsToBounds
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = Constants.DescriptionLabel.numberOfLines
        return label
    }()
    
    // MARK: Life-Cycle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public Variables
    
    public var viewModel: ComicsTableViewCellViewModel? {
        didSet {
            posterImageView.image = nil
            if let imageURL = viewModel?.model.thumbnail?.absoluteURL {
                posterImageView.sd_setImage(with: imageURL, completed: nil)
            }
            descriptionLabel.attributedText = viewModel?.descriptionText
        }
    }
    
    // MARK: Setup Subviews
    
    private func setupSubviews() {
        /// Setup Main
        backgroundColor = Constants.Main.backgroundColor
        selectionStyle = Constants.Main.selectionStyle
        
        /// Add subviews
        [posterImageView, descriptionLabel].forEach { contentView.addSubview($0) }
        
        /// Add constraints to image view
        posterImageView.addSideConstraints(
            top: (contentView.topAnchor, Constants.commonMargins),
            bottom: (contentView.bottomAnchor, -Constants.commonMargins),
            left: (contentView.leftAnchor, Constants.commonMargins)
        )
        posterImageView.addSizeConstraints(
            width: ((posterImageView.heightAnchor, Constants.ImageView.widthRatio), nil)
        )
        
        /// Add constraints to label
        descriptionLabel.addSideConstraints(
            top: (contentView.topAnchor, Constants.commonMargins),
            bottom: (contentView.bottomAnchor, -Constants.commonMargins),
            left: (posterImageView.rightAnchor, Constants.commonMargins),
            right: (contentView.rightAnchor, -Constants.commonMargins)
        )
    }
    
    // MARK: Helper Methods
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.sd_cancelCurrentImageLoad() /// Lets cancel image download to not to block network.
    }
}

private enum Constants {
        
    static let commonMargins: CGFloat = 8.0
    
    enum Main {
        
        static let backgroundColor: UIColor = .clear
        static let selectionStyle: UITableViewCell.SelectionStyle = .none
    }
    
    enum ImageView {
        
        static let borderWidth: CGFloat = 1
        static let borderColor: CGColor = UIColor.placeholderColor.cgColor
        static let cornerRadius: CGFloat = 5.0
        static let clipsToBounds = true
        static let widthRatio: CGFloat = 0.70
    }
    
    enum DescriptionLabel {
        
        static let numberOfLines = 5
    }
}

