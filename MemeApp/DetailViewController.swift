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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
