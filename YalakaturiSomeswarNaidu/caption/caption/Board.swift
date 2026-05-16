//
//  Board.swift
//  caption
//

import Foundation
import FirebaseFirestore

struct Board {

    var id: String

    let title: String

    let description: String

    let privacy: String

    let ownerId: String

    let ownerEmail: String

    let members: [String]
   

    init(data: [String: Any]) {

        self.id =
        data["id"] as? String ?? ""

        self.title =
        data["title"] as? String ?? ""

        self.description =
        data["description"] as? String ?? ""

        self.privacy =
        data["privacy"] as? String ?? ""

        self.ownerId =
        data["ownerId"] as? String ?? ""

        self.ownerEmail =
        data["ownerEmail"] as? String ?? ""

        self.members =
        data["members"] as? [String] ?? []
        
       
    }

    func toDictionary() -> [String: Any] {

        return [

            "id": id,

            "title": title,

            "description": description,

            "privacy": privacy,

            "ownerId": ownerId,

            "ownerEmail": ownerEmail,

            "members": members
        ]
    }
}
