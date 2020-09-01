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
    var isLoading = true
        
    override func didMove(to view: SKView) {
    // Get label node from scene and store it for use later
        firstLaunchSettings()
        firstUpdateSettings()
        secondUpdateSettings()
        thirdUpdateSettings()
        self.backgroundColor = UIColor.black
        image = SKSpriteNode(imageNamed: "AirDares")
        image.position = CGPoint(x: 0, y: 0)
        image.setScale(1.22)
        self.addChild(image)
        image.zPosition = 1
        loadEverything()
    }
        
    private func firstLaunchSettings(){
        if UserDefaults().bool(forKey: "hasLaunched") == false{
            UserDefaults.standard.set(true, forKey: "SoundOffOrOn")
            UserDefaults.standard.set("Bunny", forKey: "bunnyType")
            UserDefaults.standard.set("", forKey: "RabbitaColor")
            UserDefaults.standard.set(0, forKey: "CarrotCount")
            UserDefaults.standard.set("StoreScene", forKey: "StoreScene")
            UserDefaults.standard.set(0, forKey: "highscore")
            UserDefaults.standard.set(0, forKey: "highestTotalScore")
        AllBunnyInfo.ownsList["Bunny"] = true; AllBunnyInfo.ownsList["YellowRabbita"] = false; AllBunnyInfo.ownsList["BrownRabbit"] = false; AllBunnyInfo.ownsList["BeigeBunny"] = true; AllBunnyInfo.ownsList["Shiny"] = false; AllBunnyInfo.ownsList["LightBrownBunny"] = false; AllBunnyInfo.ownsList["DarkBrownBunny"] = false; AllBunnyInfo.ownsList["GreenRabbita"] = false; AllBunnyInfo.ownsList["BlueRabbita"] = false; AllBunnyInfo.ownsList["BlackBunny"] = false; AllBunnyInfo.ownsList["PinkRabbita"] = false; AllBunnyInfo.ownsList["Rabbita"] = false; AllBunnyInfo.ownsList["OrangeRabbita"] = false; AllBunnyInfo.ownsList["RedRabbita"] = false; AllBunnyInfo.ownsList["PurpleRabbita"] = false; AllBunnyInfo.ownsList["GrayBunny"] = false; AllBunnyInfo.ownsList["SpottedBlackBunny"] = false; AllBunnyInfo.ownsList["BlackBunnyLight"] = false; AllBunnyInfo.ownsList["BabyBlueRabbita"] = false
            UserDefaults.standard.set(AllBunnyInfo.ownsList, forKey: "Owned")
            UserDefaults.standard.set(true, forKey: "hasLaunched")
        }
    }
    
    private func firstUpdateSettings(){
        if UserDefaults().bool(forKey: "FirstUpdate") == false{
            UserDefaults.standard.set(false, forKey: "VisitedStore")
            UserDefaults.standard.set(0, forKey: "VisitedStoreInt")
            UserDefaults.standard.set(true, forKey: "FirstUpdate")}
    }
    private func secondUpdateSettings(){
        if UserDefaults().bool(forKey: "SecondUpdate") == false{
            UserDefaults.standard.set(0, forKey: "IndexPathRow")
            UserDefaults.standard.set(true, forKey: "SecondUpdate")
            var dict = UserDefaults().dictionary(forKey: "Owned")
            dict!["Joyce"] = false
            dict!["Joshie"] = false
            dict!["Jason"] = false
            dict!.removeValue(forKey: "Shiny")
            UserDefaults.standard.set(dict, forKey: "Owned")
        }
    }
    
    
    private func thirdUpdateSettings(){
        if UserDefaults().bool(forKey: "ThirdUpdate") == false{
            var dict = UserDefaults().dictionary(forKey: "Owned")
            dict!["Jackie"] = false
            dict!["PatchBunny"] = false
            UserDefaults.standard.set(dict, forKey: "Owned")
            
            UserDefaults.standard.set(0, forKey: "UpSwipesRight")
            UserDefaults.standard.set(0, forKey: "UpSwipesLeft")
            UserDefaults.standard.set(0, forKey: "LeftSwipes")
            UserDefaults.standard.set(0, forKey: "RightSwipes")
            UserDefaults.standard.set(0, forKey: "Taps")
            UserDefaults.standard.set(false, forKey: "AllSwipes")
            
            UserDefaults.standard.set(0, forKey: "LightningHoldCount")
            UserDefaults.standard.set(0, forKey: "BirdTapCount")
            UserDefaults.standard.set(true, forKey: "ThirdUpdate")
        }
    }
    
    
    private func loadEverything(){
        BunnyTexts.picList.append(BunnyTexts.Cloud)
        BunnyTexts.picList.append(BunnyTexts.CloudTwo)
        BunnyTexts.picList.append(BunnyTexts.CloudThree)
        BunnyTexts.picList.append(BunnyTexts.CloudFour)
        BunnyTexts.picList.append(BunnyTexts.Cloud1)
        BunnyTexts.picList.append(BunnyTexts.Cloud2)
        BunnyTexts.picList.append(BunnyTexts.Cloud3)
        BunnyTexts.picList.append(BunnyTexts.Cloud4)
        BunnyTexts.picList.append(BunnyTexts.Bird)
        BunnyTexts.picList.append(BunnyTexts.AirPlane)
        BunnyTexts.picList.append(BunnyTexts.RainDrop)
        BunnyTexts.picList.append(BunnyTexts.Lightening)
        BunnyTexts.picList.append(BunnyTexts.BlueSky)
        BunnyTexts.picList.append(BunnyTexts.BlueGrayish)
        BunnyTexts.picList.append(BunnyTexts.PurpleSky)
        BunnyTexts.picList.append(BunnyTexts.RedOrangeYellow)
        BunnyTexts.picList.append(BunnyTexts.BluishBlack)
        BunnyTexts.picList.append(BunnyTexts.TheOriginal)
        BunnyTexts.picList.append(BunnyTexts.PinkBlue)
        BunnyTexts.picList.append(BunnyTexts.BrightBlueSky)
        BunnyTexts.picList.append(BunnyTexts.DarkRedOrangeYellow)
        BunnyTexts.picList.append(BunnyTexts.BluishBrown)
        BunnyTexts.picList.append(BunnyTexts.PurpleBlack)
        BunnyTexts.picList.append(BunnyTexts.NorthernLights)
        BunnyTexts.picList.append(BunnyTexts.LightAndDarkBlue)
        BunnyTexts.picList.append(BunnyTexts.BrightBluishBrown)
        BunnyTexts.picList.append(BunnyTexts.Rainbow)
        BunnyTexts.picList.append(BunnyTexts.PinkAndGreen)
        BunnyTexts.picList.append(BunnyTexts.BlueGreen)
        BunnyTexts.picList.append(BunnyTexts.Midnight)
        BunnyTexts.picList.append(BunnyTexts.BirdPoo)
        BunnyTexts.picList.append(BunnyTexts.PlayAgainBar)
        BunnyTexts.picList.append(BunnyTexts.MainMenu)
        BunnyTexts.picList.append(BunnyTexts.PlayButton)
        BunnyTexts.picList.append(BunnyTexts.SoundOffButton)
        BunnyTexts.picList.append(BunnyTexts.SoundButton)
        BunnyTexts.picList.append(BunnyTexts.PauseButton)
        BunnyTexts.picList.append(BunnyTexts.Carrot)
        SKTexture.preload(BunnyTexts.picList, withCompletionHandler: {self.isLoading = false})
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
            if isLoading == false{
                isLoading = true
                let intro = IntroScene(fileNamed: "IntroScene")
                let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                DispatchQueue.global().async {
                    self.scene?.view?.presentScene(intro!, transition: fadeAway)
                }
            }
        }
    }


  
