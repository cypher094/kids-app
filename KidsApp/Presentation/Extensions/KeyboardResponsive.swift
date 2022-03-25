//
//  Hidekeyboard+KeyboardResponsive.swift
//  KidsApp
//
//  Created by Oleh Haidar on 28.09.2021.
//

import SwiftUI

struct KeyboardResponsive: ViewModifier {
    @State private var offset: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .padding(.bottom, self.offset)
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
                    if let info = notif.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        let height = info.height
                        let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
                        self.offset = height - (bottomInset ?? 0)
                    }
                }

                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notif in
                    self.offset = 0
                }
            }
    }
}

extension View {
    func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsive> {
        return modifier(KeyboardResponsive())
    }

    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
