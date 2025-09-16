import Foundation

struct GitHubUser: Codable, Equatable {
    
    let login: String
    let name: String?
    let avatar_url: String
    let bio: String?
    let public_repos: Int
    let followers: Int
}
