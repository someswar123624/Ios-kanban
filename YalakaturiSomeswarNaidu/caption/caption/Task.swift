//
//  Task.swift
//  caption
//

import Foundation
import FirebaseFirestore

struct Task {

    let id: String

    let title: String

    let description: String

    let assignedTo: String

    let status: String

    let createdBy: String

    let dueDate: Timestamp?

    let createdAt: Timestamp?

    init(data: [String: Any]) {

        self.id =
        data["id"] as? String ?? ""

        self.title =
        data["title"] as? String ?? ""

        self.description =
        data["description"] as? String ?? ""

        self.assignedTo =
        data["assignedTo"] as? String ?? ""

        self.status =
        data["status"] as? String ?? "Todo"

        self.createdBy =
        data["createdBy"] as? String ?? ""

        self.dueDate =
        data["dueDate"] as? Timestamp

        self.createdAt =
        data["createdAt"] as? Timestamp
    }

    func toDictionary() -> [String: Any] {

        return [

            "id": id,

            "title": title,

            "description": description,

            "assignedTo": assignedTo,

            "status": status,

            "createdBy": createdBy,

            "dueDate": dueDate as Any,

            "createdAt": createdAt as Any
        ]
    }
}
