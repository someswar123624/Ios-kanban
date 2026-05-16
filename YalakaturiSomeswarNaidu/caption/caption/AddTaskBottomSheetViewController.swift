//
//  AddTaskBottomSheetViewController.swift
//  caption
//
//  Created by Yalakaturi Someshwar Naidu on 11/05/26.
//



import UIKit
import FirebaseFirestore
import FirebaseAuth

class AddTaskBottomSheetViewController:
UIViewController,
UIPickerViewDelegate,
UIPickerViewDataSource,
UITextViewDelegate {


    var board: Board!

    let db = Firestore.firestore()

    let statuses = [
        "Todo",
        "Doing",
        "Done"
    ]

    var selectedStatus = "Todo"

    var selectedMember = ""

    let titleLabel = UILabel()

    let taskField = UITextField()

    let descTextView = UITextView()

    let memberPicker = UIPickerView()

    let statusPicker = UIPickerView()

    let createButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        selectedStatus = "Todo"
    }
}


extension AddTaskBottomSheetViewController {

    func setupUI() {

        view.backgroundColor =
        UIColor(
            red: 15/255,
            green: 18/255,
            blue: 35/255,
            alpha: 1
        )

        // TITLE

        titleLabel.translatesAutoresizingMaskIntoConstraints =
        false

        titleLabel.text = "Create Task"

        titleLabel.font =
        .systemFont(
            ofSize: 26,
            weight: .bold
        )

        titleLabel.textColor = .white

        view.addSubview(titleLabel)

        // TASK FIELD

        taskField.translatesAutoresizingMaskIntoConstraints =
        false

        taskField.backgroundColor =
        UIColor.white.withAlphaComponent(0.08)

        taskField.layer.cornerRadius = 18

        taskField.textColor = .white

        taskField.attributedPlaceholder =
        NSAttributedString(
            string: "Task title",
            attributes: [
                .foregroundColor:
                UIColor.lightGray
            ]
        )

        taskField.setLeftPaddingPoints(16)

        view.addSubview(taskField)

        // DESC

        descTextView.translatesAutoresizingMaskIntoConstraints =
        false

        descTextView.backgroundColor =
        UIColor.white.withAlphaComponent(0.08)

        descTextView.layer.cornerRadius = 18

        descTextView.textColor = .lightGray

        descTextView.font =
        .systemFont(ofSize: 16)

        descTextView.text =
        "Task description"

        descTextView.delegate = self

        view.addSubview(descTextView)

        // MEMBER PICKER

        memberPicker.translatesAutoresizingMaskIntoConstraints =
        false

        memberPicker.delegate = self

        memberPicker.dataSource = self

        view.addSubview(memberPicker)

        // STATUS PICKER

        statusPicker.translatesAutoresizingMaskIntoConstraints =
        false

        statusPicker.delegate = self
        statusPicker.selectRow(
            0,
            inComponent: 0,
            animated: false
        )

        statusPicker.dataSource = self

        view.addSubview(statusPicker)

        // BUTTON

        createButton.translatesAutoresizingMaskIntoConstraints =
        false

        createButton.setTitle(
            "Create Task",
            for: .normal
        )

        createButton.setTitleColor(
            .white,
            for: .normal
        )

        createButton.titleLabel?.font =
        .systemFont(
            ofSize: 18,
            weight: .bold
        )

        createButton.backgroundColor =
        UIColor.systemPink

        createButton.layer.cornerRadius = 20

        createButton.layer.shadowColor =
        UIColor.systemPink.cgColor

        createButton.layer.shadowOpacity = 0.5

        createButton.layer.shadowRadius = 12

        createButton.layer.shadowOffset =
        CGSize(width: 0, height: 6)

        createButton.addTarget(
            self,
            action: #selector(createTask),
            for: .touchUpInside
        )

        view.addSubview(createButton)

        // CONSTRAINTS

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),

            titleLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),

            taskField.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 30
            ),

            taskField.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),

            taskField.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),

            taskField.heightAnchor.constraint(
                equalToConstant: 56
            ),

            descTextView.topAnchor.constraint(
                equalTo: taskField.bottomAnchor,
                constant: 18
            ),

            descTextView.leadingAnchor.constraint(
                equalTo: taskField.leadingAnchor
            ),

            descTextView.trailingAnchor.constraint(
                equalTo: taskField.trailingAnchor
            ),

            descTextView.heightAnchor.constraint(
                equalToConstant: 110
            ),

            memberPicker.topAnchor.constraint(
                equalTo: descTextView.bottomAnchor,
                constant: 10
            ),

            memberPicker.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            memberPicker.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            memberPicker.heightAnchor.constraint(
                equalToConstant: 100
            ),

            statusPicker.topAnchor.constraint(
                equalTo: memberPicker.bottomAnchor
            ),

            statusPicker.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            statusPicker.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            statusPicker.heightAnchor.constraint(
                equalToConstant: 100
            ),

            createButton.topAnchor.constraint(
                equalTo: statusPicker.bottomAnchor,
                constant: 24
            ),

            createButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            createButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -24
            ),

            createButton.heightAnchor.constraint(
                equalToConstant: 60
            )
        ])

        if let firstMember =
            board.members.first {

            selectedMember = firstMember
        }
    }
}

extension AddTaskBottomSheetViewController {

    func numberOfComponents(
        in pickerView: UIPickerView
    ) -> Int {

        return 1
    }

    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {

        if pickerView == memberPicker {

            return board.members.count
        }

        return statuses.count
    }

    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {

        if pickerView == memberPicker {

            return board.members[row]
        }

        return statuses[row]
    }

    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {

        if pickerView == memberPicker {

            selectedMember =
            board.members[row]

        } else {

            selectedStatus =
            statuses[row]
        }
    }
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {

        let label = UILabel()

        label.textAlignment = .center

        label.font =
        .systemFont(
            ofSize: 18,
            weight: .semibold
        )

        label.textColor = .white

        if pickerView == memberPicker {

            label.text = board.members[row]

        } else {

            label.text = statuses[row]
        }

        return label
    }
}

extension AddTaskBottomSheetViewController {

    @objc func createTask() {

        guard let title =
                taskField.text,
              !title.trimmingCharacters(
                in: .whitespaces
              ).isEmpty
        else {
            return
        }

        guard let currentEmail =
                Auth.auth().currentUser?.email
        else {
            return
        }

        let id = UUID().uuidString

        var desc =
        descTextView.text ?? ""

        if desc == "Task description" {

            desc = ""
        }
        let notificationId =
        UUID().uuidString

        let notification =
        NotificationModel(
            data: [

                "id": notificationId,

                "receiverEmail": self.selectedMember,

                "senderEmail": currentEmail,

                "message":
                "Assigned you a task in \(self.board.title)",

                "boardId": self.board.id,

                "taskId": id,

                "isRead": false,

                "createdAt": Timestamp()
            ]
        )

        self.db.collection("notifications")
            .document(notificationId)
            .setData(
                notification.toDictionary()
            )

        let task = Task(
            data: [

                "id": id,

                "title": title,

                "description": desc,

                "assignedTo": selectedMember,

                "status": selectedStatus,

                "createdBy": currentEmail,

                "createdAt": Timestamp()
            ]
        )

        db.collection("boards")
            .document(board.id)
            .collection("tasks")
            .document(id)
            .setData(task.toDictionary()) {

                error in

                if let error = error {

                    print(error.localizedDescription)
                    return
                }

                self.dismiss(animated: true)
            }
    }
}

extension AddTaskBottomSheetViewController {

    func textViewDidBeginEditing(
        _ textView: UITextView
    ) {

        if textView.text ==
            "Task description" {

            textView.text = ""

            textView.textColor = .white
        }
    }

    func textViewDidEndEditing(
        _ textView: UITextView
    ) {

        if textView.text
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            .isEmpty {

            textView.text =
            "Task description"

            textView.textColor =
            .lightGray
        }
    }
}
