//
//  SentMemesCollectionViewController.swift
//  MemeMeV2P0A
//
//  Created by Farhan Qazi on 10/16/18.
//  Copyright © 2018 Farhan Qazi. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //MARK: Step1: Initializes meme array
    let cellIdentifier = "MemeCell"
    var memes: [Meme]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space:CGFloat = 3.0
        let width = (view.frame.size.width - (2 * space)) / 3.0
        let height = (view.frame.size.height - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Provided property to downcast appDelete
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        self.collectionView?.reloadData()
    }
    
    override  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
        
    }
    
    //MARK: Step2: This method populates cell with array data
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCell", for: indexPath) as! MemeCollectionViewCell
        let currentMeme = memes[indexPath.row]
        
       
        cell.memeImageView?.image = currentMeme.memedImage
        cell.memeTitle?.text = "\(currentMeme.topText)...\(currentMeme.botText)"
        cell.memeImageView.contentMode = .scaleAspectFit
        return cell
    }
    
    
    //MARK: Step3: This method performs a segue with selected meme
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // This property gets the value of DetailVC from Storyboard
        let memeDetailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        //This property provides the value of view controller with data from the selected item
        memeDetailController.memes = self.memes[(indexPath as NSIndexPath).row]
        // This property Presents the view controller using navigation
        self.navigationController!.pushViewController(memeDetailController, animated: true)
        
    }
    
}
