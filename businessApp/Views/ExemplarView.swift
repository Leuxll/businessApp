//
//  ExemplarView.swift
//  businessApp
//
//  Created by Yue Fung Lee on 23/6/2021.
//

import Foundation
import UIKit

class ExemplarView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = ColourConstants.baseColour
        view.addSubview(segmentedControl)
        view.addSubview(byMarksView)
        view.addSubview(byTopicView)
        segmentedControl.selectedSegmentIndex = 0
        setupConstraint()
        setupNavBar()
        setupSegmentedControl()
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     segmentedControl.heightAnchor.constraint(equalToConstant: 30),
                                     segmentedControl.widthAnchor.constraint(equalToConstant: 330)])
        
        NSLayoutConstraint.activate([byTopicView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
                                     byTopicView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                                     byTopicView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                                     byTopicView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)])
        
        NSLayoutConstraint.activate([byMarksView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
                                     byMarksView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                                     byMarksView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                                     byMarksView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)])
    }
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationController?.navigationBar.barTintColor = ColourConstants.baseColour
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func setupSegmentedControl() {
        segmentedControl.layer.shadowOffset = CGSize(width: 8, height: 12)
        segmentedControl.layer.shadowOpacity = 0.5
        segmentedControl.layer.shadowColor = ColourConstants.ShadowColour.cgColor
        segmentedControl.layer.shouldRasterize = true
        segmentedControl.layer.rasterizationScale = UIScreen.main.scale
    }
    
    @objc func changeCardViews() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            byTopicView.isHidden = true
            byMarksView.isHidden = false
            print("by marks")
        case 1:
            byMarksView.isHidden = true
            byTopicView.isHidden = false
            print("by topic")
        default:
            break
        }
    }
    
    private lazy var titleLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Essay and Question Exemplar"
        v.font = UIFont(name: FontConstants.boldFont, size: 18)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let items = ["By Marks", "By Topic"]
        let v = UISegmentedControl(items: items)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.selectedSegmentIndex = 0
        v.layer.cornerRadius = 5
        let segmentedControlTextAttributes = [NSAttributedString.Key.foregroundColor: ColourConstants.primaryColour, NSAttributedString.Key.font: UIFont(name: FontConstants.boldFont, size: 12)]
        v.setTitleTextAttributes(segmentedControlTextAttributes as [NSAttributedString.Key : Any], for: .normal)
        v.setTitleTextAttributes(segmentedControlTextAttributes as [NSAttributedString.Key : Any], for: .selected)
        v.addTarget(self, action: #selector(changeCardViews), for: .valueChanged)
        return v
    }()
    
    private lazy var byTopicView: UIView = {
       let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .blue
        return v
    }()
    
    private lazy var byMarksView: UIView = {
       let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .red
        return v
    }()
    
}
