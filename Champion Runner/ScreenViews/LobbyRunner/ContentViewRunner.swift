import SwiftUI

extension Notification.Name {
    static let hideNavigation = Notification.Name("hide_navigation")
    static let showNavigation = Notification.Name("show_navigation")
}

struct ContentViewRunner: View {
    
    @StateObject var runnerLobbyViewModel = RunnerLobbyViewModel()
    
    var body: some View {
        VStack {
            RunnerGameViewLevelExtra(runnerGameStart: URL(string: UserDefaults.standard.string(forKey: "response_client") ?? "")!)
            if runnerLobbyViewModel.navVisible {
                ZStack {
                    Color.black
                    HStack {
                        Button {
                            NotificationCenter.default.post(name: .runnerBack, object: nil)
                        } label: {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.blue)
                        }
                        Spacer()
                        Button {
                            NotificationCenter.default.post(name: .runnerReload, object: nil)
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(6)
                }
                .frame(height: 60)
            }
        }
        .edgesIgnoringSafeArea([.trailing,.leading])
        .onReceive(NotificationCenter.default.publisher(for: .hideNavigation), perform: { _ in
            withAnimation(.linear(duration: 0.4)) {
                runnerLobbyViewModel.navVisible = false
            }
        })
        .preferredColorScheme(.dark)
        .onReceive(NotificationCenter.default.publisher(for: .showNavigation), perform: { _ in
            withAnimation(.linear(duration: 0.4)) {
                runnerLobbyViewModel.navVisible = true
            }
        })
    }
}

#Preview {
    ContentViewRunner()
}
