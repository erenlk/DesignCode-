//
//  ContentView.swift
//  DesignCode
//
//  Created by Eren  Çelik on 10.01.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y: showCard ? -200 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
//                        .speed(2)
//                        .repeatForever()
                        
                )
            
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card3") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0.0, y: show ? -400 :  -40.0)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(Angle(degrees: showCard ? -10 : 0))
                .rotation3DEffect(
                    .degrees(showCard ? 0 : 10),
                    axis: (x: 10.0, y: 0.0, z: 0.0)
                )
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))
            BackCardView()
                .frame(width: 340, height: 220)
                .background(show ? Color("card4") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0.0, y: show ? -200 : -20.0)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(Angle(degrees: show ? 0 : 5))
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                .rotation3DEffect(
                    .degrees(showCard ? 0 : 5),
                    axis: (x: 10.0, y: 0.0, z: 0.0)
                )
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.3))
            
            CardView()
                .frame(width: showCard ? 375 : 340.0,height: 220.0)
                .background(Color.black)
//                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20,style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 1))
                .onTapGesture {
                    //self.show.toggle()
                    self.showCard.toggle()
                }
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.viewState = value.translation
                            self.show = true
                        }
                        .onEnded { value in
                            self.viewState = .zero
                            self.show = false
                        }
                )
            BottomCardView(showRingAnimations: $showCard)
                .offset(x: 0, y: showCard ? 500 : 1000)
                .offset(x: 0, y: bottomState.height)
                .blur(radius: show ? 20 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 0.8))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            self.bottomState = value.translation
                            if self.showFull {
                                self.bottomState.height += -300
                            }
                            if self.bottomState.height < -300 {
                                self.bottomState.height = -300
                            }
                        }
                        .onEnded { value in
                            if self.bottomState.height > 50 {
                                self.showCard = false
                            }
                            if (self.bottomState.height < -100 && !self.showFull) || (self.bottomState.height < -250 && self.showFull){
                                self.bottomState.height = -300
                                self.showFull = true
                            }else {
                                self.bottomState = .zero
                                self.showFull = false
                            }
                        }
                )
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("Certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
                
            }
            .padding(20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110,alignment: .top)
        }

    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    @Binding var showRingAnimations: Bool
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 40, height: 6)
                .cornerRadius(3)
                .opacity(0.1)
            Text("This certificates is proof that Eren Çelik to has achived the  UI Design course with approval from a DesignCode instrucator")
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .lineSpacing(4)
            
            HStack(spacing: 20) {
                RingView(color1: #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), width: 88, height: 88, percent: 60, show: $showRingAnimations)
                    .animation(Animation.easeInOut.delay(0.3))

                  VStack(alignment: .leading, spacing: 8) {
                        Text("SwiftUI Prototype")
                            .fontWeight(.bold)
                        Text("12 of 12 sections completed \n10 hours spent so far")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .lineSpacing(4)
                    }
                    .padding(20)
                    .background(Color("bacground3"))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
            }
            Spacer()
        }
        .padding(.top , 8)
        .padding(.horizontal , 20)
        .frame(maxWidth: .infinity)
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(30)
        .shadow(radius: 20)
        
    }
}
