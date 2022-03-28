//
//  AuthManager.swift
//  KidsApp
//
//  Created by Oleh Haidar on 27.09.2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AuthManager: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var isLoading = false
    
    @Published var user: User?
    
    private let db = Firestore.firestore()
    var uuid: String? {
        auth.currentUser?.uid
    }
    var userIsAuthenticated: Bool {
        auth.currentUser != nil
    }
    var userIsAuthenticatedAndSynced: Bool {
        user != nil && userIsAuthenticated
    }
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        self.isLoading = true
        auth.signIn(withEmail: email,
                    password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.sync()
            }
        }
        self.isLoading = false
    }
    
    func signUp(email: String, firstName: String, lastName: String, password: String) {
        self.isLoading = true
        auth.createUser(withEmail: email,
                        password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            
            DispatchQueue.main.async {
                self?.add(User(firstName: firstName, lastName: lastName))
                self?.sync()
            }
        }
        self.isLoading = false
    }
    
    func signOut() {
        do{
            try auth.signOut()
            self.user = nil
        } catch {
            print("Error signing out user \(error)")
        }
    }
    
    //Firestore funcs
    
    private func sync() {
        guard userIsAuthenticated else {
            return
        }
        db.collection("users").document(self.uuid!).getDocument { (document, error) in
            guard document != nil, error == nil else {
                return
            }
            do {
                try self.user = document!.data(as: User.self)
            } catch {
                print("Sync error: \(error)")
            }
        }
    }
    
    private func add(_ user: User) {
        guard userIsAuthenticated else {
            return
        }
        do {
            let _ = try db.collection("users").document(self.uuid!).setData(from: user)
        } catch {
            print("Error adding: \(error)")
        }
    }
    
    private func update() {
        guard userIsAuthenticatedAndSynced else {
            return
        }
        do {
            let _ = try db.collection("users").document(self.uuid!).setData(from: self.user)
        } catch {
            print("Error updating: \(error)")
        }
    }
    
}
