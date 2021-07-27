//
//  TextbookChapterTableViewCell.swift
//  businessApp
//
//  Created by Yue Fung Lee on 27/6/2021.
//

import UIKit

class TextbookChapterCollectionViewCell: UICollectionViewCell {
    
    var data: TextbookChapter? {
        didSet {
            guard let data = data else {return}
            titleLabel.text = data.title
            descriptionLabel.text = data.description
            imageView.image = UIImage(named: data.imageUrl)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 30
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        setupConstraints()
        setupShadow()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     imageView.heightAnchor.constraint(equalToConstant: 310)])
        
        [titleLabel, descriptionLabel].forEach { v in
            NSLayoutConstraint.activate([v.widthAnchor.constraint(equalToConstant: 250),
                                         v.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
        }
        
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)])
    }
    
    func setupShadow() {
        contentView.layer.shadowOffset = CGSize(width: 15, height: 15)
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowColor = ColourConstants.ShadowColour.cgColor
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    private lazy var imageView: UIImageView = {
       let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 30
        v.clipsToBounds = true
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: FontConstants.boldFont, size: 24)
        v.textColor = ColourConstants.primaryColour
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        return v
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: FontConstants.regularFont, size: 16)
        v.textColor = ColourConstants.textColour().placeHolderColour
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        return v
    }()
    
}
