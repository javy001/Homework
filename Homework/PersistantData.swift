//
//  PersistantData.swift
//  Homework
//
//  Created by Javier Quintero on 6/16/19.
//  Copyright © 2019 Javier Quintero. All rights reserved.
//

import Foundation
import UIKit

class PersistantData {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
}
