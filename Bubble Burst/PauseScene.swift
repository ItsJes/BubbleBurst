//
//  PauseScene.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//


import UIKit
import SpriteKit
import GameplayKit

class PauseScene: SKScene {

    private var spinnyNode : SKShapeNode!
   // var currentScore: SKLabelNode!
   // private var bubbleHS : SKSpriteNode!
   
    let mainMenuButton = MainMenuButton()
    var mainMenuLabel : SKLabelNode!
    var pauseMusic: SKAudioNode!
    let replayButton = ReplayButton()
    var newDifficulty: String!
    let gamePaused = GamePausedImage()
    
    override func didMove(to view: SKView) {

        initializeGameView()

    }
    
    // this function sets the game board and scores
    private func initializeGameView()
    {
        self.backgroundColor = UIColor.black
        
        gamePaused.name = "gamepaused_image"
        gamePaused.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 330)
        gamePaused.size = CGSize(width: 700, height: 450)
        gamePaused.zPosition = -1
        self.addChild(gamePaused)
        
        mainMenuButton.name = "mainmenu_button"
        mainMenuButton.position = CGPoint(x: self.frame.midX - 200, y: self.frame.midY + 10)
        mainMenuButton.size = CGSize(width: 200, height: 200)
        mainMenuButton.zPosition = -1
        self.addChild(mainMenuButton)
        
        if let musicURL = Bundle.main.url(forResource: "yunasballad", withExtension: "mp3") {
            pauseMusic = SKAudioNode(url: musicURL)
            addChild(pauseMusic)
        }
        
        replayButton.name = "replay_button"
        replayButton.position = CGPoint(x: self.frame.midX + 200, y: self.frame.midY + 10)
        replayButton.size = CGSize(width: 100, height: 100)
        replayButton.zPosition = 1
        self.addChild(replayButton)
        /*
        mainMenuLabel = SKLabelNode(fontNamed: "Chalkduster")
        mainMenuLabel.text = "Home"
        mainMenuLabel.fontSize = 35
        mainMenuLabel.fontColor = SKColor.black
        mainMenuLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        mainMenuLabel.zPosition = 1
        self.addChild(mainMenuLabel)
         */
        
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
                    pauseMusic.removeFromParent()
                    let transition = SKTransition.flipVertical(withDuration: 0.5)
                    let scene = SKScene(fileNamed: "MenuScene") as! MenuScene
                        // Set the scale mode to scale to fit the window
                    scene.newDifficulty = self.newDifficulty
                    scene.scaleMode = .fill
                    view?.presentScene(scene, transition: transition)
                } else if node.name == "replay_button" && newDifficulty == "Kids Mode"{
                    pauseMusic.removeFromParent()
                    let transition = SKTransition.flipVertical(withDuration: 0.5)
                    let scene = SKScene(fileNamed: "KidsModeScene") as! KidsModeScene
                        // Set the scale mode to scale to fit the window
                    scene.newDifficulty = "Kids Mode"
                    scene.scaleMode = .fill
                    view?.presentScene(scene, transition: transition)
                } else if node.name == "replay_button" && newDifficulty == "Normal"{
                    pauseMusic.removeFromParent()
                    let transition = SKTransition.flipVertical(withDuration: 0.5)
                    let scene = SKScene(fileNamed: "GameScene") as! GameScene
                        // Set the scale mode to scale to fit the window
                    scene.newDifficulty = "Normal"
                    scene.scaleMode = .fill
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
