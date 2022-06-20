
import UIKit

class CollectionView: UIView {
    
    private enum Constants {
        static let spacing: CGFloat = 16.0
    }
    
    @objc func reloadCollectionView() {
        collectionView.reloadData()
    }
   
    
    private(set) lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private(set) lazy var noResultsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 17)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.08
        label.attributedText = NSMutableAttributedString(string: "No results", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.isHidden = true
        return label
    }()
    
    private(set) lazy var updateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(reloadCollectionView), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var buttonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sync")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupLayouts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        self.addSubview(self.collectionView)
        self.addSubview(self.noResultsLabel)
        self.addSubview(self.buttonImage)
        self.addSubview(self.updateButton)
    }
    
    private func setupLayouts() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.collectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        self.noResultsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.noResultsLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.spacing).isActive = true
        self.noResultsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.updateButton.translatesAutoresizingMaskIntoConstraints = false
        self.updateButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.updateButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        self.buttonImage.translatesAutoresizingMaskIntoConstraints = false
        self.buttonImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.buttonImage.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
    }
}
