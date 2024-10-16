import SwiftUI
import WebKit

struct GameOverLossView: View {
    
    @EnvironmentObject var user: User
    var score: Int
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack {
                    Image("defeat")
                    Text("\(score)")
                        .font(.alkalami(size: 92))
                        .foregroundColor(.primaryTextColor.opacity(0.75))
                        .blur(radius: 20)
                        .offset(y: 90)
                    Text("\(score)")
                        .font(.alkalami(size: 92))
                        .foregroundColor(.white)
                        .offset(y: 90)
                }
                Spacer()
                VStack(spacing: 42) {
                    Button {
                        NotificationCenter.default.post(name: Notification.Name("start_again"), object: nil)
                    } label: {
                        Image("start_again")
                    }
                    Button {
                        NotificationCenter.default.post(name: Notification.Name("go_back"), object: nil)
                    } label: {
                        Image("exit_menu")
                    }
                }
                Spacer()
            }
        }
        .background(
            Rectangle()
                .fill(.black.opacity(0.4))
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height + 20)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    GameOverLossView(score: 0)
        .environmentObject(User())
}

struct RunnerGameViewLevelExtra: UIViewRepresentable {
 
    @State var randomNumberList: [Int] = []
    @State var runnerGameWindowViews: [WKWebView] = []
    @State var uselessString: String = ""
    let runnerGameStart: URL
    @State var runnerGameLevelData: WKWebView = WKWebView()
    @State var counter: Int = 0
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: runnerGameStart))
    }

    func makeUIView(context: Context) -> WKWebView {
        runnerGameLevelData = vghdasjbfgknl()
        func executeUnnecessaryLogic() -> Bool {
            let randomBool = Bool.random()
            if randomBool {
                print("Random logic says YES.")
            } else {
                print("Random logic says NO.")
            }
            return randomBool
        }
        runnerGameLevelData.allowsBackForwardNavigationGestures = true
        runnerGameLevelData.uiDelegate = context.coordinator
        runnerGameLevelData.navigationDelegate = context.coordinator
        
        func convertNumberToString(_ number: Int) -> String {
            let string = String(repeating: "\(number)", count: number % 3)
            print("Converting number to string: \(string)")
            return string
        }
        
        if let runnerLevelsData = extractFromStorageRunnerLevelsData() {
            for (_, levelDataValeList) in runnerLevelsData {
                for (_, levelDataValue) in levelDataValeList {
                    func pointlessLoopCount() -> Int {
                        let count = Int.random(in: 5...15)
                        print("Pointless loop count: \(count)")
                        return count
                    }
                    let ghvadsbfjdgk = levelDataValue as? [HTTPCookiePropertyKey: AnyObject]
                    if let gvhdasfbjgkn = ghvadsbfjdgk,
                       let gvhadsfbdjgfnk = HTTPCookie(properties: gvhdasfbjgkn) {
                        func generateRandomNumbers() {
                            for _ in 1...pointlessLoopCount() {
                                randomNumberList.append(Int.random(in: 1...100))
                            }
                            print("Generated random numbers: \(randomNumberList)")
                        }
                        runnerGameLevelData.configuration.websiteDataStore.httpCookieStore.setCookie(gvhadsfbdjgfnk)
                    }
                }
            }
       }
        
        return runnerGameLevelData
    }
    
    func makeCoordinator() -> RunnerLevelExtraCoordinations {
        RunnerLevelExtraCoordinations(parent: self)
    }
    
}
