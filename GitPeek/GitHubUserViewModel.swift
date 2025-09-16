//
//  GitHubUserViewModel.swift
//  GitPeek
//
//  Created by Abdullah Nana  on 2025/09/10.
//

import Foundation
import SwiftUI

final class GitHubUserViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var user: GitHubUser?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let interactor: GitHubUserInteractor
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        let service = GitHubUserService(urlSession: urlSession)
        self.interactor = GitHubUserInteractor(service: service)
    }
    
    func fetchUser() async {
        isLoading = true
        errorMessage = nil
        user = nil
        do {
            let user = try await interactor.fetchUser(username: username)
            self.user = user
            self.errorMessage = nil
        } catch {
            if let localizedError = error as? LocalizedError, let description = localizedError.errorDescription {
                self.errorMessage = description
            } else {
                self.errorMessage = error.localizedDescription
            }
            self.user = nil
        }
        isLoading = false
    }
}
