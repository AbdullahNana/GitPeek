//
//  GitPeekTests.swift
//  GitPeek
//
//  Created by Abdullah Nana  on 2025/09/10.
//

import XCTest
@testable import GitPeek

class MockURLSession: URLSessionProtocol {
    
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = mockError { throw error }
        guard let data = mockData, let response = mockResponse else {
            throw NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No data or response"])
        }
        return (data, response)
    }
}

final class GitHubUserViewModelAsyncTests: XCTestCase {
    
    func makeViewModel(data: Data?, response: URLResponse?, error: Error?) -> GitHubUserViewModel {
        let mockSession = MockURLSession()
        mockSession.mockData = data
        mockSession.mockResponse = response
        mockSession.mockError = error
        return GitHubUserViewModel(urlSession: mockSession)
    }

    func testEmptyUsernameSetsError() async {
        let vm = makeViewModel(data: nil, response: nil, error: nil)
        vm.username = ""
        await vm.fetchUser()
        XCTAssertEqual(vm.errorMessage, NSLocalizedString("error_empty_username", comment: ""))
        XCTAssertNil(vm.user)
        XCTAssertFalse(vm.isLoading)
    }

    func testUserNotFoundSetsError() async {
        let response = HTTPURLResponse(url: URL(string: "https://api.github.com/users/unknown")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        let vm = makeViewModel(data: Data(), response: response, error: nil)
        vm.username = "unknown"
        await vm.fetchUser()
        XCTAssertEqual(vm.errorMessage, NSLocalizedString("error_user_not_found", comment: ""))
        XCTAssertNil(vm.user)
    }

    func testNetworkErrorSetsError() async {
        let error = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Test error"])
        let vm = makeViewModel(data: nil, response: nil, error: error)
        vm.username = "octocat"
        await vm.fetchUser()
        XCTAssertTrue(vm.errorMessage?.contains("Test error") ?? false)
        XCTAssertNil(vm.user)
    }

    func testValidUserResponseSetsUser() async throws {
        let user = GitHubUser(login: "AbdullahNana", name: "Abdullah", avatar_url: "", bio: "Test bio", public_repos: 8, followers: 100)
        let data = try JSONEncoder().encode(user)
        let response = HTTPURLResponse(url: URL(string: "https://api.github.com/users/AbdullahNana")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let vm = makeViewModel(data: data, response: response, error: nil)
        vm.username = "AbdullahNana"
        await vm.fetchUser()
        XCTAssertNil(vm.errorMessage)
        XCTAssertNotNil(vm.user)
        XCTAssertEqual(vm.user?.login, "AbdullahNana")
        XCTAssertEqual(vm.user?.name, "Abdullah")
        XCTAssertEqual(vm.user?.bio, "Test bio")
        XCTAssertEqual(vm.user?.public_repos, 8)
        XCTAssertEqual(vm.user?.followers, 100)
    }
    
    func testNoInternetConnectionSetsError() async {
        let urlError = URLError(.notConnectedToInternet)
        let vm = makeViewModel(data: nil, response: nil, error: urlError)
        vm.username = "octocat"
        await vm.fetchUser()
        XCTAssertEqual(vm.errorMessage, NSLocalizedString("error_no_internet", comment: ""))
        XCTAssertNil(vm.user)
        XCTAssertFalse(vm.isLoading)
    }
}
