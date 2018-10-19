//
//  MemeDetailViewController.swift
//  MemeMeV2P0A
//
//  Created by Farhan Qazi on 10/16/18.
//  Copyright © 2018 Farhan Qazi. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    var memes: Meme!
    
    @IBOutlet weak var sentMemeDetailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.edit, target: self, action: #selector(MemeDetailViewController.startMemeEditor))
        sentMemeDetailImageView.image = memes.memedImage
        self.tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    @objc func startMemeEditor() {
        let memeEditVC = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        self.present(memeEditVC, animated: true, completion: nil)
        
        memeEditVC.topText.text = memes.topText
        memeEditVC.bottomText.text = memes.botText
        memeEditVC.ImagePickerView.image = memes.editedImage
        memeEditVC.isEditing = true
    }
}
