//
//  ProductDetailViewController.swift
//  Challenge
//
//  Created by Fredyson Costa Marques Bentes on 20/07/16.
//  Copyright © 2016 home. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet var lblName: UILabel!
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblName.text = product?.name;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
