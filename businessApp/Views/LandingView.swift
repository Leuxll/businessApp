//
//  ViewController.swift
//  businessApp
//
//  Created by Yue Fung Lee on 17/6/2021.
//

import UIKit
import FirebaseAuth

class LandingView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = ColourConstants.baseColour
        view.addSubview(appTitle)
        view.addSubview(businessImageView)
        view.addSubview(informationStackView)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        setupConstraints()
        checkUserLogin()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                     appTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([businessImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     businessImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     businessImageView.topAnchor.constraint(equalTo: appTitle.bottomAnchor),
                                    businessImageView.heightAnchor.constraint(equalToConstant: 450)])
        
        NSLayoutConstraint.activate([informationStackView.topAnchor.constraint(equalTo: businessImageView.bottomAnchor),
                                     informationStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     informationStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)])
        
        NSLayoutConstraint.activate([loginButton.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -10)])
        
        NSLayoutConstraint.activate([signupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)])
        
        [loginButton, signupButton].forEach { b in
            NSLayoutConstraint.activate([b.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                         b.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                         b.heightAnchor.constraint(equalToConstant: 45)])
        }
    }
    
    func checkUserLogin() {
        let auth = Auth.auth()
        auth.addStateDidChangeListener { auth, user in
            if user != nil {
                let destinationViewController = TabBar()
                destinationViewController.modalPresentationStyle = .fullScreen
                self.present(destinationViewController, animated: true, completion: nil)
            } else {
                
            }
        }
    }
    
    @objc func loginTapped() {
        let destinationViewController = LoginView()
        destinationViewController.modalPresentationStyle = .fullScreen
        self.present(destinationViewController, animated: true, completion: nil)
    }
    
    @objc func signupTapped() {
        let destinationViewController = SignupView()
        destinationViewController.modalPresentationStyle = .fullScreen
        self.present(destinationViewController, animated: true, completion: nil)
    }
    
    private lazy var businessImageView: UIImageView = {
       let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFit
        v.image = UIImage(named: "landingImage")?.withRenderingMode(.alwaysOriginal)
        return v
    }()
    
    private lazy var appTitle: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "BusinessApp"
        v.font = UIFont(name: FontConstants.boldFont, size: 24)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var businessLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Businesses"
        v.font = UIFont(name: FontConstants.semiBoldFont, size: 32)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var informationLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Did you know around 26% of entrepreneurs starts their business because they want to work for themselves?"
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 3
        v.font = UIFont(name: FontConstants.regularFont, size: 16)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var informationStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [businessLabel, informationLabel])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        return v
    }()
    
    private lazy var loginButton: UIButton = {
        let b  = UIButton()
        Utilities.customButton(b)
        b.setTitle("Log In", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = ColourConstants.primaryColour
        b.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return b
    }()
    
    private lazy var signupButton: UIButton = {
        let b = UIButton()
        Utilities.customButton(b)
        b.setTitle("Sign Up", for: .normal)
        b.backgroundColor = ColourConstants.LightColour
        b.setTitleColor(ColourConstants.primaryColour, for: .normal)
        b.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        return b
    }()
}
