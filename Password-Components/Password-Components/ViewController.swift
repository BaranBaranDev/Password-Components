//
//  ViewController.swift
//  Password-Components
//
//  Created by Baran Baran on 21.03.2024.
//

import UIKit


final class ViewController: UIViewController {
    
    // MARK: - Properties
    private var views : [UIView] = []
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    
    
    
    // MARK: - UI Elements
    private let newPasswordTextField : PasswordTextField = PasswordTextField(placeHolderText: "New Password")
    private let statusView : PasswordStatusView = PasswordStatusView()
    private let confirmPasswordTextField = PasswordTextField(placeHolderText: "Re-enter new password")
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 20
        return sv
        
    }()
    
    
    private lazy var resetButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Reset password"
        config.buttonSize = UIButton.Configuration.Size.large
        config.baseBackgroundColor = .systemBlue
        config.cornerStyle = .dynamic
        
        let btn = UIButton(configuration: config)
        // btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
}

// MARK: - Helpers

extension ViewController {
    private func setupUI(){
        newPasswordTextField.delegate = self
        configuration()
        setupNewPassword()
        setupDismissKeyboardGesture()
        setupConfirmPassword()
        
    }
    
    // typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
    private func setupNewPassword() {
        let newPasswordValidation: CustomValidation = { text in
            
            // Empty text
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your password")
            }
            
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            
            // Criteria met
            self.statusView.updateDisplay(text)
            if !self.statusView.validate(text) {
                return (false, "Your password must meet the requirements below")
            }
            
            
            return (true, "")
        }
        
        newPasswordTextField.customValidation = newPasswordValidation
    }
    
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}


extension ViewController{
    private func configuration(){
        configureSubviews()
        configurationStackView()
    }
    
    private func configureSubviews(){
        views = [stackView]
        view.addSubviews(views)
        stackView.addArrangedSubviews(newPasswordTextField,statusView,confirmPasswordTextField,resetButton)
        
    }
    
}

extension ViewController {
    private func configurationStackView(){
        
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

// MARK: - PasswordTextFieldDelegate
extension ViewController: PasswordTextFieldDelegate {
    
    func editingChanged(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            statusView.updateDisplay(sender.textField.text ?? "")
        }
    }
    
    
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender === newPasswordTextField {
            _ = newPasswordTextField.validate()
        }else if sender == confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
    
    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }

            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match.")
            }

            return (true, "")
        }

        confirmPasswordTextField.customValidation = confirmPasswordValidation
        confirmPasswordTextField.delegate = self
    }
}
