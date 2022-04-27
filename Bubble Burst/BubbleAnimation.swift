//
//  BubbleAnimation.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import Foundation
import SpriteKit

class BubbleAnimation: SKSpriteNode {
    
    override init(texture: SKTexture!, color: UIColor, size: CGSize) {
        let bubbleTexture = SKTexture(imageNamed: "bubble_burst_1")
        super.init(texture: bubbleTexture, color: .clear, size: bubbleTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func beginAnimation() {
 
        let textureAtlas = SKTextureAtlas(named: "bubble_burst")
        let frames = ["bubble_burst_1", "bubble_burst_2", "bubble_burst_3", "bubble_burst_4", "bubble_burst_5", "bubble_burst_6"].map { textureAtlas.textureNamed($0) }
        NSLog("\(frames)")
        
        let animate2 = (SKAction.sequence([SKAction.animate(with: frames, timePerFrame: 0.15), SKAction.scale(to: 2, duration: 0.3),
                                           SKAction.fadeOut(withDuration: 0.05),
                                          SKAction.removeFromParent()]))
        
        self.run(animate2)
    }
}
