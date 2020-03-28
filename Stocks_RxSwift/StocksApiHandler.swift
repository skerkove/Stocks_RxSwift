//
//  StocksApiHandler.swift
//  Stocks_RxSwift
//
//  Created by Scott Kerkove on 3/24/20.
//  Copyright © 2020 Scott Kerkove. All rights reserved.
//

import Foundation
import RxSwift


class APIHandler{
  
  public func callAPIFromApiHandler(withUrlString : String) -> Observable<Data?> {
      Observable<Data?>.create { observer  in
            URLSession.shared.dataTask(with: URL(string: withUrlString)!) { (data, response, error) in
                observer.onNext(data)
            if error != nil {
                observer.onError(error!)
            }
            observer.onCompleted()
            }.resume()
            let disposable = Disposables.create()
            return disposable
        
      }
  }
    
}
