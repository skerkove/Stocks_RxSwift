//
//  StocksViewModel.swift
//  Stocks_RxSwift
//
//  Created by Scott Kerkove on 3/24/20.
//  Copyright © 2020 Scott Kerkove. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class StocksViewModel{
  
    let detailDataSource: BehaviorRelay<Profile> = BehaviorRelay(value: Profile())
    let dataSource: BehaviorRelay<[StockModel]> = BehaviorRelay(value: [])
    var error : Error?
    let disposeBag = DisposeBag()

  
    public func callAPIFromViewModel(withUrlString : String) {
      
        let disposable = APIHandler.init().callAPIFromApiHandler(withUrlString : withUrlString).subscribe(onNext: { (data) in
        let jsonDcoderObj = JSONDecoder.init()
        do{
            let model = try jsonDcoderObj.decode(StockListModel.self, from: data!)
            self.dataSource.accept(model.mostActiveStock)
        }catch{
          //error
            print("catch1: \(error)")
            self.error = error
        }
        }, onError: { (error) in
            print("onError: \(error)")
            self.error = error
        }, onCompleted: {
            print("Completed")
        }) {
            print("Disposed")
        }
        disposable.disposed(by: disposeBag)
    }
    
    public func callDetailAPIFromViewModel(withUrlString : String) {
      
        let disposable = APIHandler.init().callAPIFromApiHandler(withUrlString : withUrlString).subscribe(onNext: { (data) in
        let jsonDcoderObj = JSONDecoder.init()
            print(withUrlString)
        do{
            let model = try jsonDcoderObj.decode(DetailListModel.self, from: data!)
            self.detailDataSource.accept(model.profile)
        }catch{
          //error
            print("catch2: \(error)")
            self.error = error
        }
        }, onError: { (error) in
            print("onError: \(error)")
            self.error = error
        }, onCompleted: {
            print("Completed")
        }) {
            print("Disposed")
        }
        disposable.disposed(by: disposeBag)
    }
    
    
    
  
}
