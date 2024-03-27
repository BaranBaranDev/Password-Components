//
//  PasswordStatusView.swift
//  Password-Components
//
//  Created by Baran Baran on 23.03.2024.
//

import UIKit

class PasswordStatusView: UIView {
    
    // MARK: - UI Elements
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    
    private lazy var label : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.attributedText = makeCriteriaMessage()
        return lbl
    }()
    
    
    private let lengthCriteriaView = PasswordCriteriaView(text: "8-32 characters (no spaces)")
    private let uppercaseCriteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
    private let lowerCaseCriteriaView = PasswordCriteriaView(text: "lowercase (a-z)")
    private let digitCriteriaView = PasswordCriteriaView(text: "digit (0-9)")
    private let specialCharacterCriteriaView = PasswordCriteriaView(text: "special character (e.g. !@#$%^)")
    
    // MARK: - Properties
    
    private var shouldResetCriteria: Bool = true
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
}

// MARK: - Attributed Text Method
extension PasswordStatusView {
    private func makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor] = UIColor.label
        boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
        
        let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))
        
        return attrText
    }
}

// MARK: - Setup UI

extension PasswordStatusView {
    private func setupUI() {
        self.backgroundColor = .tertiarySystemFill
        configurationView()
        
    }
    
    func reset() {
        lengthCriteriaView.reset()
        uppercaseCriteriaView.reset()
        lowerCaseCriteriaView.reset()
        digitCriteriaView.reset()
        specialCharacterCriteriaView.reset()
    }
}

// MARK: - Configuration
extension PasswordStatusView{
    private func configurationView(){
        configurationSubViews()
        configurationStackView()
    }
}

// MARK: - SubViews Configuration
extension PasswordStatusView{
    private func configurationSubViews(){
        self.addSubview(stackView)
        stackView.addArrangedSubviews(lengthCriteriaView,label,uppercaseCriteriaView,lowerCaseCriteriaView,digitCriteriaView,specialCharacterCriteriaView)
    }
}



// MARK: - StackView Configuration
extension PasswordStatusView {
    private func configurationStackView() {
        stackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
        }
    }
}




// MARK: Actions
extension PasswordStatusView {
    func updateDisplay(_ text: String) {
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
 
    
        if shouldResetCriteria {
            // validation (✅ - ⚪️)
            lengthAndNoSpaceMet
            ? lengthCriteriaView.isCriteriaMet = true
            : lengthCriteriaView.reset()
            
            uppercaseMet
            ? uppercaseCriteriaView.isCriteriaMet = true
            : uppercaseCriteriaView.reset()
            
            
            lowercaseMet
            ? lowerCaseCriteriaView.isCriteriaMet = true
            : lowerCaseCriteriaView.reset()
            
            digitMet
            ? digitCriteriaView.isCriteriaMet = true
            : digitCriteriaView.reset()
            
            specialCharacterMet
            ? specialCharacterCriteriaView.isCriteriaMet = true
            : specialCharacterCriteriaView.reset()
            
        }
    }
    
    
    func validate(_ text: String) -> Bool {
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)

        // Ready Player1 🕹
        // Check for 3 of 4 criteria here...
        
        return false
    }
}
