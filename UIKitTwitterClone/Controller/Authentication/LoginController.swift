//
//  LoginController.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 9.02.2024.
//

import UIKit
import SnapKit

class LoginController: UIViewController {
    //MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(named: "TwitterLogo")
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = UIImage(named: "mail")?.withRenderingMode(.alwaysTemplate)
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = UIImage(named: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account ", "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    //MARK: - Selectors
    @objc func handleLogin () {
        
        guard let email = emailTextField.text else { return }
        print("buraya girdi mi email")
        guard let password = passwordTextField.text else { return }
        print("buraya girdi mi password")
        AuthService.shared.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: - Error logging in: \(error)")
                return
            }
            
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            print("buraya girdi mi 1")
            guard let tab = window.rootViewController else { return }
            print("buraya girdi mi 2")
         //   tab.authenticateUserAndConfigureUI()
            
            
            print("DEBUG - Success log in.")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleShowSignUp () {
        let controller = RegistirationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

//MARK: - Helpers
extension LoginController {
    private func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        setupLogoImageView()
        setupStackView()
        setupDontHaveAccountButton()
    }
    
    private func setupLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
            make.width.equalTo(150)
        }
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom)
            make.left.equalToSuperview().inset(32)
            make.right.equalToSuperview().inset(32)
        }
    }
    
    private func setupDontHaveAccountButton() {
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(40)
            make.right.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.height.equalTo(50)
        }
    }
}
