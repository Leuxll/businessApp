//
//  Signup.swift
//  businessApp
//
//  Created by Yue Fung Lee on 20/6/2021.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignupView: UIViewController {
    
//    var fullname: String? = self().fullnameTextField.text
//    var email: String? =
//    var password: String?
//    var confirmPassword: String?view
    
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
        containerView.addSubview(signupButton)
        hideKeyboardWhenTappedAround()
        setupConstraint()
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([backButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 45),
                                     backButton.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([descriptionStackView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
                                     descriptionStackView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20)])
        
        NSLayoutConstraint.activate([textFieldStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                     textFieldStackView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 50)])
        
        NSLayoutConstraint.activate([errorLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                     errorLabel.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 20),
                                     errorLabel.widthAnchor.constraint(equalToConstant: 320)])
        
        NSLayoutConstraint.activate([horizontalStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                                     horizontalStackView.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: -10)])
        
        NSLayoutConstraint.activate([signupButton.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                                     signupButton.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                     signupButton.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                     signupButton.heightAnchor.constraint(equalToConstant: 45)])
        
        [fullnameTextField, emailTextField, passwordTextField, confirmPasswordTextField].forEach { v in
            NSLayoutConstraint.activate([v.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                                         v.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                                         v.heightAnchor.constraint(equalToConstant: 55)])
        }
        
    }
    
    func validateFields() -> String? {
        if Utilities.cleanString(fullnameTextField) == "" || Utilities.cleanString(emailTextField) == "" || Utilities.cleanString(passwordTextField) == "" || Utilities.cleanString(confirmPasswordTextField) == "" {
            return "Please fill in all fields."
        }
        let cleanPassword = Utilities.cleanString(passwordTextField)!
        if Utilities.isPasswordValid(cleanPassword) == false {
            return "Password must be 8 characters long, contains a special character and a number."
        }
        if passwordTextField.text != confirmPasswordTextField.text {
            return "Paswords does not match."
        }
        return nil
    }
    
    func showError(_ v: String) {
        errorLabel.text = v
        errorLabel.alpha = 1
        errorLabel.isHidden = false
    }
    
    func handleSignup() {
        let fullname = fullnameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let error = validateFields()
        if error != nil {
            showError(error!)
        } else {
            Auth.auth().createUser(withEmail: email!, password: password!) { (result, error) in
                if error != nil {
                    self.showError(error!.localizedDescription)
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").document((result?.user.uid)!).setData(["fullname": fullname!, "email": email!, "password": password!, "uid": result?.user.uid as Any]) { error in
                        if error != nil {
                            self.showError("\(String(describing: error?.localizedDescription))")
                        }
                    }
                    let destinationViewController = TabBar()
                    destinationViewController.modalPresentationStyle = .fullScreen
                    self.present(destinationViewController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func backTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func loginTapped() {
        let destinationViewController = LoginView()
        destinationViewController.modalPresentationStyle = .fullScreen
        self.present(destinationViewController, animated: true, completion: nil)
    }
    
    @objc func signupTapped() {
        handleSignup()
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
        v.text = "Welcome aboard!"
        v.font = UIFont(name: FontConstants.boldFont, size: 30)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var descriptionSubline: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Sign Up."
        v.font = UIFont(name: FontConstants.regularFont, size: 30)
        v.textColor = ColourConstants.primaryColour
        return v
    }()
    
    private lazy var secondDescriptionSubline: UILabel = {
        let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "Let's start learning!"
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
    
    private lazy var fullnameTextField: UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        Utilities.customTextField(v)
        v.attributedPlaceholder = NSAttributedString(string: "Fullname", attributes: [NSAttributedString.Key.foregroundColor: ColourConstants.textColour().placeHolderColour])
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
    
    private lazy var confirmPasswordTextField: UITextField = {
        let v = UITextField()
        v.translatesAutoresizingMaskIntoConstraints = false
        Utilities.customTextField(v)
        v.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: ColourConstants.textColour().placeHolderColour])
        v.isSecureTextEntry = true
        return v
    }()
    
    private lazy var textFieldStackView: UIStackView = {
       let v = UIStackView(arrangedSubviews: [fullnameTextField, emailTextField, passwordTextField, confirmPasswordTextField])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        
        for n in 0...2 {
            v.setCustomSpacing(10, after: v.arrangedSubviews[n])
        }
        
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
        v.text = "Already have an account?"
        v.font = UIFont(name: FontConstants.regularFont, size: 16)
        v.textColor = ColourConstants.textColour().placeHolderColour
        return v
    }()
    
    private lazy var loginButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Log In", for: .normal)
        b.titleLabel?.font = UIFont(name: FontConstants.regularFont, size: 16)
        b.setTitleColor(ColourConstants.primaryColour, for: .normal)
        b.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return b
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let v = UIStackView(arrangedSubviews: [existingAccountLabel, loginButton])
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .horizontal
        v.setCustomSpacing(5, after: existingAccountLabel)
        return v
    }()
    
    private lazy var signupButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        Utilities.customButton(b)
        b.setTitle("Sign Up", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = ColourConstants.primaryColour
        b.addTarget(self, action: #selector(signupTapped), for: .touchUpInside)
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

