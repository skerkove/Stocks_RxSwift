//
//  StocksDetailViewController.swift
//  Stocks_RxSwift
//
//  Created by Scott Kerkove on 3/25/20.
//  Copyright © 2020 Scott Kerkove. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class StocksDetailViewController: UIViewController {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var ceoLabel: UILabel!
    
    let viewModel = StocksViewModel()
    let disposeBag = DisposeBag()
    
    
    
    var subCompanyName: String?
    var subChangesPercentage: String?
    var subPrice: String?
    var subChanges: Double?
    var subTicker: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpSubscription()
        setUpViewBindings()
        setUpDetails()
    }
    
    func setUpDetails() {
        companyNameLabel.text = subCompanyName
//        bottomCompanyNameLabel.text = subCompanyName
        tickerLabel.text = subTicker
        priceLabel.text = "Current Price:    \(subPrice ?? "no value")"
        changeLabel.text = "Change:    \(subChanges ?? 0) \(subChangesPercentage ?? "0")"
        
        let url = URL(string: "https://financialmodelingprep.com/images-New-jpg/\(subTicker ?? "not working").jpg")
        print(url ?? "no url")
        companyLogo.sd_setImage(with: url, completed: nil)
    }
    
    func setUpSubscription() {
        callAPI(withUrlString: "https://financialmodelingprep.com/api/v3/company/profile/\(subTicker ?? "detail Api Not working")")
        
    }

    public func callAPI(withUrlString : String) {
      self.viewModel.callDetailAPIFromViewModel(withUrlString: withUrlString)
      }
    
    func setUpViewBindings() {
        let disposable = viewModel.detailDataSource.subscribe(onNext: { (profile) in
            DispatchQueue.main.async {
                self.ceoLabel.text = "CEO:    \(profile.ceo ?? "unknown")"
                self.descLabel.text = profile.description
            }
            print(profile)

        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("Completed")
        })
        disposable.disposed(by: disposeBag)
            
    }

}

