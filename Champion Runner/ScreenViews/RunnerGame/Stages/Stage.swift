import Foundation
import SpriteKit

protocol Stage {
    func buildStage(scene: RunnerGameScene, cameraNode: SKCameraNode)
    func createPersonage(scene: RunnerGameScene, cameraNode: SKCameraNode) -> SKSpriteNode
}
