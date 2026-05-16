//
//  BoardDetailViewController.swift
//  caption
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class BoardDetailViewController:
UIViewController {


    var board: Board!
    

    var tasks: [Task] = []

    let db = Firestore.firestore()
    var currentUserEmail: String {

        return Auth.auth()
            .currentUser?
            .email ?? ""
    }

    var isOwner: Bool {

        return board.ownerEmail ==
        currentUserEmail
    }

    let scrollView = UIScrollView()

    let contentView = UIView()

    let titleLabel = UILabel()

    let descLabel = UILabel()

    let privacyBadge = UILabel()

    let membersLabel = UILabel()

    let todoLabel =
    createSectionLabel(title: "TODO")

    let doingLabel =
    createSectionLabel(title: "DOING")

    let doneLabel =
    createSectionLabel(title: "DONE")

    let tableView = UITableView(
        frame: .zero,
        style: .grouped
    )

    let addTaskButton: UIButton = {

        let btn = UIButton(type: .system)

        btn.translatesAutoresizingMaskIntoConstraints =
        false

        btn.backgroundColor =
        UIColor.systemPink

        btn.setImage(
            UIImage(systemName: "plus"),
            for: .normal
        )

        btn.tintColor = .white

        btn.layer.cornerRadius = 32

        btn.layer.shadowColor =
        UIColor.systemPink.cgColor

        btn.layer.shadowOpacity = 0.5

        btn.layer.shadowRadius = 14

        btn.layer.shadowOffset =
        CGSize(width: 0, height: 6)

        return btn
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskButton.isHidden = !isOwner
        setupUI()

        setupTable()

        loadBoardData()

        listenTasks()
        navigationItem.hidesBackButton = false

        navigationController?
            .navigationBar
            .topItem?
            .backButtonDisplayMode = .minimal

        navigationController?
            .navigationBar.tintColor = .white

        addTaskButton.addTarget(
            self,
            action: #selector(openAddTask),
            for: .touchUpInside
        )
    }
}

extension BoardDetailViewController {

    func setupUI() {

        view.backgroundColor =
        UIColor(
            red: 10/255,
            green: 12/255,
            blue: 28/255,
            alpha: 1
        )

        title = "Board"

        navigationController?
            .navigationBar.tintColor = .white

        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints =
        false

        scrollView.addSubview(contentView)

        contentView.translatesAutoresizingMaskIntoConstraints =
        false

        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            scrollView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            scrollView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            scrollView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),

            contentView.topAnchor.constraint(
                equalTo: scrollView.topAnchor
            ),

            contentView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor
            ),

            contentView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor
            ),

            contentView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor
            ),

            contentView.widthAnchor.constraint(
                equalTo: scrollView.widthAnchor
            )
        ])

        setupHeaderCard()

        setupTaskTable()

        setupFloatingButton()
    }

    func setupHeaderCard() {
        
        
        let card = UIView()

        card.translatesAutoresizingMaskIntoConstraints =
        false

        card.backgroundColor =
        UIColor.white.withAlphaComponent(0.08)

        card.layer.cornerRadius = 28

        card.layer.borderWidth = 1

        card.layer.borderColor =
        UIColor.white.withAlphaComponent(0.08).cgColor

        contentView.addSubview(card)

        NSLayoutConstraint.activate([

            card.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 20
            ),

            card.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),

            card.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            )
        ])

        titleLabel.translatesAutoresizingMaskIntoConstraints =
        false

        titleLabel.font =
        .systemFont(
            ofSize: 28,
            weight: .bold
        )

        titleLabel.textColor = .white

        descLabel.translatesAutoresizingMaskIntoConstraints =
        false

        descLabel.textColor =
        UIColor.lightGray

        descLabel.numberOfLines = 0

        privacyBadge.translatesAutoresizingMaskIntoConstraints =
        false

        privacyBadge.textAlignment = .center

        privacyBadge.font =
        .systemFont(
            ofSize: 14,
            weight: .semibold
        )

        privacyBadge.textColor = .white

        privacyBadge.layer.cornerRadius = 12

        privacyBadge.clipsToBounds = true

        membersLabel.translatesAutoresizingMaskIntoConstraints =
        false

        membersLabel.textColor =
        UIColor.systemGray2

        membersLabel.numberOfLines = 0

        card.addSubview(titleLabel)

        card.addSubview(descLabel)

        card.addSubview(privacyBadge)

        card.addSubview(membersLabel)
        
        let blur =
        UIVisualEffectView(
            effect: UIBlurEffect(
                style: .systemUltraThinMaterialDark
            )
        )

        blur.translatesAutoresizingMaskIntoConstraints =
        false

        blur.layer.cornerRadius = 28

        blur.clipsToBounds = true

        card.insertSubview(blur, at: 0)

        NSLayoutConstraint.activate([

            blur.topAnchor.constraint(
                equalTo: card.topAnchor
            ),

            blur.leadingAnchor.constraint(
                equalTo: card.leadingAnchor
            ),

            blur.trailingAnchor.constraint(
                equalTo: card.trailingAnchor
            ),

            blur.bottomAnchor.constraint(
                equalTo: card.bottomAnchor
            )
        ])

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(
                equalTo: card.topAnchor,
                constant: 24
            ),

            titleLabel.leadingAnchor.constraint(
                equalTo: card.leadingAnchor,
                constant: 20
            ),

            privacyBadge.centerYAnchor.constraint(
                equalTo: titleLabel.centerYAnchor
            ),

            privacyBadge.trailingAnchor.constraint(
                equalTo: card.trailingAnchor,
                constant: -20
            ),

            privacyBadge.widthAnchor.constraint(
                equalToConstant: 90
            ),

            privacyBadge.heightAnchor.constraint(
                equalToConstant: 32
            ),

            descLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 14
            ),

            descLabel.leadingAnchor.constraint(
                equalTo: card.leadingAnchor,
                constant: 20
            ),

            descLabel.trailingAnchor.constraint(
                equalTo: card.trailingAnchor,
                constant: -20
            ),

            membersLabel.topAnchor.constraint(
                equalTo: descLabel.bottomAnchor,
                constant: 18
            ),

            membersLabel.leadingAnchor.constraint(
                equalTo: card.leadingAnchor,
                constant: 20
            ),

            membersLabel.trailingAnchor.constraint(
                equalTo: card.trailingAnchor,
                constant: -20
            ),

            membersLabel.bottomAnchor.constraint(
                equalTo: card.bottomAnchor,
                constant: -24
            )
        ])
    }

    func setupTaskTable() {

        contentView.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints =
        false

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(
                equalTo: membersLabel.bottomAnchor,
                constant: 30
            ),

            tableView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),

            tableView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),

            tableView.heightAnchor.constraint(
                equalToConstant: 900
            ),

            tableView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -120
            )
        ])
    }

    func setupFloatingButton() {

        view.addSubview(addTaskButton)

        NSLayoutConstraint.activate([

            addTaskButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),

            addTaskButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -24
            ),

            addTaskButton.widthAnchor.constraint(
                equalToConstant: 64
            ),

            addTaskButton.heightAnchor.constraint(
                equalToConstant: 64
            )
        ])
    }
}

