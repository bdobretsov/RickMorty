
import Foundation
import Alamofire

class Network {
    
    static let shared = Network()
    
    private init() {
    }
    
    func getHeroes(completion: @escaping ([Hero]) -> Void) {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
        }
            guard let json = data else { return }
            do {
                let heroes = try JSONDecoder().decode(HeroList.self, from: json).results
                completion(heroes)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getHero(url: String, completion: @escaping (Hero) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
        }
            guard let json = data else { return }
            do {
                let hero = try JSONDecoder().decode(Hero.self, from: json)
                completion(hero)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    public func getImage(fromUrl url: URLConvertible, completion: @escaping (UIImage?) -> Void) {
        AF.request(url).responseData { (response) in
            switch response.result {
            case .success:
                guard let imageData = response.value,
                      let image = UIImage(data: imageData, scale: 1.0)
                else { return }
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
