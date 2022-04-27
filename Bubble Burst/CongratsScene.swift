//
//  CongratsScene.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import UIKit
import SpriteKit
import GameplayKit

class CongratsScene: SKScene {

    private var spinnyNode : SKShapeNode!
   // var currentScore: SKLabelNode!
   // private var bubbleHS : SKSpriteNode!
   
    let mainMenuButton = MainMenuButton()
    var mainMenuLabel : SKLabelNode!
    let goodJob = GoodJobImage()
    let replayButton = ReplayButton()
    var score: Int = 0
    var scoreLabel: SKLabelNode!
    var poppedLabel: SKLabelNode!
    var congratsMusic: SKAudioNode!
    var newDifficulty: String!
    
    override func didMove(to view: SKView) {

        initializeGameView()
        if let musicURL = Bundle.main.url(forResource: "gameover", withExtension: "mp3") {
            congratsMusic = SKAudioNode(url: musicURL)
            addChild(congratsMusic)
        }

    }
    
    // this function sets the game board and scores
    private func initializeGameView()
    {
        self.backgroundColor = UIColor.black
        mainMenuButton.name = "mainmenu_button"
        mainMenuButton.position = CGPoint(x: self.frame.midX - 200, y: self.frame.midY - 80)
        mainMenuButton.size = CGSize(width: 200, height: 200)
        mainMenuButton.zPosition = 1
        self.addChild(mainMenuButton)

        goodJob.name = "goodjob_image"
        goodJob.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 350)
        goodJob.size = CGSize(width: 700, height: 450)
        goodJob.zPosition = -1
        self.addChild(goodJob)
        
        replayButton.name = "replay_button"
        replayButton.position = CGPoint(x: self.frame.midX + 200, y: self.frame.midY - 80)
        replayButton.size = CGSize(width: 100, height: 100)
        replayButton.zPosition = 1
        self.addChild(replayButton)
        
        scoreLabel = SKLabelNode(fontNamed: "ChalkDuster")
        scoreLabel.text = "\(score)"
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        scoreLabel.fontSize = 80
        scoreLabel.fontColor = SKColor.white
        //scoreLabel.isHidden = true
        self.addChild(scoreLabel)
        
        poppedLabel = SKLabelNode(fontNamed: "ChalkDuster")
        poppedLabel.text = "You Popped"
        poppedLabel.zPosition = 1
        poppedLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 100)
        poppedLabel.fontSize = 80
        poppedLabel.fontColor = SKColor.white
        //scoreLabel.isHidden = true
        self.addChild(poppedLabel)

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
                if node.name == "mainmenu_button"{
                    congratsMusic.removeFromParent()
                    let transition = SKTransition.flipVertical(withDuration: 0.5)
                    let scene = SKScene(fileNamed: "MenuScene") as! MenuScene
                        // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    scene.newDifficulty = self.newDifficulty
                    view?.presentScene(scene, transition: transition)
                } else if node.name == "replay_button" && newDifficulty == "Kids Mode"{
                    congratsMusic.removeFromParent()
                    let transition = SKTransition.flipVertical(withDuration: 0.5)
                    let scene = SKScene(fileNamed: "KidsModeScene") as! KidsModeScene
                        // Set the scale mode to scale to fit the window
                    scene.newDifficulty = self.newDifficulty
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene, transition: transition)
                } else if node.name == "replay_button" && newDifficulty == "Normal"{
                    congratsMusic.removeFromParent()
                    let transition = SKTransition.flipVertical(withDuration: 0.5)
                    let scene = SKScene(fileNamed: "GameScene") as! GameScene
                        // Set the scale mode to scale to fit the window
                    scene.newDifficulty = self.newDifficulty
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene, transition: transition)
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

