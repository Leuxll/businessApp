//
//  ProfileView.swift
//  businessApp
//
//  Created by Yue Fung Lee on 23/6/2021.
//

import Foundation
import UIKit
import FirebaseAuth

class ProfileView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = ColourConstants.baseColour
//        setupConstraint()
        setupNavBar()
    }
    
    func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoutButton)
        navigationController?.navigationBar.barTintColor = ColourConstants.baseColour
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    func handleLogout() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            let destinationViewController = LandingView()
            destinationViewController.modalPresentationStyle = .fullScreen
            self.present(destinationViewController, animated: true, completion: nil)
        } catch let logoutError {
            let alert = UIAlertController(title: "Error", message: logoutError.localizedDescription, preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func logoutButtonTapped() {
        handleLogout()
    }
    
    private lazy var titleLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Profile"
        v.font = UIFont(name: FontConstants.boldFont, size: 18)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var logoutButton: UIButton = {
       let b = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let i = UIImage(named: "logoutButton")
        b.translatesAutoresizingMaskIntoConstraints = false
        i?.withRenderingMode(.alwaysOriginal)
        b.setImage(i, for: .normal)
        b.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return b
    }()
    
}
