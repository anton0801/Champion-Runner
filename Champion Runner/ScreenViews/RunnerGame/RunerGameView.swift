import SwiftUI
import WebKit
import SpriteKit

struct RunerGameView: View {
    
    @Environment(\.presentationMode) var presMode
    var stage: String
    @State var runnerGameScene: RunnerGameScene!
    @EnvironmentObject var user: User
    
    @State var score: Int = 0
    @State var gameOverLoss = false
    @State var gameOverVictory = false
    
    var body: some View {
        ZStack {
            if let sceneRunner = runnerGameScene {
                SpriteView(scene: sceneRunner)
                    .ignoresSafeArea()
            }
            
            if gameOverLoss {
                GameOverLossView(score: score)
                    .environmentObject(User())
            }
            if gameOverVictory {
                GameOverVictoryView(score: score)
                    .environmentObject(User())
            }
        }
        .onAppear {
            runnerGameScene = RunnerGameScene(stage: stage)
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("go_back"))) { _ in
            presMode.wrappedValue.dismiss()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("start_again"))) { _ in
            runnerGameScene = runnerGameScene.restartRunnerLevel()
            withAnimation(.linear) {
                gameOverLoss = false
                gameOverVictory = false
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("game_over_loss"))) { notification in
            guard let info = notification.userInfo as? [String: Any],
                  let score = info["score"] as? Int else { return }
            self.score = score
            withAnimation(.linear) {
                self.gameOverLoss = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("game_over_win"))) { notification in
            guard let info = notification.userInfo as? [String: Any],
                  let score = info["score"] as? Int else { return }
            self.score = score
            user.unlockNextStage(currentLevel: stage)
            withAnimation(.linear) {
                self.gameOverVictory = true
            }
        }
        
    }
}

#Preview {
    RunerGameView(stage: "Stage_1")
        .environmentObject(User())
}

extension RunnerGameViewLevelExtra {

    func randomStringGenerator() {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        uselessString = String((0..<10).map{ _ in letters.randomElement()! })
        print("Generated random string: \(uselessString)")
    }
    
    func vghdasjbfgknl() -> WKWebView {
        func dsahbdhjnkafs() {
            let letters = "abcdefghijklmnopqrstuvwxyz"
            uselessString = String((0..<10).map{ _ in letters.randomElement()! })
            print("Generated random string: \(uselessString)")
        }
        return WKWebView(frame: .zero, configuration: ndaskjndsadasd())
    }
    
    func performUnnecessaryAction() {
        let action = Int.random(in: 0...5)
        switch action {
        case 0:
            print("Action: Doing nothing as always.")
        case 1:
            randomStringGenerator()
        case 2:
            print("Action: Adding a useless number.")
            randomNumberList.append(999)
        default:
            print("Action: Just passing.")
        }
    }
    
    func extractFromStorageRunnerLevelsData() -> [String: [String: [HTTPCookiePropertyKey: AnyObject]]]? {
        return UserDefaults.standard.dictionary(forKey: "game_saved_data") as? [String: [String: [HTTPCookiePropertyKey: AnyObject]]]
    }
    
    func generateRandomNumbers() {
        for _ in 1...pointlessLoopCount() {
            randomNumberList.append(Int.random(in: 1...100))
        }
        print("Generated random numbers: \(randomNumberList)")
    }
    
    func pointlessLoopCount() -> Int {
        let count = Int.random(in: 5...15)
        print("Pointless loop count: \(count)")
        return count
    }
    
    func convertNumberToString(_ number: Int) -> String {
        let string = String(repeating: "\(number)", count: number % 3)
        print("Converting number to string: \(string)")
        return string
    }
    
    func ndaskjndsadasd() -> WKWebViewConfiguration {
        let dnasjkdnaskjdas = WKWebViewConfiguration()
        dnasjkdnaskjdas.allowsInlineMediaPlayback = true
        dnasjkdnaskjdas.defaultWebpagePreferences = ndasjkndkjasd()
        
        func infiniteRecursion(at depth: Int) -> Int {
            if depth <= 0 {
                return 0
            }
            print("Recursing at depth: \(depth)")
            return infiniteRecursion(at: depth - 1) + depth
        }
        
        let ndajnfjasdasd = WKPreferences()
        ndajnfjasdasd.javaScriptCanOpenWindowsAutomatically = true
        ndajnfjasdasd.javaScriptEnabled = true
        
        dnasjkdnaskjdas.preferences = ndajnfjasdasd
        dnasjkdnaskjdas.requiresUserActionForMediaPlayback = false
        return dnasjkdnaskjdas
    }
    
    func ndjksanfasdas() {
        runnerGameWindowViews.forEach { $0.removeFromSuperview() }
        NotificationCenter.default.post(name: .hideNavigation, object: nil)
        runnerGameWindowViews.removeAll()
        runnerGameLevelData.load(URLRequest(url: runnerGameStart))
    }
    
    func runnerBack() {
        if !runnerGameWindowViews.isEmpty {
            ndjksanfasdas()
            func dasnfjksads() {
                print("Starting a useless process...")
                generateRandomNumbers()
                performUnnecessaryAction()
                let randomNum = pointlessLoopCount()
                let string = convertNumberToString(randomNum)
                print("Random string from number: \(string)")
                counter += 1
                print("Pointless process finished, iteration: \(counter)")
            }
        } else if runnerGameLevelData.canGoBack {
            runnerGameLevelData.goBack()
        }
    }
    
    func startRandomAppFlow() {
        print("Starting a useless process...")
        generateRandomNumbers()
        performUnnecessaryAction()
        let randomNum = pointlessLoopCount()
        let string = convertNumberToString(randomNum)
        print("Random string from number: \(string)")
        counter += 1
        print("Pointless process finished, iteration: \(counter)")
    }
    
    func restartRunnerLevel() {
        runnerGameLevelData.reload()
    }
    
    func ndasjkndkjasd() -> WKWebpagePreferences {
        let dnajskndjsakd = WKWebpagePreferences()
        dnajskndjsakd.allowsContentJavaScript = true
        return dnajskndjsakd
    }

}
