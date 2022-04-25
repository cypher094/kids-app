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

extension String {
    func applyCardPattern(pattern: String = "#### #### #### ####", replacmentCharacter: Character = "#") -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: self)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
}

enum EmailAuthError: Error {
    case incorrectPassword
    case invalidEmail
    case accountDoesNotExist
    case uknownError
    case couldNotCreatte
    case extraDataNotCreated
}

extension EmailAuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .incorrectPassword:
            return NSLocalizedString("Incorrect password for this account.", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Not a valid email address.", comment: "")
        case .accountDoesNotExist:
            return NSLocalizedString("This account does not exist.", comment: "")
        case .uknownError:
            return NSLocalizedString("Unknown error Cannot log in.", comment: "")
        case .couldNotCreatte:
            return NSLocalizedString("Could not create user at this time.", comment: "")
        case .extraDataNotCreated:
            return NSLocalizedString("Could not create user's full name.", comment: "")
        }
    }
}
