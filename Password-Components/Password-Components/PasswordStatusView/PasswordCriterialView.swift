import UIKit
import SnapKit

final class PasswordCriteriaView: UIView {
    
    // MARK: - UI Elements
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle")?.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    
    private lazy var  checkmarkImage = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    private lazy var  xmarkImage = UIImage(systemName: "xmark.circle")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    private lazy var  circleImage = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
    
     var isCriteriaMet: Bool = false {
        didSet{
            if isCriteriaMet {
                imageView.image = checkmarkImage
            } else {
                imageView.image = xmarkImage
            }
        }
    }
    
     func reset(){
        isCriteriaMet = false
        imageView.image = circleImage
}
    
    // MARK: - Initialization
    
    init(text: String) {
        super.init(frame: .zero)
        self.label.text = text
        setupUI()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 40)
    }
    
}

// MARK: - Setup UI
extension PasswordCriteriaView{
    private func setupUI() {
        configureView()
    }
}


// MARK: - Configuration
extension PasswordCriteriaView{
    private func configureView() {
        configureSubviews()
        configureStackView()
        configureImageView()
        configureContentHugging()
    }
}

// MARK: - Subviews Configuration
extension PasswordCriteriaView{
    private func configureSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubviews(imageView, label)
    }
}

// MARK: - Content Hugging Configuration
extension PasswordCriteriaView{
    private func configureContentHugging() {
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}


// MARK: - StackView Configuration
extension PasswordCriteriaView{
    private func configureStackView() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - ImageView Configuration
extension PasswordCriteriaView{
    private func configureImageView() {
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
        }
    }
}


