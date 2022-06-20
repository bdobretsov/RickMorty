
import UIKit

class HeroViewController: UIViewController {
    
    private enum Constants {
        static let spacing: CGFloat = 16.0
        static let heightCardDescription: CGFloat = 79.0
        static let itemsInRow: CGFloat = 2.0
    }
    
    private var heroView: CollectionView {
        return self.view as! CollectionView
    }
    
    private var heroes = [Hero]()
    private var heroesImage = [UIImage]()
    
    override func loadView() {
        super.loadView()
        self.view = CollectionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.heroView.collectionView.register(HeroesCollectionViewCell.self, forCellWithReuseIdentifier: HeroesCollectionViewCell.identifier)
        self.heroView.collectionView.dataSource = self
        self.heroView.collectionView.delegate = self
        
        Network.shared.getHeroes() { [weak self] (heroes) in
            guard let self = self else {return}
            heroes.forEach({
                Network.shared.getImage(fromUrl: $0.image) { (image) in
                    guard let image = image else { return }
                    DispatchQueue.main.async {
                        self.heroesImage.append(image)
                        self.heroView.collectionView.reloadData()
                    }
                }
            })
            DispatchQueue.main.async {
                self.heroes = heroes
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.title = "Character"
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightestGray
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.01
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.kern: 0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 34) ]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
    }
}

extension HeroViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.heroesImage.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroesCollectionViewCell.identifier, for: indexPath) as! HeroesCollectionViewCell
        cell.nameLabel.text = self.heroes[indexPath.row].name
        cell.statusLabel.text = self.heroes[indexPath.row].status
        cell.locationLabel.text = self.heroes[indexPath.row].location.name
        cell.heroImageView.image = self.heroesImage[indexPath.row]
        return cell
    }
}

extension HeroViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let heroDetailsController = HeroDetailsController(hero: self.heroes[indexPath.row])
        navigationController?.pushViewController(heroDetailsController, animated: true)
    }
}

extension HeroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: self.view.frame.width, spacing: Constants.spacing)
        return CGSize(width: width, height: width + Constants.heightCardDescription)
    }

    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let totalSpacing: CGFloat = Constants.itemsInRow * spacing + (Constants.itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / Constants.itemsInRow
        return floor(finalWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
}
