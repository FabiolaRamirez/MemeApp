//
//  MemeCollectionViewController.swift
//  MemeApp
//
//  Created by Fabiola Ramirez on 4/11/17.
//  Copyright © 2017 Fabiola Ramirez. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UIViewController {
    
    
    @IBOutlet weak var flowLayout: UICollectionView!
    var memes: [Meme]!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        //self.flowLayout!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.flowLayout?.delegate = self
        self.flowLayout?.dataSource = self
        
//        let space:CGFloat = 3.0
//        let dimension = (view.frame.size.width - (2 * space)) / 3.0
//        
//        flowLayout.minimumInteritemSpacing = space
//        flowLayout.mini
//        flowLayout.minimumLineSpacing = space
//        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes
        self.flowLayout.reloadData()
    }

 
    
    
    @IBAction func addMeme(_ sender: Any) {
        
        let viewController : MemeEditorViewController? = self.storyboard?.instantiateViewController(withIdentifier: "memeEditorViewController") as? MemeEditorViewController
        let navigationController : UINavigationController = UINavigationController(rootViewController: viewController!)
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    
}

extension MemeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = flowLayout.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! itemCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.topLabel.text = meme.topText
        cell.buttomLabel.text = meme.bottomText
        cell.itemImage.image = meme.originalImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController {
            viewController.meme = memes[indexPath.row]
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }

}
