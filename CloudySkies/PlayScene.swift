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
import UIKit
import AVFoundation


class PlayScene: SKScene {
    

    private var spinnyNode : SKShapeNode?
    
    var ruleBoard:SKSpriteNode!
    var rulesTab:SKSpriteNode!
    var rulesText: SKLabelNode!
    var Cloud = SKSpriteNode()
    var background = SKSpriteNode()
    var playTab: SKSpriteNode!
    var startPlaying:SKLabelNode!
    var Cloud1 = SKSpriteNode()
    var Cloud2 = SKSpriteNode()
    var closeScoreBoard: SKSpriteNode?
    var Cloud3 = SKSpriteNode()
    var Cloud4 = SKSpriteNode()
    var Cloud5 = SKSpriteNode()
    var Cloud6 = SKSpriteNode()
    var Cloud7 = SKSpriteNode()
    var Cloud8 = SKSpriteNode()
    var Cloud9 = SKSpriteNode()
    var Cloud10 = SKSpriteNode()
    var Cloud11 = SKSpriteNode()
    var Cloud12 = SKSpriteNode()
    var fluffy: SKLabelNode!
    var introsong: AVAudioPlayer?
    var soundOff = SKSpriteNode(), soundOn = SKSpriteNode()
    var silentaudio: AVAudioPlayer?
    var soundOffOrOn = UserDefaults().bool(forKey: "SoundOffOrOn")
    var contactLearnMore:SKSpriteNode?
    var more = SKSpriteNode()
    var close: SKSpriteNode?
     
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
    NotificationCenter.default.addObserver(self, selector: #selector(pauseEverything(_:)), name: UIApplication.willResignActiveNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(playNow(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
        setUpUI()
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true{
                introMusic()
                makeSoundOnButton()
            }
        else{makeSoundOffButton()}
        self.addChild(rulesTab)
        self.addChild(ruleBoard)
        self.addChild(rulesText)
        self.addChild(playTab)
        self.addChild(startPlaying)
        self.addChild(background)
        self.addChild(Cloud4)
        self.addChild(Cloud5)
        self.addChild(Cloud6)
        self.addChild(Cloud7)
        self.addChild(Cloud8)
        self.addChild(Cloud9)
        self.addChild(Cloud10)
        self.addChild(fluffy)
    }
    
    
    private func setUpUI(){
        makeRuleBoard()
        makeSilentAudio()
        rulesTab = SKSpriteNode(imageNamed: "CircleStart")
        rulesTab.setScale(0.09)
        let tabsYPos:CGFloat = -175
        rulesTab.position = CGPoint(x: -self.frame.width/4 - 12, y: tabsYPos)
        rulesTab.zPosition = 2
        
        rulesText = SKLabelNode(text: "Rules")
        rulesText.setScale(0.3)
        rulesText.position = CGPoint(x: -self.frame.width/4 - 12, y: tabsYPos - 13)
        rulesText.zPosition = 3
        rulesText.fontSize = 150
        rulesText.fontName = "Noteworthy-Bold"
        rulesText.fontColor = UIColor(red: 150, green: 21, blue: 21)
        
        playTab = SKSpriteNode(imageNamed: "CircleStart")
        playTab.setScale(0.12)
        playTab.position = CGPoint(x: self.frame.width/4 - 15, y: tabsYPos)
        playTab.zPosition = 2
        
        startPlaying = SKLabelNode(text: "Play Game")
        startPlaying.setScale(0.3)
        startPlaying.position = CGPoint(x: self.frame.width/4 - 15, y: tabsYPos - 10)
        startPlaying.fontSize = 125
        startPlaying.fontColor = UIColor(red: 150, green: 21, blue: 21, a: 1)
        startPlaying.fontName = "Noteworthy-Bold"
        startPlaying.zPosition = 3
    
        background = SKSpriteNode(imageNamed: "BlueSky")
        background.position = CGPoint.zero
        background.setScale(3.5)
        background.zPosition = 0
        
        Cloud4 = SKSpriteNode(imageNamed: "Cloud4")
        Cloud4.position = CGPoint(x: 81, y: self.frame.height/2 - 102)
        Cloud4.zPosition = 1
        Cloud4.setScale(0.15)
        
        Cloud5 = SKSpriteNode(imageNamed: "Cloud")
        Cloud5.position = CGPoint(x: -self.frame.width/2 + 70, y: 0)
        Cloud5.setScale(0.12)
        Cloud5.zPosition = 1
        
        Cloud6 = SKSpriteNode(imageNamed: "Cloud3")
        Cloud6.position = CGPoint(x: 80, y: -57)
        Cloud6.setScale(0.135)
        Cloud6.zPosition = 1
        
        Cloud7 = SKSpriteNode(imageNamed: "Cloud2")
        Cloud7.position = CGPoint(x: -self.frame.width/2 + 106, y: self.frame.height/4 + 82)
        Cloud7.setScale(0.175)
        Cloud7.zPosition = 1
        
        Cloud8 = SKSpriteNode(imageNamed: "Cloud")
        Cloud8.position = CGPoint(x: self.frame.width/2 - 99, y: -self.frame.height/2 + 90)
        Cloud8.setScale(0.12710)
        Cloud8.zPosition = 1
        
        Cloud9 = SKSpriteNode(imageNamed: "Cloud2")
        Cloud9.position = CGPoint(x: -self.frame.width/2 + 88, y: -self.frame.height/2 + 79)
        Cloud9.zPosition = 1
        Cloud9.setScale(0.2)
        
        more = SKSpriteNode(imageNamed: "More")
        more.setScale(0.2)
        more.position = CGPoint(x: -self.frame.width/2 + 59.5, y: self.frame.height/2 - 37.5)
        more.zPosition = 2
        self.addChild(more)
        
        Cloud10 = SKSpriteNode(imageNamed: "Cloud2")
        Cloud10.position = CGPoint(x: self.frame.width/2 - 35, y: self.frame.width/2 - 44)
        Cloud10.setScale(0.1)
        Cloud10.zPosition = 1
        
        Cloud12 = SKSpriteNode(imageNamed: "Cloud3")
        Cloud12.position = CGPoint(x: 0, y: -self.frame.height/2 + 100)
        Cloud12.setScale(0.119)
        Cloud12.zPosition = 1
        
        fluffy = SKLabelNode(text: "Cloudy Skies")
        fluffy.position = CGPoint(x: 0, y: 179)
        fluffy.setScale(2)
        fluffy.fontName = "Noteworthy-Bold"
        fluffy.fontColor = UIColor(red: 209, green: 10, blue: 10)
        fluffy.zPosition = 3
        makeTheBorder(fluffy, color: UIColor.black, posit: CGPoint(x: -165, y: 179), scaleTo: 2)
    }
    
