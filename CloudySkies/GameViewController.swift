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
import GoogleMobileAds

class GameViewController: UIViewController, GKGameCenterControllerDelegate, UINavigationControllerDelegate, GKLocalPlayerListener, GADInterstitialDelegate, GADBannerViewDelegate, GADRewardedAdDelegate {
    
    
    
    var mainGameScene = GameScene()
    var storeSong: AVAudioPlayer?
    var initialScrollDone = Bool()
    var interstitialAd: GADInterstitial!
    var clickAd: GADInterstitial!
    var bannerAd: GADBannerView!
    var reward: GADRewardedAd!
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interstitialAd = createAndLoadInterstitial()
        bannerAd = createAndLoadBannerAd()
        reward = createAndLoadRewardAd()
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.playBackGroundSound(_:)), name: NSNotification.Name(rawValue: "PlayBackgroundSound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.stopBackGroundSound(_:)), name: NSNotification.Name(rawValue: "StopBackgroundSound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.pauseBackGroundSound(_:)), name: NSNotification.Name(rawValue: "PauseBackgroundSound"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.resumeBackGroundSound(_:)), name: NSNotification.Name(rawValue: "ResumeBackGroundSound"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.leaderboard(_:)), name:  NSNotification.Name(rawValue: "GameCenterLeaderBoard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.playInterstitialAd(_:)), name: NSNotification.Name(rawValue: "InterstitialAdPlayer"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.showBannerAd(_:)), name: NSNotification.Name(rawValue: "BannerAdShow"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.showRewardAd(_:)), name: NSNotification.Name(rawValue: "RewardShow"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(GameViewController.removeBannerAd(_:)), name: NSNotification.Name(rawValue: "RemoveBannerAdShow"), object: nil)
        
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
    private func createAndLoadInterstitial() -> GADInterstitial{
        interstitialAd = GADInterstitial(adUnitID: "ca-app-pub-9087912874155205/4047364170")
        interstitialAd.delegate = self
        let request = GADRequest()
        interstitialAd.load(request)
        return interstitialAd
    }
    
    private func createAndLoadBannerAd() -> GADBannerView{
        bannerAd = GADBannerView(adSize: kGADAdSizeBanner)
        bannerAd.delegate = self
        bannerAd.adUnitID = "ca-app-pub-9087912874155205/2512567449"
        let request = GADRequest()
        bannerAd.rootViewController = self
        bannerAd.load(request)
        return bannerAd
    }
    
    @objc func showBannerAd(_ notification: Notification){
        addBannerViewToView(bannerAd)
    }
    
    @objc func removeBannerAd(_ notification: Notification){
        bannerAd.removeFromSuperview()
    }
    
    
     func addBannerViewToView(_ bannerView: GADBannerView) {
         print("is coming to banner")
     bannerView.translatesAutoresizingMaskIntoConstraints = false
     view.addSubview(bannerView)
     view.addConstraints(
       [NSLayoutConstraint(item: bannerView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view.safeAreaLayoutGuide,
                           attribute: .bottom,
                           multiplier: 1,
                           constant: 0),
        NSLayoutConstraint(item: bannerView,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .centerX,
                           multiplier: 1,
                           constant: 0)
       ])
    }
    
    private func createAndLoadRewardAd() -> GADRewardedAd{
        reward = GADRewardedAd(adUnitID: "ca-app-pub-9087912874155205/3996205359")
        reward.load(GADRequest()) { error in
        if error != nil {return}
        }
        return reward
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      interstitialAd = createAndLoadInterstitial()
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        reward = createAndLoadRewardAd()
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
    
    
    @objc func playInterstitialAd(_ notification: Notification){
        if interstitialAd.isReady {
            interstitialAd.present(fromRootViewController: self)
        }
    }
    

    @objc func showRewardAd(_ notification: Notification){
        if reward.isReady {
            reward.present(fromRootViewController: self, delegate: self)
        }
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        var carrotAmount = UserDefaults().integer(forKey: "CarrotCount")
        carrotAmount += 10
        UserDefaults.standard.set(carrotAmount, forKey: "CarrotCount")
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

