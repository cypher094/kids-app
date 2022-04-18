//
//  LottieView.swift
//  KidsApp
//
//  Created by Oleh Haidar on 27.09.2021.
//

import SwiftUI
import Lottie

struct             LottieViewLoading: UIViewRepresentable {
    let animationView = AnimationView()
    let fileName: String
    let isAnimating: Bool
    let loopMode: LottieLoopMode
    
    init(fileName: String, isAnimating: Bool = true, loopMode: LottieLoopMode = .loop) {
        self.fileName = fileName
        self.isAnimating = isAnimating
        self.loopMode = loopMode
    }
    
    func makeUIView(context: UIViewRepresentableContext<            LottieViewLoading>) -> UIView {
        let view = UIView()
        
        let animation = Animation.named(fileName)
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.backgroundBehavior = .pauseAndRestore
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
                                     animationView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<            LottieViewLoading>) {
        if isAnimating {
            context.coordinator.kid.animationView.play()
        } else {
            context.coordinator.kid.animationView.pause()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var kid:             LottieViewLoading

        init(_ kid:             LottieViewLoading) {
            self.kid = kid
        }
    }
}
