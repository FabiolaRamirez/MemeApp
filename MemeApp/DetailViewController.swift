//
//  DetailViewController.swift
//  MemeApp
//
//  Created by Fabiola Ramirez on 8/30/17.
//  Copyright © 2017 Fabiola Ramirez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var meme : Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = meme.memedImage
        
    }


}
