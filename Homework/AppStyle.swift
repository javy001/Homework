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
    
    let backgroundColor = UIColor.black
    let greyAccent = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1)
    let mainTextColor = UIColor.white
    let greenColor = UIColor(red: 0/255, green: 200/255, blue: 136/255, alpha: 1)
    
    func genGreenColor(alpha: CGFloat) ->UIColor {
        return UIColor(red: 0/255, green: 136/255, blue: 136/255, alpha: alpha)
    }
    
    func genRedColor(alpha: CGFloat) ->UIColor {
        return UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: alpha)
    }
    
    func genOrangeColor(alpha: CGFloat) ->UIColor {
        return UIColor(red: 255/255, green: 182/255, blue: 0/255, alpha: alpha)
    }
}
