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
    @Published var signedIn = false
    @Published var user: User?
    @Published var card: CreditCard?
    @Published var pocketlist = [PocketMoney]()
    
    private let db = Firestore.firestore()
    private let auth = Auth.auth()
    
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
    
    init() {
        sync()
        fetchPocketMoneyData()
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<Bool, EmailAuthError>) -> ()) {
        
        auth.signIn(withEmail: email, password: password) { (result, error) in
            var newError: NSError
            if let err = error {
                newError = err as NSError
                var authError: EmailAuthError?
                switch newError.code {
                case 17009:
                    authError = .incorrectPassword
                case 17008:
                    authError = .invalidEmail
                case 17011:
                    authError = .accountDoesNotExist
                default:
                    authError = .uknownError
                }
                completion(.failure(authError!))
            } else {
                completion(.success(true))
            }
            
            DispatchQueue.main.async {
                self.sync()
            }
        } 
    }
    
    func signUp(email: String,
                firstName: String,
                lastName: String,
                password: String,
                phoneNumber: String,
                city: String,
                school: String,
                age: String,
                completion: @escaping (Result<Bool, Error>) -> Void) {
        
        auth.createUser(withEmail: email,
                        password: password) { (result, error) in
            if let err = error {
                completion(.failure(err))
                return
            }
            guard let _ = result?.user else {
                completion(.failure(error!))
                return
            }
            
            DispatchQueue.main.async {
                self.addUser(User(firstName: firstName, lastName: lastName, email: email, city: city, school: school, age: age, phoneNumber: phoneNumber))
                self.addCardInfo(CreditCard(number: "4141444411112222", company: "Visa", expirationDate: "10/24", cvv: "999", balance: 500.00))
                self.sync()
            }
            completion(.success(true))
        }
    }
    
    func resetPassword(email: String,
                       completion: @escaping (Result<Bool, Error>) -> Void) {
        auth.sendPasswordReset(withEmail: email, completion: { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        })
    }
    
    func signOut(completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try auth.signOut()
            self.user = nil
            completion(.success(true))
        } catch let err {
            completion(.failure(err))
        }
    }
    
    // Pocket Money
    
    func fetchPocketMoneyData() {
        db.collection("pocketmoneylist").getDocuments { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No document")
                return
            }
            self.pocketlist = documents.map({ QueryDocumentSnapshot -> PocketMoney in
                let id = QueryDocumentSnapshot.documentID
                let data = QueryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let amount = data["amount"] as? String ?? ""
                return PocketMoney(id: id, name: name, amount: amount)
            })
        }
    }
    
    func addPocketMoney(name: String, amount: String) {
        db.collection("pocketmoneylist").addDocument(data: ["name": name, "amount": amount]) { error in
            if error == nil {
                self.fetchPocketMoneyData()
            } else {
                
            }
        }
    }
    
    func updatePocketMoney(updatePocket: PocketMoney, updatedName: String, updatedAmount: String) {
        db.collection("pocketmoneylist").document(updatePocket.id).setData(["name": updatedName, "amount": updatedAmount]) { error in
            if error == nil {
                self.fetchPocketMoneyData()
            }
        }
    }
    
    func updateUser(firstName: String, lastName: String) {
        db.collection("users").document(self.uuid!).setData(["firstName": firstName, "lastName": lastName], merge: true) { error in
            if error == nil {
                self.sync()
            } else {
                print("error")
            }
        }
        
    }
    
    func deletePocketMoney(deletePocket: PocketMoney) {
        db.collection("pocketmoneylist").document(deletePocket.id).delete { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.pocketlist.removeAll { pocket in
                        return pocket.id == deletePocket.id
                    }
                }
            }
        }
    }
    
    // Firestore funcs
    
    func sync() {
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
        
        db.collection("creditcards").document(self.uuid!).getDocument { (document, error) in
            guard document != nil, error == nil else {
                return
            }
            do {
                try self.card = document!.data(as: CreditCard.self)
            } catch {
                print("Sync error: \(error)")
            }
        }
    }
    
    private func addUser(_ user: User) {
        guard userIsAuthenticated else {
            return
        }
        do {
            let _ = try db.collection("users").document(self.uuid!).setData(from: user)
        } catch {
            print("Error adding: \(error)")
        }
    }
    
    private func addCardInfo(_ card: CreditCard) {
        guard userIsAuthenticated else {
            return
        }
        do {
            let _ = try db.collection("creditcards").document(self.uuid!).setData(from: card)
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
