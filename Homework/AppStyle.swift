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
            makeColor(red: 12, green: 78, blue: 78, alpha: 0.4),
            makeColor(red: 203, green: 132, blue: 132, alpha: 1),
            makeColor(red: 0, green: 51, blue: 102, alpha: 0.45),
            makeColor(red: 12, green: 147, blue: 150, alpha: 0.65),
            makeColor(red: 170, green: 111, blue: 115, alpha: 0.3),
            
            makeColor(red: 0, green: 136, blue: 136 , alpha: 0.3),
            makeColor(red: 70, green: 2, blue: 70, alpha: 0.3),
            makeColor(red: 76, green: 165, blue: 230, alpha: 0.85),
            makeColor(red: 238, green: 168, blue: 168, alpha: 1),
            makeColor(red: 145, green: 63, blue: 252, alpha: 0.3),
            
            makeColor(red: 0, green: 238, blue: 101, alpha: 0.3),
            makeColor(red: 255, green: 34, blue: 129, alpha: 0.3),
            makeColor(red: 1, green: 205, blue: 254, alpha: 0.3),
            makeColor(red: 202, green: 250, blue: 1, alpha: 0.5),
            makeColor(red: 245, green: 66, blue: 245, alpha: 0.3)
        ]
        
        textColors = [
            makeColor(red: 12, green: 78, blue: 78, alpha: 1),
            makeColor(red: 111, green: 16, blue: 16, alpha: 1),
            makeColor(red: 0, green: 51, blue: 102, alpha: 1),
            makeColor(red: 4, green: 106, blue: 108, alpha: 1),
            makeColor(red: 170, green: 111, blue: 115, alpha: 1),
            
            makeColor(red: 0, green: 136, blue: 136 , alpha: 1),
            makeColor(red: 70, green: 2, blue: 70, alpha: 1),
            makeColor(red: 0, green: 51, blue: 102, alpha: 1),
            makeColor(red: 159, green: 56, blue: 56, alpha: 1),
            makeColor(red: 145, green: 63, blue: 252, alpha: 1),

            makeColor(red: 0, green: 193, blue: 11, alpha: 1),
            makeColor(red: 255, green: 34, blue: 129, alpha: 1),
            makeColor(red: 0, green: 128, blue: 158, alpha: 1),
            makeColor(red: 129, green: 153, blue: 27, alpha: 1),
            makeColor(red: 245, green: 66, blue: 245, alpha: 1)
        ]
    }
    
    func makeColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) ->UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
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
    
    func genDarkPurple(alpha: CGFloat) -> UIColor {
        return UIColor(red: 70/255, green: 2/255, blue: 70/255, alpha: alpha)
    }
    
    func genPaleOrange(alpha: CGFloat) -> UIColor {
        return UIColor(red: 238/255, green: 169/255, blue: 144/255, alpha: alpha)
    }
    
    func genPaleMaroon(alpha: CGFloat) -> UIColor {
        return UIColor(red: 170/255, green: 111/255, blue: 115/255, alpha: alpha)
    }
    
    func genBlueVapor(alpha: CGFloat) -> UIColor {
        return UIColor(red: 1/255, green: 205/255, blue: 254/255, alpha: alpha)
    }
    
    func genAltRed(alpha: CGFloat) -> UIColor {
        return UIColor(red: 255/255, green: 34/255, blue: 129/255, alpha: alpha)
    }
    
    func genBlue(alpha: CGFloat) -> UIColor {
        return UIColor(red: 0/255, green: 51/255, blue: 102/255, alpha: alpha)
    }
    
    func genMaroon(alpha: CGFloat) ->UIColor {
        return UIColor(red: 120/255, green: 3/255, blue: 3/255, alpha: alpha)
    }
    func genDarkGreen(alpha: CGFloat) ->UIColor {
        return UIColor(red: 37/255, green: 80/255, blue: 96/255, alpha: alpha)
    }
}


