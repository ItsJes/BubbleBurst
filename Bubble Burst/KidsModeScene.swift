//
//  KidsModeScene.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import UIKit
import SpriteKit
import GameplayKit

class KidsModeScene: SKScene {

    var label : SKLabelNode!
    private var spinnyNode : SKShapeNode!
    var scoreLabel: SKLabelNode!
    var timeLabel: SKLabelNode!
    var bubble: SKSpriteNode!
    var bubbleUp: SKSpriteNode!
    var bubbleBurst: SKSpriteNode!
    var newDifficulty: String!
    var timer: Timer!
    let pauseButton = PauseButton()
    var kidsMusic: SKAudioNode!
    var bubbleTimer: Timer! = nil
    var timerLabelUpdate: Timer! = nil
    var bubbles = ["pink_bubble", "rainbow_bubble", "soap_bubble"]
    var newScore: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(newScore)"
        }
    }
    
    var newTime: Int = 60 {
        didSet {
            timeLabel.text = "Time: \(newTime)"
        }
    }
    

   // var game: GameManager!
    
    override func didMove(to view: SKView) {

        initializeGameView()
        startGame()
        getBubbleTimer()
        newScore = 0
        getTimeLabel()
        timer = Timer.scheduledTimer(timeInterval: 61.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        if let musicURL = Bundle.main.url(forResource: "words", withExtension: "mp3") {
            kidsMusic = SKAudioNode(url: musicURL)
            addChild(kidsMusic)
        }

    }
    
    @objc func updateTime(){
        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
        let congratsScene = SKScene(fileNamed: "CongratsScene") as! CongratsScene
        congratsScene.scaleMode = .aspectFill
        congratsScene.score = self.newScore
        congratsScene.newDifficulty = self.newDifficulty
        self.view?.presentScene(congratsScene, transition: transition)
    }
    
    @objc func updateTimeLabel(){
        newTime -= 1
    }
    
    // this function sets the game board and scores
    private func initializeGameView()
    {
        self.backgroundColor = UIColor.black
        scoreLabel = SKLabelNode(fontNamed: "ChalkDuster")
        scoreLabel.text = "Score 0"
        scoreLabel.zPosition = 1
        scoreLabel.position = CGPoint(x: self.frame.midX - 240, y: self.frame.midY + 580)
        scoreLabel.fontSize = 35
        scoreLabel.fontColor = SKColor.white
        //scoreLabel.isHidden = true
        self.addChild(scoreLabel)
        
        
        timeLabel = SKLabelNode(fontNamed: "ChalkDuster")
        timeLabel.text = "Time 60"
        timeLabel.zPosition = 1
        timeLabel.position = CGPoint(x: self.frame.midX - 240, y: self.frame.midY + 620)
        timeLabel.fontSize = 35
        timeLabel.fontColor = SKColor.white
        self.addChild(timeLabel)
        
        pauseButton.name = "pause_button"
        pauseButton.position = CGPoint(x: self.frame.midX + 210, y: self.frame.midY + 630)
        pauseButton.size = CGSize(width: 50, height: 50)
        self.addChild(pauseButton)
        
    }
    func getTimeLabel(){
        bubbleTimer = Timer.scheduledTimer(timeInterval: 1, target: self,selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
    }
    
    
    
    func getBubbleTimer(){
        let bubbleTimeInterval = Double.random(in: 0.10..<1.5)
        bubbleTimer = Timer.scheduledTimer(timeInterval: bubbleTimeInterval, target: self,selector: #selector(addBubbles), userInfo: nil, repeats: true)
    }
    
    @objc func addBubbles(){
        let randomNumber = Int.random(in: 75..<150)
        let randomDuration = Int.random(in: 6..<10)
        let randomDurationUp = Int.random(in: 6..<10)
        bubbles = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: bubbles) as! [String]
        bubble = SKSpriteNode(imageNamed: bubbles[0])
        bubble.name = "bubble_name"
        bubble.size = CGSize(width: randomNumber, height: randomNumber)
        let randomBubble = GKRandomDistribution(lowestValue: -Int(self.frame.size.width) / 3, highestValue: Int(self.frame.size.width) / 3)
        
        let position = CGFloat(randomBubble.nextInt())
        
        bubble.position = CGPoint(x: position, y: self.frame.size.height + bubble.size.height)
        
        self.addChild(bubble)
        
        let animateTime: TimeInterval = TimeInterval(randomDuration)
        var actionArray = [SKAction]()
        actionArray.append(SKAction.move(to: CGPoint(x: position, y: -self.frame.size.height), duration: animateTime))
        
        actionArray.append(SKAction.removeFromParent())
        bubble.run(SKAction.sequence(actionArray))
        
        bubbleUp = SKSpriteNode(imageNamed: bubbles[1])
        bubbleUp.name = "bubble_name"
        bubbleUp.size = CGSize(width: randomNumber, height: randomNumber)
        
        let randomBubbleUp = GKRandomDistribution(lowestValue: -Int(self.frame.size.width) / 3, highestValue: Int(self.frame.size.width) / 3)
        
        let positionUp = CGFloat(randomBubbleUp.nextInt())
        
        bubbleUp.position = CGPoint(x: positionUp, y: self.frame.size.height + bubbleUp.size.height)
        
        self.addChild(bubbleUp)
        
        let animateTimeUp: TimeInterval = TimeInterval(randomDurationUp)
        var actionArrayUp = [SKAction]()
        actionArrayUp.append(SKAction.move(to: CGPoint(x: positionUp, y: -self.frame.size.height), duration: animateTimeUp))
        
        actionArrayUp.append(SKAction.removeFromParent())
        bubbleUp.run(SKAction.sequence(actionArrayUp))
        
    }
    
    func popBubble(){
        bubbleBurst = SKSpriteNode(imageNamed: "bubble_burst")
        bubbleBurst.name = "burst"
        bubbleBurst.size = bubble.size
        self.addChild(bubbleBurst)
        
    }
    
    private func startGame()
    {
        scoreLabel.run(SKAction.fadeIn(withDuration: 1.0))
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
                if node.name == "pause_button"
                {
                    let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                    let pauseScene = SKScene(fileNamed: "PauseScene") as! PauseScene
                    pauseScene.scaleMode = .aspectFill
                
                    pauseScene.newDifficulty = self.newDifficulty
                    self.view?.presentScene(pauseScene, transition: transition)
                }else if(node.name == "bubble_name"){
                    newScore += 1
                    node.removeFromParent()
                    popBubble()
                    bubbleBurst.position = node.position
                    bubbleBurst.run(SKAction.sequence([SKAction.fadeIn(withDuration: 0.3), SKAction.playSoundFileNamed("bubblepop.mp3", waitForCompletion: false), SKAction.wait(forDuration: 1), SKAction.fadeOut(withDuration: 1), SKAction.removeFromParent()]))
                    
                   // print("\(bubble)")
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self))
        }
        
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


