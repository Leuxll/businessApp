//
//  Login.swift
//  businessApp
//
//  Created by Yue Fung Lee on 19/6/2021.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginView: UIViewController {

    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = ColourConstants.baseColour
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(descriptionStackView)
        containerView.addSubview(textFieldStackView)
        containerView.addSubview(errorLabel)
        containerView.addSubview(horizontalStackView)
        containerView.addSubview(loginButton)
        hideKeyboardWhenTappedAround()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([backButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 45),
                                     backButton.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([descriptionStackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
                                     descriptionStackView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([textFieldStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                     textFieldStackView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 50)])
        
        NSLayoutConstraint.activate([errorLabel.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     errorLabel.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     errorLabel.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([horizontalStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                     horizontalStackView.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -10)])
        
        NSLayoutConstraint.activate([loginButton.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     loginButton.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     loginButton.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                                     loginButton.heightAnchor.constraint(equalToConstant: 45)])
        
        [emailTextField, passwordTextField].forEach { v in
            NSLayoutConstraint.activate([v.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                         v.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                         v.heightAnchor.constraint(equalToConstant: 55)])
        }
    }
    
    func showError(_ v: String) {
        errorLabel.text = v
        errorLabel.alpha = 1
        errorLabel.isHidden = false
    }
    
    func hangleLogin() {
        let email = emailTextField.text
        let password = passwordTextField.text
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            if error != nil {
                self.showError(error!.localizedDescription)
            } else {
                let destinationViewController = TabBar()
                destinationViewController.modalPresentationStyle = .fullScreen
                self.present(destinationViewController, animated: true, completion: nil)
            }
        }
    }
    
    @objc func backTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func signupTapped() {
        let destinationViewController = SignupView()
        destinationViewController.modalPresentationStyle = .fullScreen
        self.present(destinationViewController, animated: true, completion: nil)
    }
    
    @objc func loginTapped() {
        hangleLogin()
    }
    
    var isExpanded: Bool = false
    @objc func keyboardAppear(notification: NSNotification) {
        if !isExpanded {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRect = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRect.height
                scrollView.contentSize = CGSize(width: view.frame.width, height: scrollView.frame.height + keyboardHeight)
            }
            isExpanded = true
        }
    }
    
    @objc func keyboardDisappear(notification: NSNotification) {
        if isExpanded {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRect = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRect.height
                scrollView.contentSize = CGSize(width: view.frame.width, height: scrollView.frame.height - keyboardHeight)
            }
            isExpanded = false
        }
    }
    
    private lazy var backButton: UIButton = {
        let b = UIButton()
        let iconImage: UIImage = UIImage(named: "backButton")!
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setImage(iconImage, for: .normal)
        b.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return b
    }()
    
    private lazy var descriptionHeadline: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Let's sign you in."
        v.font = UIFont(name: FontConstants.boldFont, size: 30)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var descriptionSubline: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Welcome back."
        v.font = UIFont(name: FontConstants.regularFont, size: 30)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var secondDescriptionSubline: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "You have been missed!"
        v.font = UIFont(name: FontConstants.regularFont, size: 30)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var descriptionStackView: UIStackView = {
       let v = UIStackView(arrangedSubviews: [descriptionHeadline, descriptionSubline, secondDescriptionSubline])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        return v
    }()
    
    private lazy var emailTextField: UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        Utilities.customTextField(v)
        v.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: ColourConstants.textColour().placeHolderColour])
        v.keyboardType = .emailAddress
        return v
    }()
    
    private lazy var passwordTextField: UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        Utilities.customTextField(v)
        v.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: ColourConstants.textColour().placeHolderColour])
        v.isSecureTextEntry = true
        return v
    }()
    
    private lazy var textFieldStackView: UIStackView = {
       let v = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.setCustomSpacing(10, after: v.arrangedSubviews[0])
        return v
    }()
    
    private lazy var errorLabel: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isHidden = true
        v.textColor = .red
        v.font = UIFont(name: FontConstants.regularFont, size: 12)
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 3
        return v
    }()
    
    private lazy var existingAccountLabel: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Don't have an account?"
        v.font = UIFont(name: FontConstants.regularFont, size: 16)
        v.textColor = ColourConstants.textColour().placeHolderColour
        return v
    }()
    
    private lazy var signupButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Sign Up", for: .normal)
        b.titleLabel?.font = UIFont(name: FontConstants.regularFont, size: 16)
        b.setTitleColor(ColourConstants.primaryColour, for: .normal)
        b.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
        return b
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [existingAccountLabel, signupButton])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        v.setCustomSpacing(5, after: existingAccountLabel)
        return v
    }()
    
    private lazy var loginButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        Utilities.customButton(b)
        b.setTitle("Log In", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = ColourConstants.primaryColour
        b.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return b
    }()
    
    private lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: .zero)
        v.backgroundColor = ColourConstants.baseColour
        v.contentSize = contentViewSize
        v.frame = view.bounds
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        return v
    }()

    private lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = ColourConstants.baseColour
        v.frame.size = contentViewSize
        return v
    }()
}
