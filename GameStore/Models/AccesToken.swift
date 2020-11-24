//
//  AccesToken.swift
//  GameStore
//
//  Created by Jef Seys on 22/11/2020.
//

struct AccesToken {
  let token: String

  enum CodingKeys: String, CodingKey {
    case token
  }
}

// MARK: - Decodable
extension AccesToken: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    token = try container.decode(String.self, forKey: .token)
  }
}
