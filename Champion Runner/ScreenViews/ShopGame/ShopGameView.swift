import SwiftUI

struct ShopGameView: View {
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var user: User
    
    var allSkins = [
        "skin_1",
        "skin_2",
        "skin_3",
        "skin_4"
    ]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        presMode.wrappedValue.dismiss()
                    } label: {
                        Image("btn_back")
                    }
                    
                    Spacer()
                    
                    Text("SHOP")
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
                    GridItem(.fixed(140)),
                    GridItem(.fixed(140))
                ]) {
                    ForEach(allSkins, id: \.self) { skin in
                        NavigationLink(destination: ShopDetailsItem(skin: skin)
                            .navigationBarBackButtonHidden()
                            .environmentObject(user)) {
                            ZStack {
                                Image("skin_item_background")
                                Image(skin)
                                    .blur(radius: 10)
                                Image(skin)
                            }
                        }
                    }
                }
                .padding(.top, 52)
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
}

#Preview {
    ShopGameView()
        .environmentObject(User())
}
