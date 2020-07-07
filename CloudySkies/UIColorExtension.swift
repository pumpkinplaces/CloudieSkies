//
//  UIColorExtension.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 7/6/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0){
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
    )
    }
}
