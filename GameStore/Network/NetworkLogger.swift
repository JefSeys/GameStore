//
//  NetworkLogger.swift
//  GameStore
//
//  Created by Jef Seys on 24/11/2020.
//


import Foundation
import Alamofire

// print json objecten uit, ook errors van backend
class NetworkLogger: EventMonitor {
    init(){}
  let queue = DispatchQueue(label: "com.jefseys.gamestore.networklogger")

  func requestDidFinish(_ request: Request) {
    print(request.description)
  }

  func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
    guard let data = response.data else {
      return
    }
    
    // print json
    if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
      print(json)
    }
  }
}
