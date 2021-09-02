//
//  DetailsImageAndDescriptionCell.swift
//  Marvel
//
//  Created by Yasin Nazlican on 21.08.2021.
//

import UIKit

class DetailsImageAndDescriptionCell: UITableViewCell {

    // MARK: Private UI Variables
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = Constants.ImageView.clipsToBounds
        imageView.contentMode = Constants.ImageView.contentMode
        return imageView
    }()
    
    private lazy var gradientView: GradientView = {
        let view = GradientView()
        view.startColor = Constants.GradientView.startColor
        view.endColor = Constants.GradientView.endColor
        return view
    }()
    
    private lazy var titleLabel = UILabel()
    
    // MARK: Public Variables
    
    public var viewModel: DetailsImageAndDescriptionCellViewModel? {
        didSet {
            if let posterURL = viewModel?.model.thumbnail?.absoluteURL {
                posterImageView.sd_setImage(with: posterURL, completed: nil)
            }
    
            titleLabel.attributedText = viewModel?.titleText
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
        
        /// Add subviews
        [posterImageView, gradientView].forEach { contentView.addSubview($0) }
        gradientView.addSubview(titleLabel)
        
        /// Add constraints to image view
        posterImageView.lockAllSidesToSuperView()
        
        /// Add constraints to gradient view
        gradientView.addSizeConstraints(height: ((posterImageView.heightAnchor, Constants.GradientView.heightRatio), nil))
        gradientView.addSideConstraints(
            bottom: (bottomAnchor, Constants.GradientView.margins),
            left: (leftAnchor, Constants.GradientView.margins),
            right: (rightAnchor, Constants.GradientView.margins)
        )
        
        /// Add constraints to label
        titleLabel.addSideConstraints(
            bottom: (gradientView.bottomAnchor, -Constants.TitleLabel.margins),
            left: (gradientView.leftAnchor, Constants.TitleLabel.margins),
            right: (gradientView.rightAnchor, -Constants.TitleLabel.margins)
        )
    }
}

private enum Constants {
            
    enum Main {
        
        static let backgroundColor: UIColor = .backgroundColor
    }
    
    enum ImageView {
        
        static let contentMode: UIView.ContentMode = .scaleToFill
        static let clipsToBounds = true
    }
    
    enum GradientView {
        
        static let heightRatio: CGFloat = 0.3
        static let margins: CGFloat = .zero
        static let startColor: UIColor = .clear
        static let endColor: UIColor = .white
    }
    
    enum TitleLabel {
        
        static let margins: CGFloat = 8.0
    }
}
