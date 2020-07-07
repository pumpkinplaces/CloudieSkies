//
//  PlayScene.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 7/7/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit


class PlayScene: SKScene {
    

    private var spinnyNode : SKShapeNode?
    
    var ruleBoard:SKSpriteNode!
    var rulesTab = SKSpriteNode()
    var rulesText: SKLabelNode!
    var Cloud = SKSpriteNode()
    var background = SKSpriteNode()
    var playTab: SKSpriteNode!
    var startPlaying:SKLabelNode!
    var Cloud1 = SKSpriteNode()
    var Cloud2 = SKSpriteNode()
     
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        setUpUI()
        self.addChild(rulesTab)
        rulesTab.addChild(rulesText)
        self.addChild(playTab)
        playTab.addChild(startPlaying)
        self.addChild(background)
        self.addChild(Cloud)
        self.addChild(Cloud1)
        self.addChild(Cloud2)
    }
    
    
    private func setUpUI(){
        rulesTab = SKSpriteNode(imageNamed: "CircleStart")
        rulesTab.setScale(0.07)
        rulesTab.position = CGPoint(x: -self.frame.width/4, y: -175)
        rulesTab.zPosition = 2
        
        rulesText = SKLabelNode(text: "Rules")
        rulesText.setScale(1)
        rulesText.position = CGPoint.zero
        rulesText.zPosition = 3
        
        playTab = SKSpriteNode(imageNamed: "CircleStart")
        playTab.setScale(0.07)
        playTab.position = CGPoint(x: self.frame.width/4, y: -175)
        playTab.zPosition = 2
        
        startPlaying = SKLabelNode(text: "Play Game")
        startPlaying.setScale(1)
        startPlaying.position = CGPoint.zero
        startPlaying.fontSize = 100
        startPlaying.fontColor = UIColor.systemBlue
        startPlaying.fontName = "Noteworthy-Bold"
        startPlaying.alpha = 0
        startPlaying.zPosition = 3
    
        background = SKSpriteNode(imageNamed: "BlueSky")
        background.position = CGPoint(x: 130, y: 0)
        background.setScale(1)
        background.zPosition = 0
      
        Cloud = SKSpriteNode(imageNamed: "Cloud")
        Cloud.position = CGPoint(x: 0, y: -111)
        Cloud.zPosition = 1
        Cloud.setScale(0.1)
        
        Cloud1 = SKSpriteNode(imageNamed: "Cloud4")
        Cloud1.position = CGPoint(x: -30, y: 150)
        Cloud1.setScale(0.1)
        Cloud1.zPosition = 1
        
        Cloud2 = SKSpriteNode(imageNamed: "Cloud")
        Cloud2.position = CGPoint(x: 0, y: 200)
        Cloud2.setScale(0.1)
        Cloud2.zPosition = 1
    }
    
    
    private func makeRuleBoard(){
        ruleBoard = SKSpriteNode(imageNamed: "RuleBoard")
        ruleBoard.position = CGPoint.zero
        ruleBoard.setScale(0.75)
        ruleBoard.zPosition = 4
        self.addChild(ruleBoard)
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
        for touch in touches{
            let tab = touch.location(in: self)
            if rulesTab.contains(tab){
                makeRuleBoard()
            }
            if playTab.contains(tab){
                let mainGameScene = MainGame(fileNamed: "MainGame")
                let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                self.scene?.view?.presentScene(mainGameScene!, transition: fadeAway)
            }
        }
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
    }
}
