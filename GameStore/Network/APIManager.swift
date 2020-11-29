//
//  APIManager.swift
//  GameStore
//
//  Created by Jef Seys on 22/11/2020.
//

import UIKit
import Foundation
import Alamofire
import AuthenticationServices
import SwiftKeychainWrapper

class APIManager {
    var webAuthenticationSession: ASWebAuthenticationSession?
    static let shared = APIManager()
    static var token = ""
    static var gebruikerEmail = ""
    static var isIngelogd = false

    static let sessionManager: Session = {
      let configuration = URLSessionConfiguration.af.default
      configuration.requestCachePolicy = .returnCacheDataElseLoad
      let responseCacher = ResponseCacher(behavior: .modify { _, response in
        let userInfo = ["date": Date()]
        return CachedURLResponse(
          response: response.response,
          data: response.data,
          userInfo: userInfo,
          storagePolicy: .allowed)
      })

      let networkLogger = NetworkLogger()
      let interceptor = RequestInterceptor()

      return Session(
        configuration: configuration,
        interceptor: interceptor,
        cachedResponseHandler: responseCacher,
        eventMonitors: [networkLogger])
    }()
    final var API = ""
    static let header: HTTPHeaders = [
        "Accept": "application/json"
      ]
    
    static func getGames(completion: @escaping ([Game]) -> Void) {
        sessionManager.request(Router.getGames)
      .responseDecodable(of: [Game].self) { response in
        let games = response.value
        completion(games!)
      }
  }
    
    static func loguit(){
        token = ""
        isIngelogd = false
        gebruikerEmail = ""
    }
    
        static func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
            sessionManager.request(Router.login(email, password)).responseString { response in
                let error = response.response?.statusCode
                if error == 201 {
                    token = String(data: response.data!, encoding: .utf8)!
                    isIngelogd = true
                    gebruikerEmail = email
                    completion(true)
                } else {
                    isIngelogd = false
                    completion(false)
                }
            }
        }
    static func registreer(email: String, password: String, voornaam: String, achternaam: String, herhaalwachtwoord: String, completion: @escaping (Bool) -> Void) {
        sessionManager.request(Router.registreer(email, password, voornaam, achternaam, herhaalwachtwoord)).responseString { response in
            let error = response.response?.statusCode
            if error == 201 {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
