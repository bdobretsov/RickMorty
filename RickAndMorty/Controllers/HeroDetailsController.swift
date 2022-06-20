
import UIKit

class HeroDetailsController: UIViewController {
    
    private enum Constants {
        static let sectionCount: Int = 2
        static let cellCount: Int = 4
        static let locationCellIndex: Int = 3
    }
    
    private var heroDetailsView: HeroDetailsView {
        return self.view as! HeroDetailsView
    }
    
    private var hero: Hero
    
    init(hero: Hero) {
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = HeroDetailsView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createHeroDetailsHeaderView()
        self.heroDetailsView.tableView.register(DetailsInformationCell.self, forCellReuseIdentifier: DetailsInformationCell.identifier)
        self.heroDetailsView.tableView.register(HeaderSection.self, forHeaderFooterViewReuseIdentifier: HeaderSection.identifier)
        self.heroDetailsView.tableView.delegate = self
        self.heroDetailsView.tableView.dataSource = self
        self.heroDetailsView.tableView.sectionHeaderTopPadding = 0
        self.heroDetailsView.tableView.sectionFooterHeight = 0
        self.createNavigationTitle()
    }
    
    @objc private func goToBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func createNavigationTitle(){
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = hero.name
        self.navigationController?.navigationBar.backgroundColor = UIColor.lightestGray
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.12
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.kern: -0.24, NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    private func createHeroDetailsHeaderView() {
        self.heroDetailsView.heroDetailsHeaderView.statusLabel.text = hero.status
        self.heroDetailsView.heroDetailsHeaderView.nameLabel.text = hero.name
        self.heroDetailsView.heroDetailsHeaderView.speciesLabel.text = hero.species.uppercased()
        let url = hero.image
        Network.shared.getImage(fromUrl: url) { (image) in
            guard let image = image else { return }
            self.heroDetailsView.heroDetailsHeaderView.avatarImage.image = image
        }
    }
}

extension HeroDetailsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderSection.identifier) as? HeaderSection {
            switch section {
                case 0:
                    header.label.text = "Informations"
                    header.label.textColor = .borisBlue
                case 1:
                    header.label.text = ""
                default:
                    return nil
                }
                return header
            }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 54.5
        case 1:
            return 74.0
        default:
            return 0.0
        }
    }
    
}

extension HeroDetailsController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return Constants.cellCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DetailsInformationCell.identifier, for: indexPath) as? DetailsInformationCell {
                cell.arrowImageView.isHidden = true
                cell.selectionStyle = .none
                switch indexPath.row {
                case 0:
                    cell.label.text = "Name"
                    cell.subLabel.text = self.hero.name
                case 1:
                    cell.label.text = "Location"
                    cell.subLabel.text = self.hero.location.name
                case 2:
                    cell.label.text = "Status"
                    cell.subLabel.text = self.hero.status
                case 3:
                    cell.label.text = "Episodes"
                    let string = self.hero.episode.description
                    cell.subLabel.text = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                    cell.arrowImageView.isHidden = false
                default:
                    break
                }
                return cell
            }
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}
