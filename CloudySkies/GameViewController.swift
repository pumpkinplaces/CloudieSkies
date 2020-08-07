//
//  GameViewController.swift
//  CloudySkies
//
//  Created by Amanda Vialva on 6/15/20.
//  Copyright © 2020 Amanda Vialva. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
     var mainGameScene = GameScene()
     var storeSong: AVAudioPlayer?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.playBackGroundSound(_:)), name: NSNotification.Name(rawValue: "PlayBackgroundSound"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.stopBackGroundSound(_:)), name: NSNotification.Name(rawValue: "StopBackgroundSound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.pauseBackGroundSound(_:)), name: NSNotification.Name(rawValue: "PauseBackgroundSound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.resumeBackGroundSound(_:)), name: NSNotification.Name(rawValue: "ResumeBackGroundSound"), object: nil)
        //createGradientLayer()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene")  {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    
    @objc private func playBackGroundSound(_ notification: Notification){
        let pathToSound1 = Bundle.main.path(forResource: "storeSong", ofType: "m4a")
        let url = URL(fileURLWithPath: pathToSound1!)
        
        do{ storeSong = try AVAudioPlayer(contentsOf: url) }
        catch{}
        storeSong?.prepareToPlay()
        storeSong?.numberOfLoops = -1
        storeSong?.setVolume(1, fadeDuration: 0)
        DispatchQueue.global().async {
            self.storeSong?.play()
        }
    }
    
    @objc private func stopBackGroundSound(_ notification: Notification){
        if StoreSong.stoppedSongForMain{
            storeSong?.setVolume(0, fadeDuration: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {self.storeSong?.stop()})
        }
        else{storeSong?.stop()}
    }
    
    @objc private func pauseBackGroundSound(_ notification: Notification){
        storeSong?.pause()
    }
    
    @objc private func resumeBackGroundSound(_ notification: Notification){
        storeSong?.play()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
