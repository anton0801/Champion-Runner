import SwiftUI

struct MapsView: View {
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var user: User
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Button {
                            presMode.wrappedValue.dismiss()
                        } label: {
                            Image("btn_back")
                        }
                        
                        Spacer()
                        
                        Text("PLAY")
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
                }
                
                VStack {
                    LazyVGrid(columns: [
                        GridItem(.fixed(150), spacing: 42),
                        GridItem(.fixed(150), spacing: 42),
                        GridItem(.fixed(150), spacing: 42)
                    ], spacing: 0) {
                        Text("Choose a game stage")
                            .lineSpacing(0)
                            .font(.alkalami(size: 24))
                            .foregroundColor(.gray)
                            .shadow(color: .black, radius: 1, x: -1)
                            .shadow(color: .black, radius: 1, x: 1)
                        
                        ForEach(user.allStages, id: \.self) { stage in
                            if user.isStageUnlocked(stage) {
                                NavigationLink(destination: RunerGameView(stage: stage.replacingOccurrences(of: " ", with: "_"))
                                    .navigationBarBackButtonHidden()
                                    .environmentObject(user)) {
                                        ZStack {
                                            Image(stage.replacingOccurrences(of: " ", with: "_"))
                                            
                                            Text(stage)
                                                .font(.alkalami(size: 15))
                                                .foregroundColor(.white)
                                                .background(
                                                    Image("stage_back")
                                                )
                                                .offset(y: 50)
                                        }
                                    }
                            } else {
                                ZStack {
                                    Image(stage.replacingOccurrences(of: " ", with: "_"))
                                    
                                    Text("Locked")
                                        .font(.alkalami(size: 15))
                                        .foregroundColor(.white)
                                        .background(
                                            Image("stage_back")
                                        )
                                        .offset(y: 50)
                                }
                            }
                        }
                    }
                    .padding(.top, 62)
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    MapsView()
        .environmentObject(User())
}
