import UIKit
import SnapKit

final class PasswordCriterialView2: UIView {
    
    // MARK: - UI Elements
    
    private let stackView : UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal // Yatay stack view oluşturuyoruz.
        sv.spacing = 8
        sv.alignment = .center
        // Öğeleri ortalamak için stack view'in hizalama stilini ayarlıyoruz.
        return sv
    }()
    
    private let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "circle")?.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
        return iv
    }()
    
    private let label : UILabel = {
        let lbl  = UILabel()
        lbl.text = "Uppercase letter (A-Z)"
        lbl.textColor = .secondaryLabel
        lbl.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return lbl
    }()
    
    // MARK: - İnitialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        backgroundColor = .orange
        addSubview(stackView)
        setupConstraints()
        setupImageView()
        setupLabel()
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupImageView() {
        stackView.addArrangedSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(20) // Sabit bir genişlik atıyoruz, isteğe bağlı olarak değiştirebilirsiniz.
            make.height.equalTo(imageView.snp.width)
        }
    }
    
    private func setupLabel() {
        stackView.addArrangedSubview(label)
    }
}

