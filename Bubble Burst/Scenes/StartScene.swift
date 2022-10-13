//
//  StartScene.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import UIKit
import SpriteKit
import GameplayKit

class StartScene: SKScene {
    
    var label : SKLabelNode!
    private var spinnyNode : SKShapeNode!
    var currentScore: SKLabelNode!
    var difficultyLabel : SKLabelNode!
    var difficultyMode : SKLabelNode!
    var bubbleAnimation = BubbleAnimation()
    let playButton = PlayButton()
    var newScore = 0
    let difficultyButton = DifficultyButton()
    var mainMenuMusic: SKAudioNode!
    
    var newDifficulty: String = "Normal" {
        didSet {
            difficultyMode.text = "\(newDifficulty)"
        }
    }
    
    override func didMove(to view: SKView) {

        initializeMenu()
        
        if let musicURL = Bundle.main.url(forResource: "EternityMemoryofLightwaves", withExtension: "mp3") {
            mainMenuMusic = SKAudioNode(url: musicURL)
            addChild(mainMenuMusic)
        }
        
        let userDefaults = UserDefaults.standard
        if(userDefaults.bool(forKey: "normal")){
            newDifficulty = "Normal"
        }else{
            newDifficulty = "Kids Mode"
        }
        
    }
    
    private func initializeMenu(){
        
        //creates game title
        self.backgroundColor = UIColor.black
        label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Bubble Burst"
        label.fontSize = 80
        label.fontColor = SKColor.cyan
        label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(label)
        
        playButton.name = "play_button"
        playButton.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 500)
        playButton.size = CGSize(width: 200, height: 200)
        self.addChild(playButton)
        
        difficultyButton.name = "difficulty_button"
        difficultyButton.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 850)
        difficultyButton.size = CGSize(width: 400, height: 75)
        difficultyButton.zPosition = -1
        self.addChild(difficultyButton)
        
        bubbleAnimation.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(bubbleAnimation)
        
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
        
        bubbleAnimation.beginAnimation()
        showTitle()
        hideTitle()
        showPlayButton()
        showDifficultyButton()
        showDifficultyLabel()
        showDifficultyMode()
        
    }
    
    // this function sets the game board and scores

    private func startGame()
    {
        print("start game")

        currentScore.run(SKAction.fadeIn(withDuration: 1.0))
    }
    
    @objc func showLabel() {
        label.isHidden = false
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
    
    func showTitle(){
        if !label.isHidden {
            label.isHidden = true
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(showLabel), userInfo: nil, repeats: false)
        }
    }
    
    func hideTitle(){
        label.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.3), SKAction.wait(forDuration: 1.5), SKAction.fadeOut(withDuration: 1), SKAction.removeFromParent()]))
    }
    
    func showPlayButton(){
        if !playButton.isHidden {
            playButton.isHidden = true
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(showPButton), userInfo: nil, repeats: false)
        }
    }
    
    func showDifficultyButton(){
        if !difficultyButton.isHidden {
            difficultyButton.isHidden = true
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(showDButton), userInfo: nil, repeats: false)
        }
    }
    
    func showDifficultyLabel(){
        if !difficultyLabel.isHidden {
            difficultyLabel.isHidden = true
            Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(showDLabel), userInfo: nil, repeats: false)
        }
       // print("\(difficultyLabel)")
    }
    
    func showDifficultyMode(){
        if !difficultyMode.isHidden {
            difficultyMode.isHidden = true
            Timer.scheduledTimer(timeInterval: 3.01, target: self, selector: #selector(showDMode), userInfo: nil, repeats: false)
        }
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
        if(newDifficulty == "Normal"){
            newDifficulty = "Kids Mode"
            userDefaults.set(true, forKey: "normal")
        }else{
            newDifficulty = "Normal"
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
            for node in touchedNode
            {
                if node.name == "play_button" && newDifficulty == "Normal"
                {
                    mainMenuMusic.removeFromParent()
                    let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                    let scene = SKScene(fileNamed: "GameScene") as! GameScene
                        // Set the scale mode to scale to fit the window
                    
                    scene.newDifficulty = self.newDifficulty
                    scene.scaleMode = .fill
                    view?.presentScene(scene, transition: transition)

                } else if node.name == "play_button" && newDifficulty == "Kids Mode"{
                    mainMenuMusic.removeFromParent()
                    let transition = SKTransition.flipVertical(withDuration: 0.5)
                    let scene = SKScene(fileNamed: "KidsModeScene") as! KidsModeScene
                        // Set the scale mode to scale to fit the window
                    scene.newDifficulty = self.newDifficulty
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