    private func makeMore(){
        contactLearnMore = SKSpriteNode(imageNamed: "contactLearnMore")
        contactLearnMore!.setScale(0.75)
        contactLearnMore!.zPosition = 4
        contactLearnMore!.position = CGPoint.zero
        self.addChild(contactLearnMore!)
        
        close = SKSpriteNode(imageNamed: "closeContactInfo")
        close!.zPosition = 5
        close!.setScale(0.17)
        close!.position = CGPoint(x: contactLearnMore!.frame.width/2 - 45, y:contactLearnMore!.frame.height/2 - 30)
        self.addChild(close!)
    }
    
    
    @objc private func pauseEverything(_ application: UIApplication){
        introsong?.pause()
        silentaudio?.pause()
        self.isPaused = true
       }
       
    @objc private func playNow(_ application: UIApplication){
        if UserDefaults().bool(forKey: "SoundOffOrOn") == true{
            introsong?.play()
            silentaudio?.play()
        }
           self.isPaused = false
    }
    
    
    private func makeSilentAudio(){
        let pathToSound = Bundle.main.path(forResource: "Intro", ofType: "m4a")
        let url = URL(fileURLWithPath: pathToSound!)
        do{
            silentaudio = try AVAudioPlayer(contentsOf: url)
            silentaudio?.setVolume(0, fadeDuration: 0)
            silentaudio?.play()
        }
        catch{}
    }
    
    
    private func rememberSoundSettings(_ soundPic: SKSpriteNode){
        if soundPic.name == "SoundOff"{
            UserDefaults.standard.set(true, forKey: "SoundOffOrOn"); soundOffOrOn = true}
        else if soundPic.name == "SoundOn"{UserDefaults.standard.set(false, forKey: "SoundOffOrOn"); soundOffOrOn = false}
    }
    
    private func makeTheBorder(_ labelNode: SKLabelNode, color: UIColor, posit: CGPoint, scaleTo: CGFloat){
        if let path =  labelNode.createBorderPathForText(labelNode.text!) {
            let border = SKShapeNode()
            border.strokeColor = color
            border.lineWidth = 10;
            border.path = path
            border.position = posit
            border.zPosition = 2
            border.setScale(scaleTo)
            self.addChild(border)
        }
    }
    
