//
//  CodeSamplesTests.swift
//  FoxNetworkingTests
//
//  Created by Stepan Bezhuk on 20.03.2024.
//

import XCTest
import FoxNetworking

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

func checkSample01() {
  final class ClientDelegate: APIClientDelegate {
    private var accessToken: String = ""
    
    func client(_ client: APIClient, willSendRequest request: inout URLRequest) async throws {
      request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }
    
    func client(_ client: APIClient, shouldRetry task: URLSessionTask, error: Error, attempts: Int) async throws -> Bool {
      if case .unacceptableStatusCode(let statusCode) = error as? APIError,
         statusCode == 401, attempts == 1 {
        accessToken = try await refreshAccessToken()
        return true
      }
      return false
    }
    
    private func refreshAccessToken() async throws -> String {
      fatalError("Not implemented")
    }
  }
}
