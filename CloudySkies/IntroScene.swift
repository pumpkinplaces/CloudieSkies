

//
//  GameScene.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 6/15/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import SpriteKit
import GameplayKit



class IntroScene: SKScene {
    
        private var label : SKLabelNode?
        private var spinnyNode : SKShapeNode?
        
        var Bunny = SKSpriteNode()
        var Cloud = SKSpriteNode()
        var background2 = SKSpriteNode()
        var startScreenDone = false

        
        override func didMove(to view: SKView) {
            // Get label node from scene and store it for use later
            setUpUI()
            self.addChild(Bunny)
            self.addChild(label!)
            self.addChild(background2)
            self.addChild(Cloud)
        }
        
        private func slideOff(node: SKNode, float: CGFloat) -> SKAction {
            return SKAction.run() {
                var yPos = node.position.y
                while yPos >= -self.frame.height/2 - node.frame.height {
                    let move = SKAction.moveTo(y: yPos - float, duration: 1.24)
                    node.run(move)
                    yPos -= float
                }
            }
        }
        
        
        private func setUpUI(){
            Bunny = SKSpriteNode(imageNamed: "Bunny1")
            Bunny.setScale(0.485)
            Bunny.position = CGPoint(x: 0, y: 110)
            Bunny.zPosition = 4
            
            label = SKLabelNode(text: "Cloudy Skies")
            label!.setScale(0.67)
            label!.position = CGPoint(x: 0, y: -250)
            label!.fontSize = 100
            label!.fontColor = UIColor.systemBlue
            label!.fontName = "Noteworthy-Bold"
            label!.alpha = 0
            label!.zPosition = 2
        
            background2 = SKSpriteNode(imageNamed: "Background2")
            background2.position = CGPoint(x: 130, y: 0)
            background2.setScale(1)
            background2.zPosition = 0
            
            let waitForIt = SKAction.wait(forDuration: 0.05)
            let itllFade = SKAction.fadeIn(withDuration: 1.5)
            
            let moveDown3 = SKAction.moveTo(y: -self.frame.height/2 - 200, duration: 1.7)
            let sequ2 =  SKAction.sequence([itllFade, waitForIt, moveDown3])
            label!.run(sequ2)

            Cloud = SKSpriteNode(imageNamed: "Cloud")
            Cloud.position = CGPoint(x: 0, y: -65)
            Cloud.zPosition = 1
            Cloud.setScale(0.32)
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
            if label!.hasActions() == false {
                let introscene = PlayScene(fileNamed: "PlayScene")
                let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                self.scene?.view?.presentScene(introscene!, transition: fadeAway)
            
            }
        }
    }


