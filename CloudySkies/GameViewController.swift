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
import GameKit

class GameViewController: UIViewController, GKGameCenterControllerDelegate, UINavigationControllerDelegate, GKLocalPlayerListener {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
     var mainGameScene = GameScene()
     var storeSong: AVAudioPlayer?
     var initialScrollDone = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.playBackGroundSound(_:)), name: NSNotification.Name(rawValue: "PlayBackgroundSound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.stopBackGroundSound(_:)), name: NSNotification.Name(rawValue: "StopBackgroundSound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.pauseBackGroundSound(_:)), name: NSNotification.Name(rawValue: "PauseBackgroundSound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.resumeBackGroundSound(_:)), name: NSNotification.Name(rawValue: "ResumeBackGroundSound"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.leaderboard(_:)), name:  NSNotification.Name(rawValue: "GameCenterLeaderBoard"), object: nil)
        //createGradientLayer()
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene")  {
                // Set the scale mode to scale to fit the window
                 GameScore.viewController = self
                 authenticatePlayer()
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false
        }
    }

    private func authenticatePlayer(){
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {(ViewController, error) -> Void in
        guard error == nil else { return }
        if GKLocalPlayer.local.isAuthenticated {
            GKLocalPlayer.local.register(self)
        }
        if let vc = ViewController {self.present(vc, animated: true, completion: nil)}
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
    
    @objc func willAddTarget(){
        GameScore.gameCenterButton.addTarget(self, action: #selector(leaderboard), for: .touchUpInside)
    }
    
    @objc func leaderboard(_ notification: Notification){
        let vc = GKGameCenterViewController()
        vc.gameCenterDelegate = self
        vc.viewState = .leaderboards
        vc.leaderboardIdentifier = "e4r8i9m1k2"
        present(vc, animated: true, completion: nil)
    }
    
    func saveHighScore(thescore: Int){
        if GKLocalPlayer.local.isAuthenticated{
            GameScore.playerIsAuthentic = true
            let scoreReporter = GKScore(leaderboardIdentifier: "e4r8i9m1k2")
            scoreReporter.value = Int64(thescore)
            let scoreArray:[GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Views.initialScrollDone = true
    }
}

