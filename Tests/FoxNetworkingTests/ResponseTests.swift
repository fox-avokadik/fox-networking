//
//  ResponseTests.swift
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

final class ResponseTests: XCTestCase {
  func testMapResponse() {
    // GIVEN
    let url = URL(string: "https://api.github.com/user")!
    let response = Response(
      value: "1",
      data: "1".data(using: .utf8)!,
      response: URLResponse(url: url, mimeType: "text", expectedContentLength: 1, textEncodingName: nil),
      task: URLSession.shared.dataTask(with: url)
    )
    
    // WHEN
    let mapped = response.map { Int($0) }
    
    // THEN
    XCTAssertEqual(mapped.value, 1)
  }
}
