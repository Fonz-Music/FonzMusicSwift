//
//  HomePage.swift
//  Fonz Music App Clip
//
//  Created by didi on 1/31/21.
//

import SwiftUI

struct HomePage: View {
    
    // gets object to determine if the page should be updated
//    @Binding var determineMainPageViewUpdate: UpdatePageViewVariables
//
//    @ObservedObject var updatePageBool: UpdateMainPageView
    // the currentPAge
    @Binding var currentPageIndex: Int
    
    let sideGraphicHeight = UIScreen.screenHeight * 0.06
    let arrowGraphicHeight = UIScreen.screenHeight * 0.03
    let mainLogoHeight = UIScreen.screenHeight * 0.12
    var body: some View {
        ZStack {
            Color(.systemGray5).ignoresSafeArea()
        HStack{
            Capsule()
                .fill(Color(red: 235 / 255, green: 139 / 255, blue: 55 / 255))
                .background(RoundedCorners(tl: 0, tr: 1500, bl: 0, br: 1500).fill(Color(red: 235 / 255, green: 139 / 255, blue: 55 / 255)))
            Rectangle().fill(Color.clear)
            Capsule().fill(Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255))
                .background(RoundedCorners(tl: 1500, tr: 0, bl: 1500, br: 0).fill(Color(red: 168 / 255, green: 127 / 255, blue: 169 / 255)))
        }.ignoresSafeArea()
            HStack{
                Button(action: {
                    print("press left")
                    print("current page \(currentPageIndex)")
                    self.currentPageIndex = 0
                    
//                    self.updatePageBool.updatePage = true
//                    self.determineMainPageViewUpdate.currentPage = 0
//                    self.determineMainPageViewUpdate.updatePage = true
                }, label: {
                    VStack(){
                        Spacer()
                        Image("coasterIconWhite").resizable().frame(width: sideGraphicHeight * 1.2, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("host").fonzParagraphOne()
                        Image("Arrow Left White").resizable().frame(width: arrowGraphicHeight * 1.2, height: arrowGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                })
                
                
                Spacer()
                Button(action: {
                    self.currentPageIndex = 2
//                    self.updatePageBool.updatePage = true
//                    self.determineMainPageViewUpdate.currentPage = 2
//                    self.determineMainPageViewUpdate.updatePage = true
                }, label: {
                    VStack{
                        Spacer()
                        Image("queueIconWhite").resizable().frame(width: sideGraphicHeight, height: sideGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text("guest").fonzParagraphOne()
                        Image("Arrow Right White").resizable().frame(width: arrowGraphicHeight * 1.2, height: arrowGraphicHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                })
              
                
//                .padding(.leading, 10.0)
            }.padding()
            VStack{
                Spacer()
                Image("Logo Gradiant").resizable().frame(width: mainLogoHeight * 0.5, height: mainLogoHeight, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Spacer()
            }
        }
//        .onAppear {
//            currentPageIndex = 1
//            print("current page is \(currentPageIndex)")
//        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
//        HomePage()
        Text("annoying")
    }
}
struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        // Make sure we do not exceed the size of the rectangle
        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)

        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr,
                    startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)

        path.addLine(to: CGPoint(x: w, y: h - br))
        path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addLine(to: CGPoint(x: bl, y: h))
        path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addLine(to: CGPoint(x: 0, y: tl))
        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl,
                    startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        return path
    }
}
