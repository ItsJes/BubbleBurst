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
    
    
    func pauseButtonImage() {
        let textureAtlas = SKTextureAtlas(named: "pause_button")
        let frames = ["pausebutton"].map { textureAtlas.textureNamed($0) }
        NSLog("\(frames)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

