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

class HomeViewController: UITableViewController {

    // MARK: Properties
    
    @IBOutlet var tblProducts: UITableView!
    
    var products: [Product] = []
    
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
        Alamofire.request(.GET, baseURL).responseJSON { (responseData) -> Void in
            self.hideLoading()
            if responseData.result.value != nil {
                self.products = Mapper<Product>().mapArray(responseData.result.value!["result"]!!["products"])!
                if self.products.count > 0 {
                    self.tblProducts.reloadData()
                }
            }
        }
    }
    
    func showLoading() {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "Carregando..."
    }
    
    func hideLoading() {
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderCell
        headerCell.lblHeader.text = "Games para PS4"
        
        return headerCell
    }
    
    // Override to support custom table view cell height
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90.0;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCell
        
        // Fetches the appropriate product for the data source layout
        let product = products[indexPath.row]
        cell.lblName.text = product.name
        
        // load photo from url
        let urlPhoto = NSURL(string: product.imageUrl!)
        cell.imgPhoto.sd_setImageWithURL(urlPhoto, placeholderImage: UIImage(named: "defaultPhoto.png"))
        
        // format text of prices label
        let priceText = product.lastPrice! + " por " + product.price!
        cell.lblPrice.attributedText = StringUtils.strikeSubText(priceText, length: product.lastPrice!.characters.count)

        return cell
    }
 
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueProductDetail" {
            let indexPath = tblProducts.indexPathForSelectedRow!
            let destViewController = segue.destinationViewController as! ProductDetailViewController
            destViewController.product = products[indexPath.row]
        }
    }

}
