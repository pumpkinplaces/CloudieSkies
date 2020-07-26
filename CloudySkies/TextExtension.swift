//
//  TextExtension.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 7/8/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import Foundation
import SpriteKit


extension SKLabelNode{
    
     func createBorderPathForText(_ thestring: String) -> CGPath? {
        let charsAsUInt16Array = thestring.utf16.map {UInt16($0)}
        let borderFont = CTFontCreateWithName(self.fontName! as CFString, self.fontSize, nil)
        var glyphs = Array(repeating: UInt16(0), count: thestring.count)
        let gotGlyphs = CTFontGetGlyphsForCharacters(borderFont, charsAsUInt16Array, &glyphs, thestring.count)
        if gotGlyphs {
            var advances = Array(repeating: CGSize(), count: thestring.count)
            CTFontGetAdvancesForGlyphs(borderFont, CTFontOrientation.horizontal, glyphs, &advances, thestring.count);
            let letters = CGMutablePath()
            var xPosition = 0 as CGFloat
            for index in 0...(thestring.count - 1) {
                let letter = CTFontCreatePathForGlyph(borderFont, glyphs[index], nil)
                let t = CGAffineTransform(translationX: xPosition , y: 0)
                if let theletter = letter{
                letters.addPath(theletter, transform: t)
                xPosition = xPosition + advances[index].width
                }
            }
            return letters
        } else {
            return nil
        }
    }
}


extension UIColor{
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0){
        self.init(
            red: CGFloat(red)/255,
            green: CGFloat(green)/255,
            blue: CGFloat(blue)/255,
            alpha: a
        )
    }
}


extension String{
    subscript(anint: Int) -> Character{
           return self[self.index(self.startIndex, offsetBy: anint)]
    }
}
