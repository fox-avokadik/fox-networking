//
//  Helpers.swift
//  FoxNetworkingTests
//
//  Created by Stepan Bezhuk on 20.03.2024.
//

import XCTest
import FoxNetworking

extension APIClientClient {
  static func mock(_ configure: (inout APIClientClient.Configuration) -> Void = { _ in }) -> APIClientClient {
    APIClientClient(baseURL: URL(string: "https://api.github.com")) {
      $0.sessionConfiguration.protocolClasses = [MockingURLProtocol.self]
      $0.sessionConfiguration.urlCache = nil
      configure(&$0)
    }
  }
}


func json(named name: String) -> Data {
  let url = Bundle.main.url(forResource: name, withExtension: "json")
  return try! Data(contentsOf: url!)
}

extension Mock {
  static func get(url: URL, json name: String) -> Mock {
    Mock(url: url, dataType: .json, statusCode: 200, data: [
      .get: json(named: name)
    ])
  }
}

extension InputStream {
  var data: Data {
    open()
    let bufferSize: Int = 1024
    let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
    var data = Data()
    while hasBytesAvailable {
      let readDat = read(buffer, maxLength: bufferSize)
      data.append(buffer, count: readDat)
    }
    buffer.deallocate()
    close()
    return data
  }
}
