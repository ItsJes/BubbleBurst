//
//  DifficultyButton.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import Foundation
import SpriteKit

class DifficultyButton: SKSpriteNode {
    
    init() {
        let difficultyTexture = SKTexture(imageNamed: "bluebubblebox")
        super.init(texture: difficultyTexture, color: .clear, size: difficultyTexture.size())
    }
    
    
    func difficultyButtonImage() {
        let textureAtlas = SKTextureAtlas(named: "difficulty_button")
        let frames = ["bluebubblebox"].map { textureAtlas.textureNamed($0) }
        NSLog("\(frames)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
