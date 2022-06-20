
import Foundation

struct Hero: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let location: HeroLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}


struct Origin: Codable {
    let name: String
    let url: String
}

struct HeroLocation: Codable {
    let name: String
    let url: String
}

struct HeroList: Codable {
    let results: [Hero]
    let info: Info
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
