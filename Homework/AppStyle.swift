//
//  AppStyle.swift
//  Homework
//
//  Created by Javier Quintero on 6/4/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import Foundation
import UIKit

class AppStyle {
    
    let backgroundColor = UIColor.white
    let greyAccent = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    let mainTextColor = UIColor.black
    let greenColor = UIColor(red: 0/255, green: 200/255, blue: 136/255, alpha: 1)
    var backgroundColors: [UIColor] = []
    var textColors: [UIColor] = []
    
    init() {
        backgroundColors = [
            genGreenColor(alpha: 0.3),
            genRedColor(alpha: 0.3),
            genOrangeColor(alpha: 0.3),
            genPurpleColor(alpha: 0.3),
            genPinkColor(alpha: 0.3),
            genNeonGreenColor(alpha: 0.3),
            genNeonPinkColor(alpha: 0.3)
        ]
        
        textColors = [
            genGreenColor(alpha: 1),
            genRedColor(alpha: 1),
            genOrangeColor(alpha: 1),
            genPurpleColor(alpha: 1),
            genPinkColor(alpha: 1),
            genNeonGreenColor(alpha: 1),
            genNeonPinkColor(alpha: 0.3)
        ]
    }
    
    func genGreenColor(alpha: CGFloat) ->UIColor {
        return UIColor(red: 0/255, green: 136/255, blue: 136/255, alpha: alpha)
    }
    
    func genRedColor(alpha: CGFloat) ->UIColor {
        return UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: alpha)
    }
    
    func genOrangeColor(alpha: CGFloat) ->UIColor {
        return UIColor(red: 252/255, green: 139/255, blue: 0/255, alpha: alpha)
    }
    
    func genPurpleColor(alpha: CGFloat) ->UIColor {
        return UIColor(red: 145/255, green: 63/255, blue: 252/255, alpha: alpha)
    }
    
    func genPinkColor(alpha: CGFloat) ->UIColor {
        return UIColor(red: 245/255, green: 66/255, blue: 245/255, alpha: alpha)
    }
    
    func genNeonGreenColor(alpha: CGFloat) ->UIColor {
        return UIColor(red: 0/255, green: 229/255, blue: 169/255, alpha: alpha)
    }
    
    func genNeonPinkColor(alpha: CGFloat) -> UIColor {
        return UIColor(red: 255/255, green: 0/255, blue: 180/255, alpha: alpha)
    }
    
    
}
