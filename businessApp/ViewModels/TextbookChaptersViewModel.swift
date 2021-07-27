//
//  UsersViewModel.swift
//  businessApp
//
//  Created by Yue Fung Lee on 24/6/2021.
//

import Foundation
import Firebase
import Combine
import FirebaseFirestoreSwift

class TextbookChapterViewModel: ObservableObject {
    
    @Published var chapters = [TextbookChapter]()
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("posts").addSnapshotListener { (query, error) in
            guard let documents = query?.documents else {
                print("No documents")
                return
            }
            self.chapters = documents.compactMap({ (queryDocumentSnapshot) -> TextbookChapter? in
                return try? queryDocumentSnapshot.data(as: TextbookChapter.self)
            })
        }
    }
    
}
