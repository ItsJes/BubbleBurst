//
//  GamePausedImage.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import Foundation
import SpriteKit

class GamePausedImage: SKSpriteNode {
    
    init() {
        let gamePausedTexture = SKTexture(imageNamed: "gamePaused")
        super.init(texture: gamePausedTexture, color: .clear, size: gamePausedTexture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

