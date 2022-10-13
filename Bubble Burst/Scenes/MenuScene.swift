//
//  MenuScene.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import UIKit
import SpriteKit
import GameplayKit

class MenuScene: SKScene,  SKPhysicsContactDelegate {
    
    var label: SKLabelNode!
    private var spinnyNode: SKShapeNode!
    var difficultyLabel: SKLabelNode!
    var difficultyMode: SKLabelNode!
   // private var bubbleHS : SKSpriteNode!
    var mainMenuMusic: SKAudioNode!
    var bubbleAnimation = BubbleAnimation()
    let playButton = PlayButton()
    let difficultyButton = DifficultyButton()
    var newDifficulty: String!
    
   // var game: GameManager!
    
    override func didMove(to view: SKView) {

        initializeMenu()

        if let musicURL = Bundle.main.url(forResource: "EternityMemoryofLightwaves", withExtension: "mp3") {
            mainMenuMusic = SKAudioNode(url: musicURL)
            addChild(mainMenuMusic)
        }
        
        let userDefaults = UserDefaults.standard
        if(userDefaults.bool(forKey: "normal")){
            difficultyMode.text = "Normal"
        }else{
            difficultyMode.text = "Kids Mode"
        }
        
    }
    
    private func initializeMenu(){
        
        self.backgroundColor = UIColor.black
        playButton.name = "play_button"
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 500)
        playButton.size = CGSize(width: 200, height: 200)
        self.addChild(playButton)
        
        difficultyButton.name = "difficulty_button"
        difficultyButton.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 850)
        difficultyButton.size = CGSize(width: 400, height: 75)
        difficultyButton.zPosition = -1
        self.addChild(difficultyButton)
        
        difficultyLabel = SKLabelNode(fontNamed: "Chalkduster")
        difficultyLabel.text = "Difficulty Level"
        difficultyLabel.fontSize = 35
        difficultyLabel.fontColor = SKColor.black
        difficultyLabel.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 840)
        difficultyLabel.zPosition = 1
        self.addChild(difficultyLabel)
        
       // difficultyMode.name = "normal"
        difficultyMode = SKLabelNode(fontNamed: "Chalkduster")
        difficultyMode.text = "Normal"
        difficultyMode.fontSize = 35
        difficultyMode.fontColor = SKColor.cyan
        difficultyMode.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 675)
        difficultyLabel.zPosition = 1
        self.addChild(difficultyMode)
        

        showPlayButton()
        showDifficultyButton()
        showDifficultyLabel()
        showDifficultyMode()
        
    }
    
    @objc func showPButton() {
        playButton.isHidden = false
    }
    
    @objc func showDButton() {
        difficultyButton.isHidden = false
    }
    
    @objc func showDLabel() {
        difficultyLabel.isHidden = false
    }
    
    @objc func showDMode() {
        difficultyMode.isHidden = false
    }
    
    func showPlayButton(){
        if !playButton.isHidden {
            playButton.isHidden = true
            Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(showPButton), userInfo: nil, repeats: false)
        }
    }
    
    func showDifficultyButton(){
        if !difficultyButton.isHidden {
            difficultyButton.isHidden = true
            Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(showDButton), userInfo: nil, repeats: false)
        }
    }
    
    func showDifficultyLabel(){
        if !difficultyLabel.isHidden {
            difficultyLabel.isHidden = true
            Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(showDLabel), userInfo: nil, repeats: false)
        }
       // print("\(difficultyLabel)")
    }
    
    func showDifficultyMode(){
        if !difficultyMode.isHidden {
            difficultyMode.isHidden = true
            Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(showDMode), userInfo: nil, repeats: false)
        }
       // print("\(difficultyLabel)")
    }
    
    func hideButton(){
        playButton.isHidden = true
    }
    
    func hideDLabel(){
        difficultyLabel.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.3), SKAction.wait(forDuration: 1.5), SKAction.fadeOut(withDuration: 1)]))
    }
    
    private func changeDifficulty()
    {
        let userDefaults = UserDefaults.standard
        if(difficultyMode.text == "Normal"){
            difficultyMode.text = "Kids Mode"
            userDefaults.set(true, forKey: "normal")
        }else{
            difficultyMode.text = "Normal"
            userDefaults.set(false, forKey: "normal")
        }
        
        userDefaults.synchronize()
        
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

        for t in touches { self.touchDown(atPoint: t.location(in: self))
            let location = t.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode{
                if node.name == "play_button" && difficultyMode.text == "Normal"{
                    mainMenuMusic.removeFromParent()
                    let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                    let scene = SKScene(fileNamed: "GameScene") as! GameScene
                        // Set the scale mode to scale to fit the window
                    scene.newDifficulty = "Normal"
                    scene.scaleMode = .fill
                    view?.presentScene(scene, transition: transition)

                } else if node.name == "play_button" && difficultyMode.text == "Kids Mode"{
                    mainMenuMusic.removeFromParent()
                    let transition = SKTransition.flipVertical(withDuration: 0.5)
                    let scene = SKScene(fileNamed: "KidsModeScene") as! KidsModeScene
                        // Set the scale mode to scale to fit the window
                    scene.newDifficulty = "Kids Mode"
                    scene.scaleMode = .fill
                    view?.presentScene(scene, transition: transition)
                   
                }
                
                if node.name == "difficulty_button"{
                    changeDifficulty()
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