    private func theBlender<T: SKNode>(runActionOn thisnode: T){
        let blendIt = SKAction.colorize(withColorBlendFactor: 0.65, duration: 0.2)
        let wait = SKAction.wait(forDuration: 0.001)
        let unBlend = SKAction.colorize(withColorBlendFactor: -0.65, duration: 0.25)
        let sequ = SKAction.sequence([blendIt, wait, unBlend])
        thisnode.run(sequ)
    }
    
    
    private func introMusic(){
          let pathToSound = Bundle.main.path(forResource: "Intro", ofType: "m4a")
          let url = URL(fileURLWithPath: pathToSound!)
          do{
              introsong = try AVAudioPlayer(contentsOf: url)
              introsong?.play()
              introsong?.numberOfLoops = -1
          }
          catch{}
      }
    
    
    private func makeRuleBoard(){
        ruleBoard = SKSpriteNode(imageNamed: "RuleBoard")
        ruleBoard.position = CGPoint.zero
        ruleBoard.setScale(0.45)
        ruleBoard.zPosition = 4
        ruleBoard.alpha = 0
        
        let halfRuleBoardHeight = ruleBoard.frame.height/2
        let halfRuleBoardWidth = ruleBoard.frame.width/2
        closeScoreBoard = SKSpriteNode(imageNamed: "CloseButton")
        closeScoreBoard?.setScale(0.041)
        closeScoreBoard?.position = CGPoint(x: halfRuleBoardWidth - 30, y: halfRuleBoardHeight - 20)
        closeScoreBoard?.zPosition = 5
        closeScoreBoard?.alpha = 0
        self.addChild(closeScoreBoard!)
    }
    
    private func makeSoundOffButton(){
         soundOff = SKSpriteNode(imageNamed: "SoundOffButton")
         soundOff.name = "SoundOff"
         soundOff.position =  CGPoint(x: self.frame.width/2 - 40, y: -self.frame.height/2 + 40)
         soundOff.zPosition = 9
         soundOff.setScale(0.12)
         self.addChild(soundOff)
     }
     
    
      private func makeSoundOnButton(){
         soundOn = SKSpriteNode(imageNamed: "SoundButton")
         soundOn.name = "SoundOn"
         soundOn.position = CGPoint(x: self.frame.width/2 - 40, y: -self.frame.height/2 + 40)
         soundOn.zPosition = 9
         soundOn.setScale(0.12)
         self.addChild(soundOn)
     }
    
    private func removeNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
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
        if close?.parent == nil && contactLearnMore?.parent == nil{
            close = nil; contactLearnMore = nil
        }
        for touch in touches{
            let tab = touch.location(in: self)
            if rulesTab.contains(tab) && ruleBoard?.alpha == 0 && close == nil{
                theBlender(runActionOn: rulesTab)
                theBlender(runActionOn: rulesText)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.11, execute: {
                    self.ruleBoard.alpha = 1
                    self.closeScoreBoard?.alpha = 1
                })
            }
            if playTab.contains(tab) && ruleBoard?.alpha == 0 && close == nil{
                theBlender(runActionOn: playTab)
                theBlender(runActionOn: startPlaying)
                introsong?.setVolume(0, fadeDuration: 1)
                removeNotifications()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {self.introsong?.stop()})
                let mainGameScene = MainGame(fileNamed: "MainGame")
                let fadeAway = SKTransition.fade(with: UIColor.systemTeal, duration: 1)
                self.scene?.view?.presentScene(mainGameScene!, transition: fadeAway)
            }
            if let closeBoard = closeScoreBoard {
                if closeBoard.contains(tab){
                    theBlender(runActionOn: closeBoard)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.22, execute: {
                        self.ruleBoard.alpha = 0
                        self.closeScoreBoard?.alpha = 0
                    })
                }
            }
            if let _ = soundOn.parent{
                if soundOn.contains(tab){
                    rememberSoundSettings(soundOn)
                    soundOn.removeFromParent()
                    introsong?.pause()
                    makeSoundOffButton()
                }
            }
            else if let _ = soundOff.parent{
                if soundOff.contains(tab){
                    rememberSoundSettings(soundOff)
                    soundOff.removeFromParent()
                    introMusic()
                    makeSoundOnButton()
                  //  introsong?.play()
                }
            }

            if more.contains(tab) && ruleBoard?.alpha == 0 && contactLearnMore?.parent == nil{
                theBlender(runActionOn: Cloud9)
                theBlender(runActionOn: more)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.22, execute: {self.makeMore()})
            }
            if let _ = close{
                if close!.contains(tab){
                    theBlender(runActionOn: close!)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.22, execute: {self.close!.run(SKAction.removeFromParent())
                        self.contactLearnMore!.run(SKAction.removeFromParent())})
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self))}
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
