//
//  HeroTableViewCell.swift
//  Marvel
//
//  Created by Yasin Nazlican on 02.09.2021.
//

import UIKit
import SDWebImage

public class HeroTableViewCell: UITableViewCell {
    
    // MARK: Private UI Variables
        
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.ContainerView.backgroundColor
        view.layer.cornerRadius = Constants.ContainerView.cornerRadius
        view.layer.borderWidth = Constants.ContainerView.borderWidth
        view.layer.borderColor = Constants.ContainerView.borderColor
        return view
    }()
    
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
    
    private lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.AccessoryImage.image
        imageView.contentMode = Constants.AccessoryImage.contentMode
        return imageView
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
    
    public var viewModel: HeroTableViewCellViewModel? {
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
        contentView.addSubview(containerView)
        [posterImageView, descriptionLabel, accessoryImageView].forEach { containerView.addSubview($0) }
        
        /// Add constraints to container view
        containerView.lockAllSidesToSuperView(Constants.commonMargins)
        
        /// Add constraints to image view
        posterImageView.addSideConstraints(
            top: (containerView.topAnchor, Constants.ImageView.margins),
            bottom: (containerView.bottomAnchor, Constants.ImageView.margins),
            left: (containerView.leftAnchor, Constants.ImageView.margins))
        posterImageView.addSizeConstraints(
            width: ((posterImageView.heightAnchor, Constants.ImageView.widthRatio), nil)
        )
        
        /// Add constraints to label
        descriptionLabel.addSideConstraints(
            top: (containerView.topAnchor, Constants.commonMargins),
            bottom: (containerView.bottomAnchor, -Constants.commonMargins),
            left: (posterImageView.rightAnchor, Constants.commonMargins),
            right: (accessoryImageView.leftAnchor, Constants.commonMargins)
        )
        
        /// Add constraints to accessory image view
        accessoryImageView.addSideConstraints(
            right: (containerView.rightAnchor, -Constants.commonMargins)
        )
        
        accessoryImageView.addSizeConstraints(
            height: (nil, Constants.AccessoryImage.size),
            width: (nil, Constants.AccessoryImage.size)
        )
        
        accessoryImageView.addCenterConstraints(centerY: containerView.centerYAnchor)
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
    
    enum ContainerView {
        
        static let backgroundColor: UIColor = .backgroundColor
        static let borderWidth: CGFloat = 1
        static let borderColor: CGColor = UIColor.placeholderColor.cgColor
        static let cornerRadius: CGFloat = 5.0
    }
    
    enum ImageView {
        
        static let borderWidth: CGFloat = 1
        static let borderColor: CGColor = UIColor.placeholderColor.cgColor
        static let cornerRadius: CGFloat = 5.0
        static let clipsToBounds = true
        static let margins: CGFloat = 0
        static let widthRatio: CGFloat = 0.70
    }
    
    enum DescriptionLabel {
        
        static let numberOfLines = 5
    }
    
    enum AccessoryImage {
        
        static let image = UIImage(named: "grey-arrow")
        static let contentMode: UIView.ContentMode = .scaleAspectFit
        static let size: CGFloat = 10.0
    }
}

