//
//  LoadingScene.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 8/14/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class AllTextureAtlases{
    static var RabbitaTextureAtlas = SKTextureAtlas(named: "Rabbita")
    static var BunnyTextureAtlas = SKTextureAtlas(named: "Bunny")
    static var BeigeBunnyTextureAtlas = SKTextureAtlas(named: "BeigeBunny")
    static var LightBrownBunnyTextureAtlas = SKTextureAtlas(named: "LightBrownBunny")
    static var DarkBrownBunnyTextureAtlas = SKTextureAtlas(named: "DarkBrownBunny")
    static var GrayBunnyTextureAtlas = SKTextureAtlas(named: "GrayBunny")
    static var BlackBunnyLightTextureAtlas = SKTextureAtlas(named: "BlackBunnyLight")
    static var SpottedBlackBunnyTextureAtlas = SKTextureAtlas(named: "SpottedBlackBunny")
    static var BrownRabbitTextureAtlas = SKTextureAtlas(named: "BrownRabbit")
    static var JoshieTextureAtlas = SKTextureAtlas(named: "Joshie")
    static var JoyceTextureAtlas = SKTextureAtlas(named: "Joyce")
    static var BirdTextureAtlas = SKTextureAtlas(named: "BirdAnimation")
    static var JasonTextureAtlas = SKTextureAtlas(named: "Jason")
    
    static var textureDict:[String: SKTextureAtlas] = [:]
}

class LoadingScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var image = SKSpriteNode()
    var isLoading = true
    var textureAtlasList:[SKTextureAtlas] = []
    var atlasLoadNum = 0
    
        
    override func didMove(to view: SKView) {
    // Get label node from scene and store it for use later
        image = SKSpriteNode(imageNamed: "BrightBlueSky")
        image.setScale(3.5)
        image.position = CGPoint.zero
        image.zPosition = 1
        addChild(image)
        
        AllTextureAtlases.textureDict["Rabbita"] = AllTextureAtlases.RabbitaTextureAtlas
        AllTextureAtlases.textureDict["Bunny"] = AllTextureAtlases.BunnyTextureAtlas
        AllTextureAtlases.textureDict["BeigeBunny"] = AllTextureAtlases.BeigeBunnyTextureAtlas
        AllTextureAtlases.textureDict["LightBrownBunny"] = AllTextureAtlases.LightBrownBunnyTextureAtlas
        AllTextureAtlases.textureDict["DarkBrownBunny"] = AllTextureAtlases.DarkBrownBunnyTextureAtlas
        AllTextureAtlases.textureDict["GrayBunny"] = AllTextureAtlases.GrayBunnyTextureAtlas
        AllTextureAtlases.textureDict["BlackBunnyLight"] = AllTextureAtlases.BlackBunnyLightTextureAtlas
        AllTextureAtlases.textureDict["SpottedBlackBunny"] = AllTextureAtlases.SpottedBlackBunnyTextureAtlas
        AllTextureAtlases.textureDict["BrownRabbit"] = AllTextureAtlases.BrownRabbitTextureAtlas
        AllTextureAtlases.textureDict["Joyce"] = AllTextureAtlases.JoyceTextureAtlas
        AllTextureAtlases.textureDict["Joshie"] = AllTextureAtlases.JoshieTextureAtlas
        AllTextureAtlases.textureDict["Jason"] = AllTextureAtlases.JasonTextureAtlas
    
        textureAtlasList.append(AllTextureAtlases.RabbitaTextureAtlas)
        textureAtlasList.append(AllTextureAtlases.BunnyTextureAtlas)
        textureAtlasList.append(AllTextureAtlases.BeigeBunnyTextureAtlas)
        textureAtlasList.append(AllTextureAtlases.LightBrownBunnyTextureAtlas)
        textureAtlasList.append(AllTextureAtlases.DarkBrownBunnyTextureAtlas)
        textureAtlasList.append(AllTextureAtlases.GrayBunnyTextureAtlas)
        textureAtlasList.append(AllTextureAtlases.BlackBunnyLightTextureAtlas)
        textureAtlasList.append(AllTextureAtlases.SpottedBlackBunnyTextureAtlas)
        textureAtlasList.append(AllTextureAtlases.BrownRabbitTextureAtlas)
        textureAtlasList.append(AllTextureAtlases.JoyceTextureAtlas)
        textureAtlasList.append(AllTextureAtlases.JoshieTextureAtlas)
        textureAtlasList.append(AllTextureAtlases.BirdTextureAtlas)
        SKTextureAtlas.preloadTextureAtlases(textureAtlasList, withCompletionHandler: {self.isLoading = false})
    }
        
   
        func touchDown(atPoint pos : CGPoint) {
            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.green
                self.addChild(n)
            }
        }
        
        
        func touchMoved(toPoint pos : CGPoint) {
            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.blue
                self.addChild(n)
            }
        }
        

        func touchUp(atPoint pos : CGPoint) {
            if let n = self.spinnyNode?.copy() as! SKShapeNode? {
                n.position = pos
                n.strokeColor = SKColor.red
                self.addChild(n)
            }
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
        
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        }
        
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        }
        
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        }
        
        
        override func update(_ currentTime: TimeInterval) {
            // Called before each frame is rendered
            if !isLoading {
                isLoading = true
                let easeInScene = EaseInScene(fileNamed: "EaseInScene")
                easeInScene!.previousScene = self
                let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                DispatchQueue.global().async {
                    self.scene?.view?.presentScene(easeInScene!, transition: fadeAway)
                }
            }
        }
    }


  
