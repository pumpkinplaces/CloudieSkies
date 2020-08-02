//
//  GameScene.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 6/15/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import SpriteKit
import GameplayKit

class AllBunnyInfo{
    static var ownsList:[String:Bool] = [:]
}

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var image = SKSpriteNode()
        
    override func didMove(to view: SKView) {
    // Get label node from scene and store it for use later
       // self.backgroundColor = UIColor(red: 128, green: 75, blue: 71)
        firstLaunchSettings()
        self.backgroundColor = UIColor.black
        image = SKSpriteNode(imageNamed: "AirDares")
        image.position = CGPoint(x: 0, y: 0)
        image.setScale(1.22)
        self.addChild(image)
        image.zPosition = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let intro = IntroScene(fileNamed: "PlayScene")
            let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
            self.scene?.view?.presentScene(intro!, transition: fadeAway)
        })
    }
        
    private func firstLaunchSettings(){
        if UserDefaults().bool(forKey: "First Launch") == true{
            UserDefaults.standard.set(true, forKey: "SoundOffOrOn")
            UserDefaults.standard.set("Bunny", forKey: "bunnyType")
            UserDefaults.standard.set("", forKey: "RabbitaColor")
            UserDefaults.standard.set(0, forKey: "CarrotCount")
            UserDefaults.standard.set("StoreScene", forKey: "StoreScene")
            UserDefaults.standard.set(0, forKey: "highscore")
            UserDefaults.standard.set(0, forKey: "highestTotalScore")
        AllBunnyInfo.ownsList["Bunny"] = true; AllBunnyInfo.ownsList["YellowRabbita"] = false; AllBunnyInfo.ownsList["BrownRabbit"] = false; AllBunnyInfo.ownsList["BeigeBunny"] = true; AllBunnyInfo.ownsList["Shiny"] = false; AllBunnyInfo.ownsList["LightBrownBunny"] = false; AllBunnyInfo.ownsList["DarkBrownBunny"] = false; AllBunnyInfo.ownsList["GreenRabbita"] = false; AllBunnyInfo.ownsList["BlueRabbita"] = false; AllBunnyInfo.ownsList["BlackBunny"] = false; AllBunnyInfo.ownsList["PinkRabbita"] = false; AllBunnyInfo.ownsList["Rabbita"] = false; AllBunnyInfo.ownsList["OrangeRabbita"] = false; AllBunnyInfo.ownsList["RedRabbita"] = false; AllBunnyInfo.ownsList["PurpleRabbita"] = false; AllBunnyInfo.ownsList["GrayBunny"] = false; AllBunnyInfo.ownsList["SpottedBlackBunny"] = false;
            UserDefaults.standard.set(AllBunnyInfo.ownsList, forKey: "Owned")
        }
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
        }
    }


  
