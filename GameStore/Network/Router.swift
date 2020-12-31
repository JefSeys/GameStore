//
//  Router.swift
//  GameStore
//
//  Created by Jef Seys on 24/11/2020.
//
import UIKit
import Alamofire

extension Router: URLRequestConvertible {
  func asURLRequest() throws -> URLRequest {
    //2
    let url = try baseURL.asURL().appendingPathComponent(path)
    var request = URLRequest(url: url)
    request.method = method
    //3
    if method == .get {
      request = try URLEncodedFormParameterEncoder()
        .encode(parameters, into: request)
    } else if method == .post {
      request = try JSONParameterEncoder().encode(parameters, into: request)
      request.setValue("application/json", forHTTPHeaderField: "Accept")
    }
    return request
  }
}

enum Router {
  case getGames
  case login(String, String)
    case registreer(String, String, String, String, String)

  var baseURL: String {
      return "http://192.168.0.143:45455/api/"
  }

  var path: String {
    switch self {
    case .login:
      return "Account"
    case .getGames:
      return "Games"
    case.registreer:
    return "Account/register"
    }
  }

  var method: HTTPMethod {
    switch self {
    case .login, .registreer:
      return .post
    case .getGames:
      return .get
    }
  }

  var parameters: [String: String]? {
    switch self {
    case .login(let email, let password):
        return ["email": email, "password": password]
    case .getGames:
        return nil
    case .registreer(let email, let wachtwoord, let voornaam, let achternaam, let herhaalwachtwoord):
        return ["email": email, "password": wachtwoord, "firstName": voornaam, "lastName": achternaam, "passwordConfirmation": herhaalwachtwoord]
    }
  }
}
