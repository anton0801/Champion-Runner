import SpriteKit


class PilaNode: SKSpriteNode {
    
    init(isVertical: Bool, size: CGSize) {
        var lineSrc = "line_vertical"
        if !isVertical {
            lineSrc = "line_horizontal"
        }
        let lineTexture = SKTexture(imageNamed: lineSrc)
        let lineNode = SKSpriteNode(texture: lineTexture)
        lineNode.size = CGSize(width: 10, height: size.height)
        
        let pila = SKSpriteNode(imageNamed: "pila")
        pila.physicsBody = SKPhysicsBody(circleOfRadius: pila.size.width / 2)
        pila.physicsBody?.isDynamic = false
        pila.physicsBody?.affectedByGravity = false
        pila.physicsBody?.categoryBitMask = 3
        pila.physicsBody?.collisionBitMask = 1
        pila.physicsBody?.contactTestBitMask = 1
        pila.name = "pila"
        
        super.init(texture: nil, color: .clear, size: size)
        addChild(lineNode)
        addChild(pila)
        
        let rotateAction = SKAction.rotate(byAngle: CGFloat.pi, duration: 1)
        let repeatRotation = SKAction.repeatForever(rotateAction)
        if isVertical {
            let moveUpFirstAction = SKAction.move(to: CGPoint(x: 0, y: 80), duration: 1)
            let moveUpAction = SKAction.move(to: CGPoint(x: 0, y: 80), duration: 2)
            let moveDownAction = SKAction.move(to: CGPoint(x: 0, y: -80), duration: 2)
            let repeate = SKAction.repeatForever(SKAction.sequence([moveDownAction, moveUpAction]))
            let seq = SKAction.sequence([moveUpFirstAction, repeate])
            pila.run(SKAction.group([repeatRotation, seq]))
        } else {
            let moveRightFirstAction = SKAction.move(to: CGPoint(x: 80, y: 0), duration: 1)
            let moveRightAction = SKAction.move(to: CGPoint(x: 80, y: 0), duration: 2)
            let moveLeftAction = SKAction.move(to: CGPoint(x: -80, y: 0), duration: 2)
            let repeate = SKAction.repeatForever(SKAction.sequence([moveLeftAction, moveRightAction]))
            let seq = SKAction.sequence([moveRightFirstAction, repeate])
            pila.run(SKAction.group([repeatRotation, seq]))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
