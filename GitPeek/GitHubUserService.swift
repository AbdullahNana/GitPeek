import Foundation

final class GitHubUserService {
    
    private var urlSession: URLSessionProtocol
    
    enum GitHubError: LocalizedError {
        
        case emptyUsername
        case invalidURL
        case invalidResponse
        case userNotFound
        case networkError(statusCode: Int)
        case decodingError
        case noInternet

        var errorDescription: String? {
            
            switch self {
            case .emptyUsername:
                return NSLocalizedString("error_empty_username", comment: "")
            case .invalidURL:
                return NSLocalizedString("error_invalid_url", comment: "")
            case .invalidResponse:
                return NSLocalizedString("error_invalid_response", comment: "")
            case .userNotFound:
                return NSLocalizedString("error_user_not_found", comment: "")
            case .networkError:
                return NSLocalizedString("error_network", comment: "")
            case .decodingError:
                return NSLocalizedString("error_parse", comment: "")
            case .noInternet:
                return NSLocalizedString("error_no_internet", comment: "")
            }
        }
    }
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchUser(username: String) async throws -> GitHubUser {
        guard !username.isEmpty else { throw GitHubError.emptyUsername }
        guard let url = URL(string: Constants.githubUserBaseURL + username) else { throw GitHubError.invalidURL }

        do {
            let (data, response) = try await urlSession.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw GitHubError.invalidResponse
            }

            switch httpResponse.statusCode {
            case 200:
                do {
                    return try JSONDecoder().decode(GitHubUser.self, from: data)
                } catch {
                    throw GitHubError.decodingError
                }

            case 404:
                throw GitHubError.userNotFound

            default:
                throw GitHubError.networkError(statusCode: httpResponse.statusCode)
            }
        } catch {
            if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                throw GitHubError.noInternet
            }
            throw error
        }
    }

}

class GitHubUserInteractor {
    
    private let service: GitHubUserService
    
    init(service: GitHubUserService) {
        self.service = service
    }
    
    func fetchUser(username: String) async throws -> GitHubUser {
        return try await service.fetchUser(username: username)
    }
}
