import SwiftUI

struct SettingsGameView: View {
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var user: User
    
    @State var soundEnabled = UserDefaults.standard.bool(forKey: "sounds_enabled")
    @State var controlType = UserDefaults.standard.integer(forKey: "control_type")
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presMode.wrappedValue.dismiss()
                } label: {
                    Image("btn_back")
                }
                
                Spacer()
                
                Text("SETTINGS")
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
            
            HStack {
                Text("Sound")
                    .font(.alkalami(size: 24))
                    .foregroundColor(.gray)
                    .shadow(color: .black, radius: 1, x: -1)
                    .shadow(color: .black, radius: 1, x: 1)
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        soundEnabled = true
                    }
                } label: {
                    if soundEnabled {
                        Image("btn_volume_on_active")
                    } else {
                        Image("btn_volume_on_inactive")
                    }
                }
                
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        soundEnabled = false
                    }
                } label: {
                    if !soundEnabled {
                        Image("btn_volume_off_active")
                    } else {
                        Image("btn_volume_off_inactive")
                    }
                }
            }
            .frame(width: 300)
            .background(
                Image("settings_item_back")
            )
            
            HStack {
                Text("Control")
                    .font(.alkalami(size: 24))
                    .foregroundColor(.gray)
                    .shadow(color: .black, radius: 1, x: -1)
                    .shadow(color: .black, radius: 1, x: 1)
                
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        controlType = 1
                    }
                } label: {
                    if controlType == 1 {
                        Image("btn_control_arrows_on")
                    } else {
                        Image("btn_control_arrows_off")
                    }
                }
                
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        controlType = 2
                    }
                } label: {
                    if controlType == 2 {
                        Image("btn_control_tap_on")
                    } else {
                        Image("btn_control_tap_off")
                    }
                }
            }
            .frame(width: 300)
            .background(
                Image("settings_item_back")
            )
            
            Spacer()
        }
        .onChange(of: soundEnabled) { newValue in
            UserDefaults.standard.set(newValue, forKey: "sounds_enabled")
        }
        .onChange(of: controlType) { newValue in
            UserDefaults.standard.set(newValue, forKey: "control_type")
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
    }
}

#Preview {
    SettingsGameView()
        .environmentObject(User())
}
