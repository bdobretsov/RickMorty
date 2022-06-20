
import UIKit

class TabBarController: UITabBarController {
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.tabBar.tintColor = .borisBlue
        self.viewControllers = createViewControllers()
        self.selectedIndex = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func createViewControllers() -> [UIViewController] {
        var controllers = [UIViewController]()
        
        let heroesViewController = HeroViewController()
        heroesViewController.tabBarItem = UITabBarItem(title: "Hero", image: UIImage(named: "finn"), selectedImage: UIImage(named: "finn.fill"))
        let heroesNavigationController = UINavigationController(rootViewController: heroesViewController)
        controllers.append(heroesNavigationController)
        
        return controllers
    }
}
