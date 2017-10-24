//
//  MemeTableViewController.swift
//  MemeApp
//
//  Created by Fabiola Ramirez on 4/11/17.
//  Copyright © 2017 Fabiola Ramirez. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController {
    
    
    @IBOutlet weak var flowLayout: UITableView!
    var memes: [Meme]!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.flowLayout.delegate = self
        self.flowLayout.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memes = appDelegate.memes
        self.flowLayout.reloadData()
    }
    
    
    @IBAction func addMeme(_ sender: Any) {
        
        let viewController : MemeEditorViewController? = self.storyboard?.instantiateViewController(withIdentifier: "memeEditorViewController") as? MemeEditorViewController
        let navigationController : UINavigationController = UINavigationController(rootViewController: viewController!)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
}


extension MemeTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return memes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = flowLayout.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        let itemImage : UIImageView? = cell.contentView.viewWithTag(1) as? UIImageView
        itemImage?.image = meme.memedImage
        
        let labelText : UILabel? = cell.contentView.viewWithTag(2) as? UILabel
        labelText?.text = meme.topText + meme.bottomText
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController {
            viewController.meme = memes[indexPath.row]
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
                
            }
        }
        
    }
    
    
}
