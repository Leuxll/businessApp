//
//  ForumPost.swift
//  businessApp
//
//  Created by Yue Fung Lee on 16/7/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct ForumPost: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var tag: String
    var description: String
    var authorAndTime: String
    var likes: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case tag
        case description
        case authorAndTime
        case likes
    }
}
