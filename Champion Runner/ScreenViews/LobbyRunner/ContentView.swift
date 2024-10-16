import SwiftUI

struct ContentView: View {
    
    @StateObject var user = User()
    @State var infoAlertVisible = false
    @State var claimedReward = UserDefaults.standard.bool(forKey: "reward_claimed")
    @State var claimedRewardAlert = false
    @State var alertVisible = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("balance")
                        .opacity(0)
                    
                    Spacer()
                    
                    Text("MENU")
                        .font(.alkalami(size: 52))
                        .foregroundColor(.primaryTextColor)
                        .shadow(color: .white, radius: 2, x: -1)
                        .shadow(color: .white, radius: 2, x: 1)
                    
                    Spacer()
                    
                    ZStack {
                        Image("balance")
                        Text("\(user.balance)")
                            .font(.alkalami(size: 24))
                            .foregroundColor(.white)
                            .offset(y: 5)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 52) {
                    Button {
                        if !claimedReward {
                            claimedReward = true
                            user.balance += 500
                            UserDefaults.standard.set(true, forKey: "reward_claimed")
                        } else {
                            claimedReward = false
                        }
                        claimedRewardAlert = true
                        alertVisible = true
                    } label: {
                        Image("reward")
                    }
                    
                    NavigationLink(destination: MapsView()
                        .environmentObject(user)
                        .navigationBarBackButtonHidden()) {
                        Image("btn_play")
                    }
                    
                    
                    NavigationLink(destination: ShopGameView()
                        .environmentObject(user)
                        .navigationBarBackButtonHidden()) {
                        Image("btn_shop")
                    }
                    
                }
                
                Spacer()
                
                HStack(spacing: 32) {
                    Button {
                        infoAlertVisible = true
                        alertVisible = true
                    } label: {
                        Image("btn_info")
                    }
                    
                    NavigationLink(destination: SettingsGameView()
                        .environmentObject(user)
                        .navigationBarBackButtonHidden()) {
                        Image("btn_settings")
                    }
                }
            }
            .preferredColorScheme(.dark)
            .background(
                Image("main_background")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height + 20)
                    .opacity(0.6)
                    .ignoresSafeArea()
            )
            .alert(isPresented: $alertVisible) {
                if claimedRewardAlert {
                    if claimedReward {
                        Alert(title: Text("Reward claimed!"), message: Text("+500 points in your balance"), dismissButton: .default(Text("Thanks!"), action: {
                            claimedRewardAlert = false
                        }))
                    } else {
                        Alert(title: Text("Reward claim failed!"), message: Text("You have claimed reward!"), dismissButton: .default(Text("Ok!"), action: {
                            claimedRewardAlert = false
                        }))
                    }
                } else {
                    Alert(title: Text("Info!"), message: Text("In this game you need to avoid obstacles and catch stars and buy skins and play on different maps. Good luck!"), dismissButton: .default(Text("Ok!"), action: {
                        infoAlertVisible = false
                    }))
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}
