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

class HomeViewController: UITableViewController {

    // MARK: Properties
    
    @IBOutlet var tblProducts: UITableView!
    var products:[Product] = []     // array of products
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadProducts()
    }
    
    private func loadProducts() {
        let baseURL = "https://raw.githubusercontent.com/abraaoan/iOS-NeemuChallenge/master/challenge.json"
        Alamofire.request(.GET, baseURL).responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                self.products = Mapper<Product>().mapArray(responseData.result.value!["result"]!!["products"])!
                if (self.products.count > 0) {
                    self.tblProducts.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 90.0;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCell
        
        let product = products[indexPath.row]
        let urlPhoto = NSURL(string: product.imageUrl!)
        cell.imgPhoto.sd_setImageWithURL(urlPhoto)
        //cell.imgPhoto.sd_setImageWithURL(urlPhoto, placeholderImage: UIImage(named: "defaultPhoto.png"))
        cell.lblName.text = product.name
        cell.lblPrice.attributedText = convertPriceText(product.price!, lastPrice: product.lastPrice!)

        return cell
    }
    
    private func convertPriceText(currentPrice: String, lastPrice: String) -> NSAttributedString {
        let priceText = lastPrice + " por " + currentPrice
        let attrString: NSMutableAttributedString =  NSMutableAttributedString(string: priceText)
        attrString.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, lastPrice.characters.count))
        
        return attrString
    }
 
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueProductDetail") {
            let indexPath = self.tblProducts.indexPathForSelectedRow!
            let destViewController = segue.destinationViewController as! ProductDetailViewController
            destViewController.product = self.products[indexPath.row]
        }
    }

}
