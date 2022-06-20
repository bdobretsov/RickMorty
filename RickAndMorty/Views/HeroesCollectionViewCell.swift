import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

class HeroesCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let spacing: CGFloat = 12.0
        static let borderWidth: CGFloat = 1.0
        static let radius: CGFloat = 8.0
    }
    
    private(set) lazy var heroImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.90
        label.attributedText = NSMutableAttributedString(string: "Summer Smith", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 11)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        label.attributedText = NSMutableAttributedString(string: "Dead", attributes: [NSAttributedString.Key.kern: 0.07, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private(set) lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 11)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.99
        label.attributedText = NSMutableAttributedString(string: "Dead", attributes: [NSAttributedString.Key.kern: 0.07, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.borderWidth = Constants.borderWidth
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = Constants.radius
        self.contentView.backgroundColor = .white

        self.contentView.addSubview(self.heroImageView)
        self.contentView.addSubview(self.statusLabel)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.locationLabel)
    }
    
    
    private func setupLayouts() {
        self.heroImageView.translatesAutoresizingMaskIntoConstraints = false
        self.heroImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        self.heroImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        self.heroImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        self.statusLabel.translatesAutoresizingMaskIntoConstraints = false
        self.statusLabel.topAnchor.constraint(equalTo: self.heroImageView.bottomAnchor, constant: Constants.spacing).isActive = true
        self.statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing).isActive = true
        self.statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor).isActive = true
        self.nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing).isActive = true
        self.nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.spacing).isActive = true
        
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.locationLabel.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: Constants.borderWidth).isActive = true
        self.locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing).isActive = true
        self.locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}

extension HeroesCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}


