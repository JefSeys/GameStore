//
//  RequestInterceptor.swift
//  GameStore
//
//  Created by Jef Seys on 22/11/2020.
//
import Alamofire
import SwiftKeychainWrapper

class RequestInterceptor: Alamofire.RequestInterceptor {
    
    init(){}
  //1
  let retryLimit = 5
  let retryDelay: TimeInterval = 10
  //2
  func adapt(
    _ urlRequest: URLRequest,
    for session: Session,
    completion: @escaping (Result<URLRequest, Error>) -> Void
  ) {
    var urlRequest = urlRequest
    if let token = KeychainWrapper.standard.string(forKey: "token"){
      urlRequest.setValue("token \(token)", forHTTPHeaderField: "Authorization")
    }
    completion(.success(urlRequest))
  }
  //3
  func retry(
    _ request: Request,
    for session: Session,
    dueTo error: Error,
    completion: @escaping (RetryResult) -> Void
  ) {
    let response = request.task?.response as? HTTPURLResponse
    //Retry for 5xx status codes
    if
      let statusCode = response?.statusCode,
      (500...599).contains(statusCode),
      request.retryCount < retryLimit {
        completion(.retryWithDelay(retryDelay))
    } else {
      return completion(.doNotRetry)
    }
  }
}
