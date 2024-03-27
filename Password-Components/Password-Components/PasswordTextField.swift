//
//  PasswordTextField.swift
//  Password-Components
//
//  Created by Baran Baran on 21.03.2024.
//


import UIKit


protocol PasswordTextFieldDelegate: AnyObject {
    func editingChanged(_ sender : PasswordTextField)
    func editingDidEnd(_ sender: PasswordTextField)
}


final class PasswordTextField: UIView {
    
    // MARK: - Properties
    /**
     Metin alanını özel olarak doğrulamak için iletilen bir işlev.
     
     - Parameter textValue: Doğrulanacak metnin değeri
     - Returns: Metnin geçerli olup olmadığını ve değilse bir hata mesajı içeren bir Tuple döndürür.
     */
    typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
    
    private var views : [UIView] = []
    private let placeHolderText : String
    
    var customValidation: CustomValidation?
    
    weak var delegate : PasswordTextFieldDelegate?
    
    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    
    
    // MARK: - UI Elements
    private lazy var lockImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "lock.fill")
        return img
    }()
    
    lazy var textField : UITextField = {
        let tf = UITextField()
        tf.placeholder = placeHolderText
        tf.isSecureTextEntry = false
        tf.keyboardType = .asciiCapable
        tf.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        tf.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return tf
    }()
    
    private lazy var eyeButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        btn.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        btn.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        return btn
    }()
    
    private lazy var divider : UIView = {
        let dvr = UIView()
        dvr.backgroundColor = .separator
        return dvr
    }()
    
    
    private lazy var errorLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Your password must meet the requirement below "
        lbl.textColor = .systemRed
        lbl.font = UIFont.preferredFont(forTextStyle: .footnote)
        //        lbl.adjustsFontSizeToFitWidth = true // metin boyutunun otomatik küçültür
        //        lbl.minimumScaleFactor = 0.8 //metin genişliğe sığdırılamazsa, bu oran kullanılır.
        lbl.numberOfLines = 0 // fazla satır kullanılmasına izin verir
        lbl.lineBreakMode = .byWordWrapping //Metin boyutu etiket boyutunu aşarsa, kelime sınırlarında bir sonraki satıra geçmesini sağlar.
        
        lbl.isHidden = true
        return lbl
    }()
    
    
    
    // MARK: - İnitialization
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        super.init(frame: .zero)
        setupUI()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 60)
    }
}

// MARK: - Setup UI

extension PasswordTextField {
    private func setupUI() {
        configuration()
        
    }
}

// MARK: - Configuration

extension PasswordTextField {
    private func configuration() {
        configureSubviews()
        configurationLockImage()
        configurationTextField()
        configurationEyeButton()
        configurationDivider()
        configurationError()
        configurationCHCR()
        
    }
    
    private func configureSubviews(){
        views = [lockImage, textField,eyeButton,divider,errorLabel]
        self.addSubviews(views)
    }
}



extension PasswordTextField {
    private func configurationLockImage(){
        lockImage.snp.makeConstraints { make in
            make.centerY.equalTo(textField.snp.centerY)
            make.leading.equalToSuperview()
        }
    }
    
    private func configurationTextField(){
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(lockImage.snp.trailing).offset(8)
        }
    }
    
    private func configurationEyeButton(){
        eyeButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField.snp.centerY)
            make.trailing.equalToSuperview()
            make.leading.equalTo(textField.snp.trailing).offset(8)
        }
    }
    
    private func configurationDivider(){
        divider.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.height.equalTo(1)
        }
    }
    
    private func configurationError(){
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
    }
    
}


extension PasswordTextField {
    // CHCR
    private func configurationCHCR(){
        lockImage.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
}

// MARK: - Actions
extension PasswordTextField{
    @objc func togglePasswordView(_ sender: Any){
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    @objc func textFieldEditingChanged(_ sender : UITextField){
        delegate?.editingChanged(self)
    }
}



// MARK: - UITextFieldDelegate
extension PasswordTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(self)
    }
    
    // Called when 'return' key pressed. Necessary for dismissing keyboard.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("foo - textFieldShouldReturn")
        textField.endEditing(true) // resign first responder
        return true
    }
}




// MARK: - Validation
// typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?

extension PasswordTextField {
    func validate() -> Bool {
        if let customValidation = customValidation,
            let customValidationResult = customValidation(text),
            customValidationResult.0 == false {
            showError(customValidationResult.1)
            return false
        }
        clearError()
        return true
    }
    
    private func showError(_ errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }

    private func clearError() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
}
