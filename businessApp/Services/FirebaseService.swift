//
//  NetworkManager.swift
//  businessApp
//
//  Created by Yue Fung Lee on 24/6/2021.
//

import Foundation
import FirebaseAuth
import Firebase
import Combine

class FirebaseService {
    let imageCache = NSCache<NSString, NSData>()
    
    static func getFullname(_ v: UILabel) {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("users").document(uid!).getDocument { (document, error) in
            guard let data = document?.data(), error == nil else {
                return
            }
            guard let fullname = data["fullname"] as? String else {
                return
            }
            DispatchQueue.main.async {
                v.text = fullname + " " + "👋"
            }
        }
    }
    
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage as Data)
        } else {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard error == nil, let data = data else {
                    completion(nil)
                    return
                }
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }.resume()
        }
    }
    
}
