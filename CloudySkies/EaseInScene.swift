//
//  EaseInScene.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 8/23/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit



class EaseInScene: SKScene {
    
        private var label : SKLabelNode?
        private var spinnyNode : SKShapeNode?
        var willChangeScenes = false
        weak var previousScene: SKScene?
        var image = SKSpriteNode()
        
        override func didMove(to view: SKView) {
            // Get label node from scene and store it for use later
            image = SKSpriteNode(imageNamed: "Midnight")
            image.setScale(3.5)
            image.position = CGPoint.zero
            image.zPosition = 1
            addChild(image)
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
            if !willChangeScenes && previousScene == nil{
                willChangeScenes = true
                let loadingScene = PlayScene(fileNamed: "PlayScene")
                let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                DispatchQueue.global().async {
                     self.scene?.view?.presentScene(loadingScene!, transition: fadeAway)
                }
            }
        }
    }


