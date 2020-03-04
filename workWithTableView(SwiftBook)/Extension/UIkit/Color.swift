//
//  Color.swift
//  workWithTableView(SwiftBook)
//
//  Created by Egor Syrtcov on 3/4/20.
//  Copyright © 2020 Egor Syrtcov. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainGreen() -> UIColor {
        return UIColor(red: 124, green: 196, blue: 0)
    }
    
    static func blueShara() -> UIColor {
        return UIColor(red: 0, green: 80, blue: 229)
    }
    
    static func greenButton() -> UIColor {
        return UIColor(red: 124, green: 196, blue: 0)
    }
    
    static func redButton() -> UIColor {
        return UIColor(red: 234, green: 0, blue: 66)
    }
    
    static func grayButtons() -> UIColor {
        return UIColor(red: 112, green: 80, blue: 80)
    }
    
}
