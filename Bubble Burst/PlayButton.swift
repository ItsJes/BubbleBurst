//
//  PlayButton.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import Foundation
import SpriteKit

class PlayButton: SKSpriteNode {
    
    init() {
        let buttonTexture = SKTexture(imageNamed: "playbutton")
        super.init(texture: buttonTexture, color: .clear, size: buttonTexture.size())
    }
    
    
    func playButtonImage() {
        let textureAtlas = SKTextureAtlas(named: "play_button")
        let frames = ["playbutton"].map { textureAtlas.textureNamed($0) }
        NSLog("\(frames)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

