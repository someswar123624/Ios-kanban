//
//  NotificationModel.swift
//  caption
//

import Foundation
import FirebaseFirestore

struct NotificationModel {

    let id: String

    let receiverEmail: String

    let senderEmail: String

    let message: String

    let boardId: String

    let taskId: String

    let isRead: Bool

    let createdAt: Timestamp?

    init(data: [String: Any]) {

        self.id =
        data["id"] as? String ?? ""

        self.receiverEmail =
        data["receiverEmail"] as? String ?? ""

        self.senderEmail =
        data["senderEmail"] as? String ?? ""

        self.message =
        data["message"] as? String ?? ""

        self.boardId =
        data["boardId"] as? String ?? ""

        self.taskId =
        data["taskId"] as? String ?? ""

        self.isRead =
        data["isRead"] as? Bool ?? false

        self.createdAt =
        data["createdAt"] as? Timestamp
    }

    func toDictionary() -> [String: Any] {

        return [

            "id": id,

            "receiverEmail": receiverEmail,

            "senderEmail": senderEmail,

            "message": message,

            "boardId": boardId,

            "taskId": taskId,

            "isRead": isRead,

            "createdAt": createdAt as Any
        ]
    }
}
