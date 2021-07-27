//
//  HomeView.swift
//  businessApp
//
//  Created by Yue Fung Lee on 20/6/2021.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class HomeView: UIViewController {
    
    let data = [
        TextbookChapter(title: "Business Organization and Environment", imageUrl: "homeImage1", description: "Business management refers to  the coordination and organisation of business activities. This includes the production of materials, money, machines."),
        TextbookChapter(title: "Human Resources Management (HRM)", imageUrl: "homeImage2", description: "Human resources (HR) is the division of a business that is charged with finding, screening, recruiting, and training job applicants, as well as administering employee-benefit programs.")
    ]
    
    private var viewModel = TextbookChapterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = ColourConstants.baseColour
        view.addSubview(greetingStackView)
        view.addSubview(collectionView)
//        fetchData()
        setupConstraints()
        setupNavBar()
    }
    
    func fetchData() {
        DispatchQueue.main.async {
            self.viewModel.fetchData()
            self.collectionView.reloadData()
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([greetingStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     greetingStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: greetingStackView.bottomAnchor, constant: 20),
                                     collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationController?.navigationBar.barTintColor = ColourConstants.baseColour
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Textbook"
        v.font = UIFont(name: FontConstants.boldFont, size: 18)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var greetingLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Hello,"
        v.font = UIFont(name: FontConstants.boldFont, size: 24)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var fullnameLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        DispatchQueue.main.async {
            FirebaseService.getFullname(v)
        }
        v.font = UIFont(name: FontConstants.boldFont, size: 24)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var greetingStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [greetingLabel, fullnameLabel])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        return v
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 20
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = ColourConstants.baseColour
        v.register(TextbookChapterCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
}

extension HomeView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 310, height: 520)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! TextbookChapterCollectionViewCell
        cell.data = self.data[indexPath.row]
        return cell
    }
}
