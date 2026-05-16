//
//  notificationViewController.swift
//  caption
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class notificationViewController:
UIViewController {

   

    var notifications:
    [NotificationModel] = []
    var selectedBoard : Board?

    let db = Firestore.firestore()

    

    let tableView = UITableView()

    let titleLabel = UILabel()

  

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        setupTable()

        listenNotifications()
    }
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {

        if segue.identifier ==
            "GoToBoardDetailFromNotification" {

            let vc =
            segue.destination
            as! BoardDetailViewController

            vc.board = selectedBoard
        }
    }
}



extension notificationViewController {

    func setupUI() {

        view.backgroundColor =
        UIColor(
            red: 10/255,
            green: 12/255,
            blue: 28/255,
            alpha: 1
        )

        titleLabel.translatesAutoresizingMaskIntoConstraints =
        false

        titleLabel.text = "Notifications"

        titleLabel.font =
        .systemFont(
            ofSize: 32,
            weight: .bold
        )

        titleLabel.textColor = .white

        view.addSubview(titleLabel)

        tableView.translatesAutoresizingMaskIntoConstraints =
        false

        tableView.backgroundColor = .clear

        tableView.separatorStyle = .none

        view.addSubview(tableView)

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(
                equalTo:
                view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),

            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            tableView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 20
            ),

            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }

    func setupTable() {

        tableView.delegate = self

        tableView.dataSource = self

        tableView.register(
            NotificationCell.self,
            forCellReuseIdentifier: "notificationCell"
        )
    }
}


extension notificationViewController {

    func listenNotifications() {

        guard let email =
                Auth.auth()
                .currentUser?
                .email
        else {
            return
        }

        db.collection("notifications")

            .whereField(
                "receiverEmail",
                isEqualTo: email
            )

            .order(
                by: "createdAt",
                descending: true
            )

            .addSnapshotListener {

                snapshot,
                error in

                if let error = error {

                    print(error.localizedDescription)
                    return
                }

                guard let docs =
                        snapshot?.documents
                else {
                    return
                }

                self.notifications = docs.map {

                    NotificationModel(
                        data: $0.data()
                    )
                }

                DispatchQueue.main.async {

                    self.tableView.reloadData()
                }
            }
    }
}


extension notificationViewController {

    func setupTabBar() {

        guard let tabBar = tabBarController?.tabBar else {
            return
        }

        tabBar.backgroundColor =
        UIColor(
            red: 10/255,
            green: 10/255,
            blue: 25/255,
            alpha: 1
        )

        tabBar.layer.cornerRadius = 34

        tabBar.layer.cornerCurve = .continuous

        tabBar.layer.masksToBounds = true

        tabBar.tintColor = .systemPink

        tabBar.unselectedItemTintColor =
        UIColor.white.withAlphaComponent(0.45)

        tabBar.layer.borderWidth = 1

        tabBar.layer.borderColor =
        UIColor.white.withAlphaComponent(0.05).cgColor
    }
}



extension notificationViewController:
UITableViewDelegate,
UITableViewDataSource {

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return notifications.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell =
        tableView.dequeueReusableCell(
            withIdentifier: "notificationCell",
            for: indexPath
        ) as! NotificationCell

        let notification =
        notifications[indexPath.row]

        cell.configure(
            notification: notification
        )

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {

        return 110
    }
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt
        indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {

        let notification =
        notifications[indexPath.row]

        let delete =
        UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) {

            _,
            _,
            completion in

            self.db.collection("notifications")
                .document(notification.id)
                .delete {

                    error in

                    if let error = error {

                        print(error.localizedDescription)
                    }
                }

            completion(true)
        }

        delete.backgroundColor =
        UIColor.systemRed

        return UISwipeActionsConfiguration(
            actions: [delete]
        )
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let notification =
        notifications[indexPath.row]

        db.collection("notifications")
            .document(notification.id)
            .updateData([

                "isRead": true
            ])

        db.collection("boards")
            .document(notification.boardId)
            .getDocument {

                snapshot,
                error in

                if let data =
                    snapshot?.data() {

                    self.selectedBoard =
                    Board(data: data)

                    self.performSegue(
                        withIdentifier:
                        "GoToBoardDetailFromNotification",
                        sender: self
                    )
                }
            }
    }
}
 
