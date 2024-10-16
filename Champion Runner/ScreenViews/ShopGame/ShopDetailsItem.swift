import SwiftUI

struct ShopDetailsItem: View {
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var user: User
    
    var skin: String
    var skinData: SkinData = SkinData()
    @State var boughtSkin = false
    @State var showAlert = false
    
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
                HStack {
                    let skinDataItem = skinData.skinData[skin]!
                    let skinPrice = skinData.skinPrices[skin]!
                    Spacer()
                    ZStack {
                        Image("skin_item_background")
                        Image(skin)
                            .blur(radius: 10)
                        Image(skin)
                    }
                    Spacer()
                    VStack {
                        Text(skinDataItem[0])
                            .lineSpacing(0)
                            .font(.alkalami(size: 24))
                            .foregroundColor(.gray)
                            .shadow(color: .black, radius: 1, x: -1)
                            .shadow(color: .black, radius: 1, x: 1)
                        
                        Text(skinDataItem[1])
                            .lineSpacing(0)
                            .font(.alkalami(size: 24))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .shadow(color: .black, radius: 1, x: -1)
                            .shadow(color: .black, radius: 1, x: 1)
                        
                        if user.selectedSkin == skin {
                            Image("selected")
                        } else {
                            if boughtSkin {
                                Button {
                                    user.selectedSkin = skin
                                } label: {
                                    Image("select")
                                }
                            } else {
                                Button {
                                    self.purchaseSkinItem()
                                } label: {
                                    ZStack {
                                        Image("balance")
                                        Text("\(skinPrice)")
                                            .font(.alkalami(size: 24))
                                            .foregroundColor(.white)
                                            .offset(y: 5)
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            boughtSkin = UserDefaults.standard.bool(forKey: "bought_\(skin)")
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Purchase Error"), message: Text("You don't have enought balance to purchase this skin."))
        }
    }
    
    private func purchaseSkinItem() {
        let skinPrice = skinData.skinPrices[skin]!
        if user.balance >= skinPrice {
            user.balance -= skinPrice
            UserDefaults.standard.set(true, forKey: "bought_\(skin)")
            boughtSkin = true
            return
        }
        showAlert = true
        boughtSkin = false
    }
    
}

#Preview {
    ShopDetailsItem(skin: "skin_1")
        .environmentObject(User())
}
