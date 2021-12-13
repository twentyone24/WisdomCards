//
//  User Repository.swift
//  WisdomCards
//
//  Created by NAVEEN MADHAN on 12/13/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

/*
final class UsersRepository: ObservableObject {
    private let path = "users"
    private let store = Firestore.firestore()
    @Published var studyCard:
    
    init() {
        get()
    }
    
    func get() {
        store.collection(path).addSnapshotListener {
            (snapshot, error) in
            if let error = error {
                print(error)
                return
            }
            self.studyCard = snapshot?.documents.compactMap {
                try? $0.data(as: StudyCard.self)
            } ?? []
        }
    }
    
    func add(_ studyCard: StudyCard) {
        do {
            _ = try store.collection(path).addDocument(from: studyCard)
        } catch {
            fatalError("Error al añadir una studyCard")
        }
    }
    
    func remove(_ studyCard: StudyCard) {
        guard let docId = studyCard.id else {
            return
        }
        store.collection(path).document(docId).delete() { error in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    
    func update(_ studyCard: StudyCard) {
        guard let docId = studyCard.id else {
            return
        }
        do {
            try store.collection(path).document(docId).setData(from: studyCard)
        } catch {
            fatalError("Error al actualizar una studyCard")
        }
    }
}
*/
