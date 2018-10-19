//
//  SentMemesTableViewController.swift
//  MemeMeV2P0A
//
//  Created by Farhan Qazi on 10/16/18.
//  Copyright © 2018 Farhan Qazi. All rights reserved.
//
import Foundation
import UIKit

class SentMemesTableViewController: UITableViewController {
    
    @IBOutlet var sentMemesTableView: UITableView!
    
    let cellIdentifier = "MemeCell"
    var memes: [Meme]!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let currentMeme = memes[indexPath.row]
        cell.imageView?.image = currentMeme.memedImage
        cell.textLabel?.text = "\(currentMeme.topText)...\(currentMeme.botText)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailController.memes = self.memes[indexPath.row]
        self.navigationController?.pushViewController(memeDetailController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memes?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
