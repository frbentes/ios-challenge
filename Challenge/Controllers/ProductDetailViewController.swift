//
//  ProductDetailViewController.swift
//  Challenge
//
//  Created by Fredyson Costa Marques Bentes on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    // MARK: Properties
    
    @IBOutlet var imgPhoto: UIImageView!
    @IBOutlet var btnBuy: UIButton!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblLastPrice: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var vwRating: RatingControl!
    @IBOutlet var txtDescription: UITextView!
    
    /*
     This value is passed by `HomeViewController` in `prepareForSegue(_:sender:)`
     */
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnBuy.layer.cornerRadius = 6   // button with rounded corners
        
        setupViews()
    }
    
    func setupViews() {
        lblName.text = product?.name
        lblLastPrice.attributedText = StringUtils.strikeText((product?.lastPrice)!)
        lblPrice.text = product?.price
        vwRating.rating = Int((product?.rating)!)!
        txtDescription.text = product?.description
        
        // load photo
        let urlImage = NSURL(string: (product?.imageUrl)!)
        imgPhoto.sd_setImageWithURL(urlImage, placeholderImage: UIImage(named: "defaultPhoto.png"))
    }
    
    @IBAction func goToStore(sender: AnyObject) {
        let productUrl = NSURL(string: (product?.link)!)
        UIApplication.sharedApplication().openURL(productUrl!)
    }

}
