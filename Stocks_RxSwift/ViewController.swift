//
//  ViewController.swift
//  Stocks_RxSwift
//
//  Created by Scott Kerkove on 3/24/20.
//  Copyright © 2020 Scott Kerkove. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController,UITableViewDelegate {

    
    @IBOutlet weak var stockTableView: UITableView!
    
    var company: StockModel?
    let disposeBag = DisposeBag()
    let viewModel = StocksViewModel()

    override func viewDidLoad() {
      super.viewDidLoad()
        setUpViewBindings()
        setUpSubscription()
        setupCellTapHandling()
        stockTableView.register(UINib(nibName:"StocksTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    func setUpViewBindings() {
      viewModel.dataSource.bind(to: self.stockTableView.rx.items) { (tableView, row, element) in
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? StocksTableViewCell
        if element.changes >= 0 {
            cell?.changesLabel.backgroundColor = UIColor(#colorLiteral(red: 0.1019826904, green: 0.589271605, blue: 0.1472985744, alpha: 1))
        }else{
            cell?.changesLabel.backgroundColor = UIColor.red
        }
        cell?.tickerLabel.text = element.ticker
        cell?.priceLabel.text = element.price
        cell?.changesLabel.text = "\(element.changes)"
        return cell ?? UITableViewCell()
      }
      .disposed(by: self.disposeBag)
    }
    
    func setUpSubscription() {
      callAPI(withUrlString: "https://financialmodelingprep.com/api/v3/stock/actives")
    }

    public func callAPI(withUrlString : String) {
      self.viewModel.callAPIFromViewModel(withUrlString: withUrlString)
      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
 
 
    func setupCellTapHandling() {
        stockTableView.rx.modelSelected(StockModel.self).subscribe{ (companyModel) in
            let vc = self.storyboard?.instantiateViewController(identifier: "StocksDetailViewController") as? StocksDetailViewController
            vc?.subCompanyName = companyModel.element?.companyName
            vc?.subChangesPercentage = companyModel.element?.changesPercentage
            vc?.subPrice = companyModel.element?.price
            vc?.subChanges = companyModel.element?.changes
            vc?.subTicker = companyModel.element?.ticker

            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    
}
