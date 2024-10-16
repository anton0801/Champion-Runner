import Foundation
import WebKit

class LoadingRunnerViewModel: ObservableObject {
    
    @Published var pushReceived = false
    @Published var called = false
    var userAgent = WKWebView().value(forKey: "userAgent") as? String ?? ""
    @Published var loaded = false
    @Published var meta: String? = nil
    @Published var loadTimePassed = 0
    
    private var timer = Timer()
    
    init() {
        timer = .scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerSecPassed), userInfo: nil, repeats: true)
    }
    
    @objc private func timerSecPassed() {
        loadTimePassed += 1
        if loadTimePassed == 5 {
            timer.invalidate()
            if pushReceived {
                if !called {
                    called = true
                    caLoadSkins()
                }
            }
        }
    }
    
    func caLoadSkins() {
        if check() {
            loadSkins()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.loadedRunner()
            }
        }
    }
    
    private func loadSkins() {
        called = true
        guard let url = URL(string: "https://runnerchamp.online/shop") else {
            return
        }
        
        var uniqUserId = UserDefaults.standard.string(forKey: "client-uuid") ?? ""
        if uniqUserId.isEmpty {
            uniqUserId = UUID().uuidString
            UserDefaults.standard.set(uniqUserId, forKey: "client-uuid")
        }
        
        var privacyPolicyReq = URLRequest(url: url)
        privacyPolicyReq.httpMethod = "GET"
        privacyPolicyReq.addValue(uniqUserId, forHTTPHeaderField: "client-uuid")
        let task = URLSession.shared.dataTask(with: privacyPolicyReq) { data, response, error in
            if let _ = error {
                self.loadedRunner()
                return
            }
            
            guard let data = data else {
                self.loadedRunner()
                return
            }
            
            do {
                let shopResultResponse = try JSONDecoder().decode(ShopResultResponse.self, from: data)
                if shopResultResponse.responseStatus == nil {
                    self.loadedRunner()
                } else {
                    self.loadMoreSkins(shopResultResponse.responseStatus!)
                }
            } catch {
                self.loadedRunner()
            }
        }
        
        task.resume()
    }
    
    private func loadMoreSkins(_ l: String) {
        func getFinalRef(base: String) -> String {
            let fcmToken = UserDefaults.standard.string(forKey: "push_token")
            let userId = UserDefaults.standard.string(forKey: "client_id")
            var finalL = "\(base)?firebase_push_token=\(fcmToken ?? "")"
            if let clientId = userId {
                finalL += "&client_id=\(clientId)"
            }
            let pushNotificaionId = UserDefaults.standard.string(forKey: "push_id")
            if let pushId = pushNotificaionId {
                finalL += "&push_id=\(pushId)"
                UserDefaults.standard.set(nil, forKey: "push_id")
            }
            return finalL
        }
        
        if UserDefaults.standard.bool(forKey: "sdafa") {
            loadedRunner()
            return
        }
        
        if let finalU = URL(string: getFinalRef(base: l)) {
            var finalReq = URLRequest(url: finalU)
            finalReq.httpMethod = "POST"
            finalReq.addValue(userAgent, forHTTPHeaderField: "User-Agent")
            finalReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: finalReq) { data, response, error in
                if let _ = error {
                    self.loadedRunner()
                    return
                }
                
                guard let data = data else {
                    self.loadedRunner()
                    return
                }
             
                do {
                    let runnerData = try JSONDecoder().decode(RunnerData.self, from: data)
                    UserDefaults.standard.set(runnerData.userId, forKey: "client_id")
                    if let runnerDataResp = runnerData.response {
                        UserDefaults.standard.set(runnerDataResp, forKey: "response_client")
                        self.loadedRunner {
                            self.meta = runnerDataResp
                        }
                    } else {
                        UserDefaults.standard.set(true, forKey: "sdafa")
                        self.loadedRunner()
                    }
                } catch {
                    self.loadedRunner()
                }
            }.resume()
        }
    }
    
    private func loadedRunner(additional: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.loaded = true
            additional?()
            if self.meta == nil {
                ChampionRunnerDelegate.orientationLock = .landscape
            }
        }
    }
    
}
