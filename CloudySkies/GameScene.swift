//
//  GameScene.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 6/15/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var Bunny = SKSpriteNode()
    var Cloud = SKSpriteNode()
    //var background1 = SKSpriteNode()
    var background2 = SKSpriteNode()
    var startScreenDone = false
     
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        //self.backgroundColor = UIColor.brown
    
        //print(self.frame.width, self.frame.height, separator: "  ")
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
        Bunny.setScale(0.75)
        Bunny.position = CGPoint(x: 0, y: 175)
        Bunny.zPosition = 4
        
        label = SKLabelNode(text: "Cloudy Skies")
        label!.setScale(1)
        label!.position = CGPoint(x: 0, y: -400)
        label!.fontSize = 100
        label!.fontColor = UIColor.systemBlue
        label!.fontName = "Noteworthy-Bold"
        label!.alpha = 0
        label!.zPosition = 1
        
        /*
        background1 = SKSpriteNode(imageNamed: "Background1")
        background1.position = CGPoint(x: 0, y: 0)
        background1.setScale(1)
        background1.zPosition = 0
        */
        
        background2 = SKSpriteNode(imageNamed: "Background2")
        background2.position = CGPoint(x: 130, y: 0)
        background2.setScale(1)
        background2.zPosition = 0
               
       /*
        let fadeOut = SKAction.fadeOut(withDuration:5)
        let falloffScene = SKAction.falloff(to: -300, duration: 10)
        let labelAsNode: SKNode = label!
        */
        let waitForIt = SKAction.wait(forDuration: 0.05)
        let moveDown = slideOff(node: label!, float: 10)
        let itllFade = SKAction.fadeIn(withDuration: 1.5)
        let sequence = SKAction.sequence([itllFade, waitForIt, moveDown])
        label!.run(sequence)
        
        //let moveOff = SKAction.falloff(by: 500, duration: 2)
        //label!.run(SKAction.sequence([moveIn, moveOff]))
        //label!.run(SKAction.sequence([moveIn]))
        Cloud = SKSpriteNode(imageNamed: "Cloud")
        Cloud.position = CGPoint(x: 0, y: -111)
        Cloud.zPosition = 1
        Cloud.setScale(0.5)
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
        let mainGameScene = MainGame(fileNamed: "MainGame")
            let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
            self.scene?.view?.presentScene(mainGameScene!, transition: fadeAway)
        }
    }
}
