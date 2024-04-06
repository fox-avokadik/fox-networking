//
//  File.swift
//  
//
//  Created by Stepan Bezhuk on 06.04.2024.
//

import Foundation

public struct APIErrorModel: Decodable, Error {
  let message: String
  let code: String
}
