//
//  HomeViewController.swift
//  Challenge
//
//  Created by Fredyson Costa Marques Bentes on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage
import MBProgressHUD
import AlamofireObjectMapper

class HomeViewController: UITableViewController {

    // MARK: Properties
    
    @IBOutlet var tblProducts: UITableView!
    
    var products: [Product] = []
    var loading: MBProgressHUD = MBProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // no empty cells at the end of the table
        tblProducts.tableFooterView = UIView()
        
        // Load the data
        loadProducts()
    }
    
    func loadProducts() {
        let baseURL = "https://raw.githubusercontent.com/abraaoan/iOS-NeemuChallenge/master/challenge.json"
        showLoading()
//        Alamofire.request(baseURL).responseJSON { (responseData) -> Void in
//            hideLoading()
//            if responseData.result.value != nil {
//                self.products = Mapper<Product>().mapArray(responseData.result.value!["result"]!!["products"])!
//                if self.products.count > 0 {
//                    self.tblProducts.reloadData()
//                }
//            }
//        }
        print("Before request")
        Alamofire.request(baseURL).responseArray { (response: DataResponse<[Product]>) in
            self.hideLoading()
            let productArray = response.result.value
            if let productArray = productArray {
                for product in productArray {
                    self.products.append(product)
                    print(product.name ?? "Name empty")
                    print(product.description ?? "Description empty")
                }
                self.tblProducts.reloadData()
            }
        }
    }
    
    func showLoading() {
        loading = MBProgressHUD.showAdded(to: self.view, animated: true)
        loading.mode = MBProgressHUDMode.indeterminate
        loading.label.text = "Carregando..."
    }
    
    func hideLoading() {
        loading.hide(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        headerCell.lblHeader.text = "Games para PS4"
        
        return headerCell
    }
    
    // Override to support custom table view cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0;
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        // Fetches the appropriate product for the data source layout
        let product = products[indexPath.row]
        cell.lblName.text = product.name
        
        // load photo from url
        let urlPhoto = URL(string: product.imageUrl!)
        cell.imgPhoto.sd_setImage(with: urlPhoto, placeholderImage: UIImage(named: "defaultPhoto.png"))
        
        // format text of prices label
        let priceText = product.lastPrice! + " por " + product.price!
        cell.lblPrice.attributedText = StringUtils.strikeSubText(priceText, length: product.lastPrice!.characters.count)

        return cell
    }
 
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueProductDetail" {
            let indexPath = tblProducts.indexPathForSelectedRow!
            let destViewController = segue.destination as! ProductDetailViewController
            destViewController.product = products[indexPath.row]
        }
    }

}
