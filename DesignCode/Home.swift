//
//  Home.swift
//  DesignCode
//
//  Created by Eren  Çelik on 11.01.2021.
//

import SwiftUI

struct Home: View {
    @State var showProfile = false
    @State var viewState = CGSize.zero
    @State var showUptade = false
    @State var showContent = false
    var body: some View {
        ZStack {
            Color("background2")
                .edgesIgnoringSafeArea(.all)
            
            HomeView(showProfile: $showProfile, showContent: $showContent)
                .padding(.top,44)
                .background(
                    VStack {
                        LinearGradient(gradient: Gradient(colors: [Color("background2"), Color("background1")]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 200)
                        Spacer()
                    }
                    .background(Color("background1"))
                )
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: showProfile ? -450 : 0)
                .offset(y: viewState.height)
                .rotation3DEffect(
                    Angle.degrees(showProfile ? Double(viewState.height / 10) - 10 : 0),
                    axis: (x: 10, y: 0, z: 0.0)
                )
                .scaleEffect(showProfile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .edgesIgnoringSafeArea(.all)
            
            MenuView()
                .background(Color.black.opacity(0.1))
                .offset(y: showProfile ? 0 : screen.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.showProfile.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            self.viewState = value.translation
                        }
                        .onEnded{ value in
                            if self.viewState.height > 50 {
                                self.showProfile = false
                            }
                            self.viewState = .zero
                        }
                )
            if showContent{
                BlurView(style: .systemMaterial).edgesIgnoringSafeArea(.all)
                ContentView()
                VStack{
                    HStack{
                        Spacer()
                        Image(systemName: "xmark")
                            .frame(width: 32, height: 32)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                    .padding(.top, 16)
                    .padding(.trailing , 16)
                    Spacer()
                }
                .offset(x: -16, y: 16)
                .transition(.move(edge: .leading))
                .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
                .onTapGesture {
                    self.showContent = false
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environment(\.colorScheme, .dark)
    }
}

struct AvatarView: View {
    @Binding var showProfile : Bool
    var body: some View {
        Button(action: {
            self.showProfile.toggle()
        }, label: {
            Image("Avatar")
                .renderingMode(.original)
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
        })
    }
}

let screen = UIScreen.main.bounds
