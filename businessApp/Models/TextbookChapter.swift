//
//  TextbookChapter.swift
//  businessApp
//
//  Created by Yue Fung Lee on 27/6/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct TextbookChapter: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var imageUrl: String
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl
        case description
    }
}
