//
//  Meme.swift
//  MemeApp
//
//  Created by Fabiola Ramirez on 4/11/17.
//  Copyright © 2017 Fabiola Ramirez. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    // No need for these properties to be Implicitly Unwrapped Optionals since you initialize all of them
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    init (topText:String, bottomText:String, originalImage:UIImage, memedImage:UIImage) {
        
        self.topText=topText
        self.bottomText=bottomText
        self.originalImage=originalImage
        self.memedImage=memedImage
        
    }
}


