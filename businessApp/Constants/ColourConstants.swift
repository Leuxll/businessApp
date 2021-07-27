//
//  ColourConstants.swift
//  businessApp
//
//  Created by Yue Fung Lee on 17/6/2021.
//

import Foundation
import UIKit

struct ColourConstants {
    
    static let primaryColour = UIColor(red: 4/255, green: 102/255, blue: 200/255, alpha: 1)
    static let baseColour = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
    static let ShadowColour = UIColor(red: 114/255, green: 152/255, blue: 188/255, alpha: 0.5)
    static let LightColour = UIColor.white
    
    struct ButtonColour {
        let gradientButtonLeft  = UIColor(red: 4/255, green: 102/255, blue: 200/255, alpha: 1)
        let gradientButtonRight  = UIColor(red: 2/255, green: 62/255, blue: 125/255, alpha: 1)
    }
    
    struct textFieldColour {
        let textFieldShadow = UIColor(red: 151/255, green: 167/255, blue: 195/255, alpha: 1)
        let textFieldLight = UIColor.white
    }
    
    struct textColour {
        let placeHolderColour = UIColor(red: 151/255, green: 157/255, blue: 172/255, alpha: 1)
    }
    
}
