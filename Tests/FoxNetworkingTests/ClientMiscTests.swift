//
//  ClientMiscTests.swift
//  FoxNetworkingTests
//
//  Created by Stepan Bezhuk on 20.03.2024.
//

import XCTest
@testable import FoxNetworking

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class ClientMiscTests: XCTestCase {
  /// Making sure all expected APIs compile
  func testClientInit() {
    _ = APIClientClient(baseURL: nil)
    _ = APIClientClient(baseURL: URL(string: "https://api.github.com"))
    _ = APIClientClient(baseURL: URL(string: "https://api.github.com")) {
      $0.sessionConfiguration.httpAdditionalHeaders = ["x-test": "1"]
    }
    _ = APIClientClient(configuration: .init(baseURL: URL(string: "https://api.github.com")))
  }
  
  func testThatActorCanImplementClientDelegate() {
    actor ClientDelegate: APIClientDelegate {
      var value = 0
      
      func client(_ client: APIClientClient, willSendRequest request: inout URLRequest) async throws {
        _ = value
      }
      
      func client(_ client: APIClientClient, shouldRetry task: URLSessionTask, error: Error, attempts: Int) async throws -> Bool {
        _ = value
        return false
      }
      
      // I think this is acceptable that these two methods have to be nonisolated.
      nonisolated func client(_ client: APIClientClient, makeURLFor url: String, query: [(String, String?)]?) throws -> URL? {
        // _ = value – this won't compile
        return URL(string: url)
      }
      
      nonisolated func client(_ client: APIClientClient, validateResponse response: HTTPURLResponse, data: Data, task: URLSessionTask) throws {
        // _ = value – this won't compile
      }
    }
  }
}
