import UIKit

class DetailsInformationCell: UITableViewCell {
    
    private(set) lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(string: "Gender", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
  
    
    private(set) lazy var subLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 15)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        label.attributedText = NSMutableAttributedString(string: "Male", attributes: [NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private(set) lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "arrow")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupLayouts()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupViews() {
        self.contentView.addSubview(self.label)
        self.contentView.addSubview(self.subLabel)
        self.contentView.addSubview(self.arrowImageView)
    }
    
    private func setupLayouts() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.5).isActive = true
        self.label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        
        self.subLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subLabel.topAnchor.constraint(equalTo: self.label.bottomAnchor).isActive = true
        self.subLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        self.subLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.5).isActive = true
        
        self.arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        self.arrowImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 23.0).isActive = true
        self.arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -18.0).isActive = true
        self.arrowImageView.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
        self.arrowImageView.widthAnchor.constraint(equalToConstant: 13.0).isActive = true
    }
}

extension DetailsInformationCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
