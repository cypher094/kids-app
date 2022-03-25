//
//  Loading.swift
//  KidsApp
//
//  Created by Oleh Haidar on 28.09.2021.
//

import SwiftUI

extension View {
    func loading(isShowing: Binding<Bool>,
                 hideContent: Bool = false,
                 section: Bool = false) -> some View {
        return modifier(SQLoading(isShowing: isShowing,
                                  hideContent: hideContent,
                                  section: section))
    }
}

struct SQLoading: ViewModifier {
    
    private static let transition = AnyTransition.opacity.animation(.easeInOut(duration: 0.3))
    
    @Binding var isShowing: Bool
    
    private let hideContent: Bool
    private let section: Bool
    
    init(isShowing: Binding<Bool>, hideContent: Bool = false, section: Bool = false) {
        self._isShowing = isShowing
        self.hideContent = hideContent || section
        self.section = section
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            if hideContent {
                if isShowing {
                    loader
                } else {
                    content
                        .transition(Self.transition)
                }
            } else {
                content
                    .disabled(isShowing)
                if isShowing { loader }
            }
        }
    }
    
    private var loader: some View {
        Group {
            if section {
                sectionLoader
            } else {
                fullScreenLoader
            }
        }
    }
    
    private var fullScreenLoader: some View {
        LottieView(fileName: "loadingDots", isAnimating: isShowing)
            .frame(width: 200, height: 200)
    }
    
    private var sectionLoader: some View {
        LottieView(fileName: "loadingDots")
            .frame(width: 35, height: 10)
    }
}
