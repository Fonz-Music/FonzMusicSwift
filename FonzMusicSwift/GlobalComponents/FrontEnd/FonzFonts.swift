//
//  FonzFonts.swift
//  FonzMusicSwift
//
//  Created by didi on 7/1/21.
//

import Foundation
import SwiftUI

// text boxes

struct FonzTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-700", size: 56))
            .foregroundColor(Color(.systemGray5))
            .multilineTextAlignment(.center)
            .padding(.horizontal)

    }
}
struct FonzHeading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-700", size: 40))
            .foregroundColor(Color(.systemGray5))
            .multilineTextAlignment(.center)
//            .padding(.horizontal, 10)

    }
}
struct FonzSubheading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-500", size: 24))
            .foregroundColor(Color(.systemGray5))
            .multilineTextAlignment(.center)
//            .padding(.horizontal)
    }
}
struct FonzParagraphOne: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-300", size: 24))
            .foregroundColor(Color(.systemGray5))
            .multilineTextAlignment(.center)
//            .padding(.horizontal)
    }
}
struct FonzParagraphTwo: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-300", size: 18))
            .foregroundColor(Color(.systemGray5))
//            .padding(.horizontal)
    }
}
struct FonzButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-300", size: 16))
            .foregroundColor(Color(.systemGray5))
//            .padding(.horizontal)
    }
}
struct FonzRoundButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-300", size: 20))
            .foregroundColor(Color(.systemGray5))
            .multilineTextAlignment(.center)
//            .padding(.horizontal)
    }
}
struct FonzParagraphThree: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-100", size: 12))
    }
}
struct FonzAmberButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-100", size: 12))
            .foregroundColor(Color.amber)
            
    }
}
//struct FonzInsideTextView: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(Font.custom("MuseoSans-100", size: 16))
//            .padding(50)
//
//    }
//}

// extension so fonts can be used as modifiers
extension View {
    func fonzHeading() -> some View {
        self.modifier(FonzHeading())
    }
    func fonzSubheading() -> some View {
        self.modifier(FonzSubheading())
    }
    func fonzParagraphOne() -> some View {
        self.modifier(FonzParagraphOne())
    }
    func fonzParagraphTwo() -> some View {
        self.modifier(FonzParagraphTwo())
    }
    func fonzButtonText() -> some View {
        self.modifier(FonzButtonText())
    }
    func fonzRoundButtonText() -> some View {
        self.modifier(FonzRoundButtonText())
    }
    func fonzParagraphThree() -> some View {
        self.modifier(FonzParagraphThree())
    }
    func fonzAmberButtonText() -> some View {
        self.modifier(FonzAmberButtonText())
    }
//    func fonzInsideTextView() -> some View {
//        self.modifier(FonzInsideTextView())
//    }
    
}
