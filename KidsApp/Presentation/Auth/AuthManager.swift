//
//  AuthManager.swift
//  KidsApp
//
//  Created by Oleh Haidar on 27.09.2021.
//

import Foundation
import FirebaseAuth
//import FirebaseFirestore
//import FirebaseFirestoreSwift

class AuthManager: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var isLoading = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        self.isLoading = true
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
        self.isLoading = false
    }
    
    func signUp(email: String, password: String) {
        self.isLoading = true
        auth.createUser(withEmail: email,
                        password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
        
        self.isLoading = false
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
}

//class UserViewModel: ObservableObject {
//
//    @Published var user: User?
//
//    private let auth = Auth.auth()
//    private let db = Firestore.firestore()
//    var uuid: String? {
//        auth.currentUser?.uid
//    }
//    var userIsAuthenticated: Bool {
//        auth.currentUser != nil
//    }
//    var userIsAuthenticatedAndSynced: Bool {
//        user != nil && self.userIsAuthenticated
//    }
//
//    private func sync() {
//        guard userIsAuthenticated else {
//            return
//        }
//        db.collection("users").document(self.uuid!).getDocument { (document, error) in
//            guard document != nil, error == nil else {
//                return
//            }
//            do {
//                try self.user = document!.data(as: User.self)
//            } catch {
//                print("Sync error: \(error)")
//            }
//
//        }
//
//    }
//
//    private func add(_ user: User) {
//        guard userIsAuthenticated else {
//            return
//        }
//        do {
//            let _ = try db.collection("users").document(self.uuid!).setData(from: user)
//        } catch {
//            print("Error adding: \(error)")
//        }
//    }
//
//    private func update() {
//        guard userIsAuthenticatedAndSynced else {
//            return
//        }
//        do {
//            let _ = try db.collection("users").document(self.uuid!).setData(from: self.user)
//        } catch {
//            print("Error updating: \(error)")
//        }
//
//
//    }
//}

