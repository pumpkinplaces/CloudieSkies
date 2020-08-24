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

class StoreSong{
    static var stoppedSongForMain = Bool()
    static var storeSongPlaying = Bool()
}


class StorePrices{
    static var bunnyPriceList:[String:Int] = ["Bunny": 400, "BeigeBunny": 400, "BrownRabbit": 400, "LightBrownBunny": 400, "DarkBrownBunny": 400, "GrayBunny": 300, "BlackBunnyLight": 400, "SpottedBlackBunny": 400, "Rabbita": 300, "RedRabbita": 300, "OrangeRabbita": 300, "YellowRabbita": 300, "GreenRabbita": 300, "BlueRabbita": 300, "PurpleRabbita": 0, "PinkRabbita": 300, "BabyBlueRabbita": 300, "Joyce": 400, "Joshie": 400, "Jason": 400]
}


class GameScore{
    static var score = Int()
    static var viewController: GameViewController!
    static var gameCenterButton: UIButton!
    static var playerIsAuthentic = false
}

class Views{
    static var initialScrollDone = false
}

