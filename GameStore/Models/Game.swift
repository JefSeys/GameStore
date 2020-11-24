//
//  Game.swift
//  GameStore
//
//  Created by Jef Seys on 22/11/2020.
//

struct Game {
  let name: String
  let fullName: String
  let description: String?

  enum CodingKeys: String, CodingKey {
    case name
    case description
    case fullName = "full_name"
  }
}

// MARK: - Decodable
extension Game: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    fullName = try container.decode(String.self, forKey: .fullName)
    description = try? container.decode(String.self, forKey: .description)
  }
}
