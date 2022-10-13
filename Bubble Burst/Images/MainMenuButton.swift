//
//  MainMenuButton.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import Foundation
import SpriteKit

class MainMenuButton: SKSpriteNode {
    
    init() {
        let mainMenuTexture = SKTexture(imageNamed: "homebutton")
        super.init(texture: mainMenuTexture, color: .clear, size: mainMenuTexture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

