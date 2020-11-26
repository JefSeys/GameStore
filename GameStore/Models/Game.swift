//
//  Game.swift
//  GameStore
//
//  Created by Jef Seys on 22/11/2020.
//

struct Game {
  let name: String
    let price: Double
  let description: String
    let rating: Int
    let base64Img: String

  enum CodingKeys: String, CodingKey {
    case name
    case price
    case description
    case rating
    case base64Img
  }
}

// MARK: - Decodable
extension Game: Decodable {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    name = try container.decode(String.self, forKey: .name)
    price = try container.decode(Double.self, forKey: .price)
    description = try container.decode(String.self, forKey: .description)
    rating = try container.decode(Int.self, forKey: .rating)
    base64Img = try container.decode(String.self, forKey: .base64Img)
  }
}
