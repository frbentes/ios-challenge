//
//  HomeViewController.swift
//  Challenge
//
//  Created by Fredyson Costa Marques Bentes on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UITableViewController {

    @IBOutlet var tblProducts: UITableView!
    var products = [[String:AnyObject]]() // array of products
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadProducts()
    }
    
    private func loadProducts() {
        let baseURL = "https://raw.githubusercontent.com/abraaoan/iOS-NeemuChallenge/master/challenge.json"
        Alamofire.request(.GET, baseURL).responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                let resJson = JSON(responseData.result.value!)
                
                if let productsData = resJson["result"]["products"].arrayObject {
                    self.products = productsData as! [[String:AnyObject]]
                }
                
                print(self.products)
                
                if (self.products.count > 0) {
                    self.tblProducts.reloadData()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath)
        
        var dict = products[indexPath.row]
        cell.textLabel?.text = dict["name"] as? String

        return cell
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
