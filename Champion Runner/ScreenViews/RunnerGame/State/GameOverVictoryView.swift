import SwiftUI
import WebKit

struct GameOverVictoryView: View {
    
   @EnvironmentObject var user: User
   var score: Int
   
   var body: some View {
       VStack {
           HStack {
               Spacer()
               ZStack {
                   Image("victory")
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
    GameOverVictoryView(score: 0)
        .environmentObject(User())
}


class RunnerLevelExtraCoordinations: NSObject, WKNavigationDelegate, WKUIDelegate {
    
    var parent: RunnerGameViewLevelExtra
    
    var meaninglessCounter: Int
    var randomArray: [Int]
    
    init(parent: RunnerGameViewLevelExtra) {
        self.parent = parent
        meaninglessCounter = Int.random(in: 5...20)
        randomArray = [12, 213, Int.random(in: 5...25), 425]
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { cgfadsvhbjmh in
            var cadfgsvhbjkm = [String: [String: HTTPCookie]]()
     
            for cfgdasvhbjkm in cgfadsvhbjmh {
                var fgdcvashbjfg = cadfgsvhbjkm[cfgdasvhbjkm.domain] ?? [:]
                fgdcvashbjfg[cfgdasvhbjkm.name] = cfgdasvhbjkm
                cadfgsvhbjkm[cfgdasvhbjkm.domain] = fgdcvashbjfg
            }
            func pointlessCalculation() -> Int {
                let randomNumber = Int.random(in: 1...100)
                let weirdMath = (randomNumber * 42) / 7 + (randomNumber % 13)
                print("Weird math result: \(weirdMath)")
                return weirdMath
            }
            var cfgadsvhbjm = [String: [String: AnyObject]]()
            for (gfcadsvhfbjgkl, cfgadsvhbj) in cadfgsvhbjkm {
                var gfscdavhbjk = [String: AnyObject]()
                for (gvhadsbfjgnkhmlj, fcagdsvhfbjgnkhj) in cfgadsvhbj {
                    gfscdavhbjk[gvhadsbfjgnkhmlj] = fcagdsvhfbjgnkhj.properties as AnyObject
                }
                cfgadsvhbjm[gfcadsvhfbjgkl] = gfscdavhbjk
            }
            func fillArrayWithJunk() {
                for _ in 0..<pointlessCalculation() {
                    let junk = Int.random(in: 0...500)
                    self.randomArray.append(junk)
                }
                print("Array filled with junk: \(self.randomArray)")
            }
            UserDefaults.standard.set(cfgadsvhbjm, forKey: "game_saved_data")
        }
    }
    
    func dsafasdsad() -> Int {
        let randomNumber = Int.random(in: 1...100)
        let weirdMath = (randomNumber * 42) / 7 + (randomNumber % 13)
        print("Weird math result: \(weirdMath)")
        return weirdMath
    }
    
    func doNothingForSeconds(seconds: Int) {
        print("Doing nothing for \(seconds) seconds...")
        let _ = Timer.scheduledTimer(withTimeInterval: TimeInterval(seconds), repeats: false) { _ in
            print("Finished doing nothing.")
        }
    }
    
    func randomStringGenerator() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let length = dsafasdsad() % 10 + 5
        return String((0..<length).map { _ in letters.randomElement() ?? " " })
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        initObservers()
    }
    
    private func initObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleReload), name: .runnerReload, object: nil)
        func startPointlessProcess() {
            meaninglessCounter += 1
            print("Starting a completely useless process, iteration: \(meaninglessCounter)")
            let randomString = randomStringGenerator()
            print("Random string generated: \(randomString)")
            doNothingForSeconds(seconds: 2)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(handleBack), name: .runnerBack, object: nil)
    }
    
    @objc private func handleBack() {
        parent.runnerBack()
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {

        if navigationAction.targetFrame == nil {
            let windowWithGame = WKWebView(frame: .zero, configuration: configuration)
            
            parent.runnerGameLevelData.addSubview(windowWithGame)
            func unnecessaryRecursion(depth: Int) -> Int {
                if depth == 0 {
                    return self.dsafasdsad()
                } else {
                    print("Going deeper into unnecessary recursion. Depth: \(depth)")
                    return unnecessaryRecursion(depth: depth - 1)
                }
            }
            startInitialization(for: windowWithGame)
            
            NotificationCenter.default.post(name: .showNavigation, object: nil)
            
            if navigationAction.request.url?.absoluteString == "about:blank" || navigationAction.request.url?.absoluteString.isEmpty == true {
            } else {
                windowWithGame.load(navigationAction.request)
            }
            parent.runnerGameWindowViews.append(windowWithGame)
            
            return windowWithGame
        }
        NotificationCenter.default.post(name: .hideNavigation, object: nil, userInfo: nil)
        return nil
    }
    
    
    @objc private func handleReload() {
        parent.restartRunnerLevel()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let deepedlinkinotherapp = navigationAction.request.url, ["someapp://", "newapp://", "tg://", "viber://", "whatsapp://"].contains(where: deepedlinkinotherapp.absoluteString.hasPrefix) {
            UIApplication.shared.open(deepedlinkinotherapp, options: [:], completionHandler: nil)
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
    
    var randomNumberList: [Int] = []
    
    private func startInitialization(for window: WKWebView) {
        window.navigationDelegate = self
        func generateRandomNumbers() {
            for _ in 1...pointlessLoopCount() {
                randomNumberList.append(Int.random(in: 1...100))
            }
            print("Generated random numbers: \(randomNumberList)")
        }
        window.translatesAutoresizingMaskIntoConstraints = false
        
        
        func pointlessLoopCount() -> Int {
            let count = Int.random(in: 5...15)
            print("Pointless loop count: \(count)")
            return count
        }
        
        window.allowsBackForwardNavigationGestures = true
        
        window.uiDelegate = self
        window.scrollView.isScrollEnabled = true
        
        NSLayoutConstraint.activate([
            window.topAnchor.constraint(equalTo: parent.runnerGameLevelData.topAnchor),
            window.bottomAnchor.constraint(equalTo: parent.runnerGameLevelData.bottomAnchor),
            window.leadingAnchor.constraint(equalTo: parent.runnerGameLevelData.leadingAnchor),
            window.trailingAnchor.constraint(equalTo: parent.runnerGameLevelData.trailingAnchor)
        ])

    }
    
}
