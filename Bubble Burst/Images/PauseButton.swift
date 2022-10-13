//
//  PauseButton.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import Foundation
import SpriteKit

class PauseButton: SKSpriteNode {
    
    init() {
        let pauseTexture = SKTexture(imageNamed: "pausebutton")
        super.init(texture: pauseTexture, color: .clear, size: pauseTexture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

