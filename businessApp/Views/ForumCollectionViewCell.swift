//
//  ForumCollectionViewCell.swift
//  businessApp
//
//  Created by Yue Fung Lee on 1/7/2021.
//

import Foundation
import UIKit

class ForumCollectionViewCell: UICollectionViewCell {
    
    var data: ForumPost? {
        didSet {
            guard let data = data else {return}
            postTitleLabel.text = data.title
            descriptionLabel.text = data.description
            tagLabel.text = data.tag
            authorAndTimeLabel.text = data.authorAndTime
            numberOfLikesLabel.text = data.likes
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
        contentView.addSubview(topStackView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(bottomStackView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([topStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                                     topStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
        
        NSLayoutConstraint.activate([descriptionLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 5),
                                     descriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
        
        NSLayoutConstraint.activate([bottomStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                                     bottomStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)])
    }
    
    private lazy var postTitleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: FontConstants.semiBoldFont, size: 16)
        v.textColor = ColourConstants.primaryColour
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        NSLayoutConstraint.activate([v.widthAnchor.constraint(equalToConstant: 250)])
       return v
    }()
    
    private lazy var tagContainerView: UIView = {
        let v = UIView()
        v.addSubview(tagLabel)
        NSLayoutConstraint.activate([v.widthAnchor.constraint(equalToConstant: 60)])
       return v
    }()
    
    private lazy var tagLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: FontConstants.boldFont, size: 12)
        v.textColor = .white
        v.backgroundColor = ColourConstants.primaryColour
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        v.textAlignment = .center
        NSLayoutConstraint.activate([v.widthAnchor.constraint(equalToConstant: 60), v.heightAnchor.constraint(equalToConstant: 20)])
       return v
    }()
    
    private lazy var topStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [postTitleLabel, tagContainerView])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        v.setCustomSpacing(5, after: postTitleLabel)
       return v
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: FontConstants.regularFont, size: 12)
        v.textColor = ColourConstants.textColour().placeHolderColour
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        NSLayoutConstraint.activate([v.widthAnchor.constraint(equalToConstant: 315), v.heightAnchor.constraint(equalToConstant: 50)])
       return v
    }()
    
    private lazy var authorAndTimeLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: FontConstants.boldFont, size: 12)
        v.textColor = ColourConstants.textColour().placeHolderColour
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        NSLayoutConstraint.activate([v.widthAnchor.constraint(equalToConstant: 250)])
        return v
    }()
    
    private lazy var numberOfLikesLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = UIFont(name: FontConstants.boldFont, size: 12)
        v.textColor = ColourConstants.textColour().placeHolderColour
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        NSLayoutConstraint.activate([v.widthAnchor.constraint(equalToConstant: 250)])
        return v
    }()
    
    private lazy var infoStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [authorAndTimeLabel, numberOfLikesLabel])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        return v
    }()
    
    private lazy var likeButton: UIButton = {
        let b = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        let i = UIImage(named: "heartButton")
        b.translatesAutoresizingMaskIntoConstraints = false
        i?.withRenderingMode(.alwaysOriginal)
        b.setImage(i, for: .normal)
        return b
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [infoStackView, likeButton])
        v.setCustomSpacing(5, after: infoStackView)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        return v
    }()
    
}
