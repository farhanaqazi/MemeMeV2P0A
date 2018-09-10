//
//  Model.swift
//  MemeMeV1P0A
//
//  Created by Farhan Qazi on 9/9/18.
//  Copyright © 2018 Farhan Qazi. All rights reserved.
//

import Foundation
import UIKit
////// ********** Start: Creation and handling of Meme Data object      *************************

/// Define a Struct to handle data object for the Meme generator app
struct Meme {
    var topText: String?
    var botText: String?
    var editedImage: UIImage?
    var memedImage: UIImage?
}
/// This method combines the Image and Text