extension BoardDetailViewController {

    func loadBoardData() {

        titleLabel.text = board.title

        descLabel.text = board.description

        privacyBadge.text = board.privacy

        if board.privacy == "Public" {

            privacyBadge.backgroundColor =
            UIColor.systemGreen

        } else {

            privacyBadge.backgroundColor =
            UIColor.systemOrange
        }

        membersLabel.text =
        "Members: \(board.members.joined(separator: ", "))"
    }

    func listenTasks() {

        db.collection("boards")
            .document(board.id)
            .collection("tasks")

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

                self.tasks = docs.map {

                    Task(data: $0.data())
                }

                DispatchQueue.main.async {

                    self.tableView.reloadData()
                }
            }
    }
}


extension BoardDetailViewController:
UITableViewDelegate,
UITableViewDataSource {

    func setupTable() {

        tableView.delegate = self

        tableView.dataSource = self

        tableView.separatorStyle = .none

        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0

        tableView.register(
            TaskTableViewCell.self,
            forCellReuseIdentifier: "taskCell"
        )
    }

    func numberOfSections(
        in tableView: UITableView
    ) -> Int {

        return 3
    }

    

    func filteredTasks(
        for section: Int
    ) -> [Task] {

        switch section {

        case 0:
            return tasks.filter {
                $0.status == "Todo"
            }

        case 1:
            return tasks.filter {
                $0.status == "Doing"
            }

        default:
            return tasks.filter {
                $0.status == "Done"
            }
        }
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return filteredTasks(
            for: section
        ).count
    }
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {

        let container = UIView()

        container.backgroundColor = .clear

        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints =
        false

        label.font =
        .systemFont(
            ofSize: 26,
            weight: .bold
        )

        switch section {

        case 0:

            label.text = "TODO"
            label.textColor = UIColor.systemOrange

        case 1:

            label.text = "DOING"
            label.textColor = UIColor.systemBlue

        default:

            label.text = "DONE"
            label.textColor = UIColor.systemGreen
        }

        container.addSubview(label)

        NSLayoutConstraint.activate([

            label.leadingAnchor.constraint(
                equalTo: container.leadingAnchor,
                constant: 24
            ),

            label.bottomAnchor.constraint(
                equalTo: container.bottomAnchor,
                constant: -6
            )
        ])

        return container
    }
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {

        return 50
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell =
        tableView.dequeueReusableCell(
            withIdentifier: "taskCell",
            for: indexPath
        ) as! TaskTableViewCell

        let task =
        filteredTasks(
            for: indexPath.section
        )[indexPath.row]

        cell.configure(task: task)

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt
        indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {

        if !isOwner {

            return nil
        }

        let task =
        filteredTasks(
            for: indexPath.section
        )[indexPath.row]

        let delete =
        UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { _, _, completion in

            self.db.collection("boards")
                .document(self.board.id)
                .collection("tasks")
                .document(task.id)
                .delete()

            completion(true)
        }

        return UISwipeActionsConfiguration(
            actions: [delete]
        )
    }
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        let task =
        filteredTasks(
            for: indexPath.section
        )[indexPath.row]

        // ONLY ASSIGNED MEMBER
        if task.assignedTo != currentUserEmail {

            return
        }

        var nextStatus = task.status

        switch task.status {

        case "Todo":

            nextStatus = "Doing"

        case "Doing":

            nextStatus = "Done"

        default:

            return
        }

        db.collection("boards")
            .document(board.id)
            .collection("tasks")
            .document(task.id)
            .updateData([

                "status": nextStatus
            ])
    }
}


extension BoardDetailViewController {

    @objc func openAddTask() {

        let vc =
        AddTaskBottomSheetViewController()

        vc.board = board

        if let sheet =
            vc.sheetPresentationController {

            sheet.detents = [
                .large()
            ]
        }

        present(vc, animated: true)
    }
}


func createSectionLabel(
    title: String
) -> UILabel {

    let lbl = UILabel()

    lbl.text = title

    lbl.textColor = .white

    lbl.font =
    .systemFont(
        ofSize: 24,
        weight: .bold
    )

    return lbl
}
