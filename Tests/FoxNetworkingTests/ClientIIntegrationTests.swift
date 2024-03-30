//
//  ClientIIntegrationTests.swift
//  FoxNetworkingTests
//
//  Created by Stepan Bezhuk on 20.03.2024.
//

import XCTest
@testable import FoxNetworking

final class APIClientIntegrationTests: XCTestCase {
  
  func _testGitHubUsersApi() async throws {
    let client = APIClientClient.mock()
    let user = try await client.send(Paths.users("kean").get).value
    XCTAssertEqual(user.login, "kean")
  }
}
