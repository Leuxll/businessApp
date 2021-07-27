//
//  ForumView.swift
//  businessApp
//
//  Created by Yue Fung Lee on 23/6/2021.
//

import Foundation
import UIKit

class ForumView: UIViewController, UISearchBarDelegate {
    
    let data = [
        ForumPost(title: "The Ultimate Guide/Mega thread to the HL/SL Business IA.", tag: "Meta", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At.", authorAndTime: "Posted by Yue Fung Lee 2 minutes ago", likes: "99 Likes"),
        ForumPost(title: "FAQ megathread.", tag: "Meta", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At.", authorAndTime: "Posted by Yue Fung Lee 2 minutes ago", likes: "99 Likes"),
        ForumPost(title: "Who is Mr. Tang?", tag: "Meme", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At.", authorAndTime: "Posted by Yue Fung Lee 2 minutes ago", likes: "99 Likes"),
        ForumPost(title: "Why is Mr. Tang?", tag: "Meme", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At.", authorAndTime: "Posted by Yue Fung Lee 2 minutes ago", likes: "99 Likes"),
        ForumPost(title: "Where is Mr. Tang?", tag: "Meme", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At.", authorAndTime: "Posted by Yue Fung Lee 2 minutes ago", likes: "99 Likes"),
        ForumPost(title: "How is Mr. Tang?", tag: "Meme", description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At.", authorAndTime: "Posted by Yue Fung Lee 2 minutes ago", likes: "99 Likes"),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = ColourConstants.baseColour
        view.addSubview(containerView)
        view.addSubview(collectionView)
        setupConstraints()
        setupNavBar()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func setupNavBar() {
        navigationItem.searchController = searchBarController
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleLabel)
        let addItem = UIBarButtonItem(customView: addButton)
        let filterItem = UIBarButtonItem(customView: filterButton)
        navigationItem.setLeftBarButtonItems([addItem, filterItem], animated: false)
    }
    
    private lazy var titleLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Forum"
        v.font = UIFont(name: FontConstants.boldFont, size: 18)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var filterButton: UIButton = {
       let b = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let i = UIImage(named: "filterButton")
        b.translatesAutoresizingMaskIntoConstraints = false
        i?.withRenderingMode(.alwaysOriginal)
        b.setImage(i, for: .normal)
        return b
    }()
    
    private lazy var addButton: UIButton = {
        let b = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let i = UIImage(named: "addButton")
        b.translatesAutoresizingMaskIntoConstraints = false
        i?.withRenderingMode(.alwaysOriginal)
        b.setImage(i, for: .normal)
        return b
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [filterButton, addButton])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        return v
    }()
    
    private lazy var stackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [buttonStackView, titleLabel])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        return v
    }()
    
    private lazy var containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private lazy var searchBarController: UISearchController = {
        let v = UISearchController()
        v.searchBar.delegate = self
        v.searchBar.searchBarStyle = .prominent
        v.searchBar.backgroundImage = UIImage()
        v.searchBar.placeholder = "Search..."
        v.searchBar.sizeToFit()
        return v
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = ColourConstants.baseColour
        v.register(ForumCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
}

extension ForumView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ForumCollectionViewCell
        cell.data = self.data[indexPath.row]
        return cell
    }
}
