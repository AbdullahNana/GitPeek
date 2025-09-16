//
//  Networking.swift
//  GitPeek
//
//  Created by Abdullah Nana  on 2025/09/10.
//

import Foundation

protocol URLSessionProtocol: AnyObject {
    
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
