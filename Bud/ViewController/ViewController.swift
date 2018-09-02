//
//  ViewController.swift
//  Bud
//
//  Created by Ke Ma on 29/08/2018.
//  Copyright © 2018 Ke Ma. All rights reserved.
//

import UIKit


let CellID = "TransactionTableCell"

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var transactions: [Transaction] = []
    
    var cache: NSCache<AnyObject, AnyObject>!
    
    var imageDownloader: ImageDownloader!
    
    var currencyISO: String! {
        didSet {
            switch currencyISO {
              case "GBP" : currencySymbol = "£"
            default:
                currencySymbol = "$"
            }
        }
    }
    
    var currencySymbol: String!
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        cache = NSCache()
        
        let networkManager = NetworkManager()
        networkManager.getAllTransactions { (transactions, error) in
            if error == nil {
                self.transactions = transactions!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        imageDownloader = ImageDownloader()
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! TransactionTableCell
        cell.titleLabel.text = transactions[indexPath.row].description
        
        cell.icon.layer.cornerRadius = cell.icon.frame.size.height/2
        cell.icon.layer.masksToBounds = true
        cell.icon.layer.borderWidth = 1
        cell.icon.image = nil
        
        currencyISO = transactions[indexPath.row].amount.currencyISO
        
        cell.priceLabel.text = "\(currencySymbol!)\(transactions[indexPath.row].amount.value)"
        
        if cache.object(forKey: indexPath.row as AnyObject) != nil {
            print("Cached image used, no need to download it")
            let cachedUIImage: UIImage = cache.object(forKey: indexPath.row as AnyObject) as! UIImage
            cell.icon.image = cachedUIImage
        } else {
            let iconUrl = URL(string: transactions[indexPath.row].product.icon)
            imageDownloader.exec(iconUrl!) { (data, response, error) in
                if data != nil, error == nil{
                    
                    DispatchQueue.main.async {
                        // If the current cell is visible
                        if let cell = tableView.cellForRow(at: indexPath) as? TransactionTableCell {
                            let img: UIImage! = UIImage(data: data!)
                            cell.icon.image = img
                            self.cache.setObject(img, forKey: (indexPath.row as AnyObject))
                        }
                    }
                }
            }
        }
        
        return cell
    }
}

