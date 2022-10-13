//
//  GoodJobImage.swift
//  Bubble Burst
//
//  Created by Jessica Sendejo on 4/27/22.
//

import Foundation
import SpriteKit

class GoodJobImage: SKSpriteNode {
    
    init() {
        let goodJobTexture = SKTexture(imageNamed: "goodjob")
        super.init(texture: goodJobTexture, color: .clear, size: goodJobTexture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

