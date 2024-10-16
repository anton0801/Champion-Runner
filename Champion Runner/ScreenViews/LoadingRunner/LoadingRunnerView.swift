import SwiftUI

struct LoadingRunnerView: View {
    
    @StateObject var loadingRunervm = LoadingRunnerViewModel()
    @State var loaded = false
    @State private var isRotating = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()
                Image("load_icon")
                    .rotationEffect(.degrees(isRotating ? 360 : 0))
                    .animation(
                        Animation.linear(duration: 6.0)
                            .repeatForever(autoreverses: false), value: isRotating
                    )
                    .onAppear {
                        isRotating = true
                    }
                Text("loading...")
                    .font(.alkalami(size: 32))
                    .foregroundColor(.primaryTextColor)
                    .shadow(color: .white, radius: 2, x: -1)
                    .shadow(color: .white, radius: 2, x: 1)
                
                if loadingRunervm.loaded {
                    Text("")
                        .onAppear { loaded = true }
                    if loadingRunervm.meta != nil {
                        NavigationLink(destination: ContentView()
                            .navigationBarBackButtonHidden(), isActive: $loaded) { }
                    } else {
                        NavigationLink(destination: ContentViewRunner()
                            .navigationBarBackButtonHidden(), isActive: $loaded) { }
                    }
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("fcm_received")), perform: { _ in
                loadingRunervm.pushReceived = true
                loadingRunervm.caLoadSkins()
            })
            .background(
                Image("main_background")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height + 20)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    LoadingRunnerView()
}
