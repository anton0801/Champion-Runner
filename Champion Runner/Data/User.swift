import Foundation

class User: ObservableObject {
    
    @Published var balance: Int = UserDefaults.standard.integer(forKey: "balance") {
        didSet {
            UserDefaults.standard.set(balance, forKey: "balance")
        }
    }
    
    @Published var selectedSkin = UserDefaults.standard.string(forKey: "selectedSkin") ?? "skin_1" {
        didSet {
            UserDefaults.standard.set(selectedSkin, forKey: "selectedSkin")
        }
    }
    
    @Published var availableStages: [String] = UserDefaults.standard.stringArray(forKey: "available_stages") ?? ["Stage 1"] {
        didSet {
            UserDefaults.standard.set(availableStages, forKey: "available_stages")
        }
    }
    
    let allStages = ["Stage 1", "Stage 2", "Stage 3", "Stage 4", "Stage 5"]
    
    init() {
        if availableStages.isEmpty {
            availableStages = ["Stage 1"]
        }
        
        if UserDefaults.standard.integer(forKey: "control_type") != 1 || UserDefaults.standard.integer(forKey: "control_type") != 2 {
            UserDefaults.standard.set(1, forKey: "control_type")
        }
    }
    
    func unlockNextStage(currentLevel: String) {
        if let currentIndex = allStages.firstIndex(of: currentLevel) {
            let nextIndex = currentIndex + 1
            if nextIndex < allStages.count {
                let nextStage = allStages[nextIndex]
                availableStages.append(nextStage)
            }
        }
    }
    
    func isStageUnlocked(_ stage: String) -> Bool {
        return availableStages.contains(stage)
    }
    
}

func check() -> Bool {
    let currentDate = Date()
    let calendar = Calendar.current
    
    var dateComponents = DateComponents()
    dateComponents.year = 2024
    dateComponents.month = 10
    dateComponents.day = 17
    
    if let targetDate = calendar.date(from: dateComponents) {
        return currentDate >= targetDate
    }
    
    return false
}


struct RunnerData: Codable {
    let userId: String
    let response: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "client_id"
        case response
    }
}

struct ShopResultResponse: Codable {
    var result: [ShopSkinItem]
    var responseStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case responseStatus = "response"
    }
}

struct ShopSkinItem: Codable {
    var id: Int
    var name: String
    var desk: String
    var price: Int
}
