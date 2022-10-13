//
//  ReplayButton.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import Foundation
import SpriteKit

class ReplayButton: SKSpriteNode {
    
    init() {
        let replayTexture = SKTexture(imageNamed: "replaybutton")
        super.init(texture: replayTexture, color: .clear, size: replayTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
