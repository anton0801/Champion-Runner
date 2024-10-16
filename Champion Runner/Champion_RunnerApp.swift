import SwiftUI

@main
struct Champion_RunnerApp: App {
    
    @UIApplicationDelegateAdaptor(ChampionRunnerDelegate.self) var championRunnerDelegate
    
    var body: some Scene {
        WindowGroup {
            LoadingRunnerView()
        }
    }
}

extension Notification.Name {
    static let runnerBack = Notification.Name("runner_back")
    static let runnerGoLeft = Notification.Name("runner_go_left")
    static let runnerReload = Notification.Name("reload_runner")
    static let runnerGoRight = Notification.Name("runner_go_right")
    static let runnerJump = Notification.Name("runner_jump")
}
