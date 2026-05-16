//
//  CreateBoardViewController.swift
//  caption
//
//  Created by Yalakaturi Someshwar Naidu on 11/05/26.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class CreateBoardViewController: UIViewController,UITextViewDelegate {
    
    let db = Firestore.firestore()

    var selectedPrivacy = "Private"

    var privateRadio = UIView()

    var publicRadio = UIView()

    let scrollView = UIScrollView()

    let contentView = UIView()

    

    let backButton: UIButton = {

        let btn = UIButton(type: .system)

        btn.setImage(
            UIImage(systemName: "chevron.left"),
            for: .normal
        )

        btn.tintColor = .white

        return btn
    }()

    let titleLabel: UILabel = {

        let lbl = UILabel()

        lbl.text = "Create New Board"

        lbl.textColor = .white

        lbl.font = .systemFont(
            ofSize: 22,
            weight: .bold
        )

        return lbl
    }()

    let doneButton: UIButton = {

        let btn = UIButton(type: .system)

        btn.setTitle(
            "Done",
            for: .normal
        )

        btn.setTitleColor(
            .systemBlue,
            for: .normal
        )

        btn.titleLabel?.font =
        .systemFont(
            ofSize: 18,
            weight: .semibold
        )

        return btn
    }()

  

    let coverView: UIView = {

        let view = UIView()

        view.backgroundColor =
        UIColor.systemBlue.withAlphaComponent(0.15)

        view.layer.cornerRadius = 65

        return view
    }()

    let coverImage: UIImageView = {

        let img = UIImageView()

        img.image =
        UIImage(systemName: "camera")

        img.tintColor = .systemBlue

        img.contentMode = .scaleAspectFit

        return img
    }()

    let coverLabel: UILabel = {

        let lbl = UILabel()

        lbl.text = "Add Cover"

        lbl.textColor = .systemBlue

        lbl.font =
        .systemFont(
            ofSize: 17,
            weight: .semibold
        )

        return lbl
    }()



    let boardNameLabel =
    makeSectionLabel(text: "Board Name")

    let descLabel =
    makeSectionLabel(text: "Description")

    let privacyLabel =
    makeSectionLabel(text: "Privacy")

    let inviteLabel =
    makeSectionLabel(text: "Invite Members")

    let boardTextField =
    makeTextField(
        placeholder: "Enter board name"
    )

    let inviteTextField =
    makeTextField(
        placeholder: "Add members by email"
    )

    let descriptionTextView: UITextView = {

        let tv = UITextView()

        tv.backgroundColor =
        UIColor.white.withAlphaComponent(0.06)

        tv.textColor = .white

        tv.font =
        .systemFont(ofSize: 16)

        tv.layer.cornerRadius = 16

        tv.layer.borderWidth = 1

        tv.layer.borderColor =
        UIColor.white.withAlphaComponent(0.08).cgColor

        tv.textContainerInset =
        UIEdgeInsets(
            top: 15,
            left: 10,
            bottom: 15,
            right: 10
        )

        tv.text = "Enter description"

        tv.textColor = .lightGray

        return tv
    }()



    let privacyCard: UIView = {

        let view = UIView()

        view.backgroundColor =
        UIColor.white.withAlphaComponent(0.06)

        view.layer.cornerRadius = 20

        return view
    }()

   

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        descriptionTextView.delegate = self

        doneButton.addTarget(
            self,
            action: #selector(saveBoard),
            for: .touchUpInside
        )

        backButton.addTarget(
            self,
            action: #selector(goBack),
            for: .touchUpInside
        )
    }

   

    @objc func goBack() {

        if navigationController != nil {

            navigationController?.popViewController(
                animated: true
            )

        } else {

            dismiss(animated: true)
        }
    }

    @objc func saveBoard() {

        guard let uid =
                Auth.auth().currentUser?.uid
        else {
            return
        }

        guard let currentEmail =
                Auth.auth().currentUser?.email
        else {
            return
        }

        guard let boardName =
                boardTextField.text,
              !boardName.trimmingCharacters(
                in: .whitespaces
              ).isEmpty
        else {

            showAlert(msg: "Enter board name")
            return
        }

        let id = UUID().uuidString

        var desc = descriptionTextView.text ?? ""

        if desc == "Enter description" {

            desc = ""
        }

        let invitedMembers =
        inviteTextField.text ?? ""

        var members: [String] = [currentEmail]

        if !invitedMembers.isEmpty {

            let extraMembers =
            invitedMembers
                .components(separatedBy: ",")

                .map {

                    $0.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )
                }

                .filter {

                    !$0.isEmpty
                }

            members.append(contentsOf: extraMembers)
        }

        members = Array(Set(members))

        if selectedPrivacy == "Private"
            && members.count == 1 {

            showAlert(
                msg: "Add at least one member email"
            )

            return
        }

        let data: [String: Any] = [

            "id": id,

            "title": boardName,

            "description": desc,

            "privacy": selectedPrivacy,

            "ownerId": uid,

            "ownerEmail": currentEmail,

            "members": members,

            "createdAt": Timestamp()
        ]

        doneButton.isEnabled = false

        db.collection("boards")
            .document(id)
            .setData(data) { error in

                self.doneButton.isEnabled = true

                if let error = error {

                    self.showAlert(
                        msg: error.localizedDescription
                    )

                    return
                }

                print("Board Saved")

                self.navigationController?
                    .popViewController(animated: true)
            }
    }
    @objc func selectPrivacy(
        _ sender: UITapGestureRecognizer
    ) {

        guard let view = sender.view else {
            return
        }

        if view.tag == 0 {

            selectedPrivacy = "Private"

            privateRadio.backgroundColor =
            .systemBlue

            privateRadio.layer.borderColor =
            UIColor.systemBlue.cgColor

            publicRadio.backgroundColor =
            .clear

            publicRadio.layer.borderColor =
            UIColor.lightGray.cgColor

        } else {

            selectedPrivacy = "Public"

            publicRadio.backgroundColor =
            .systemBlue

            publicRadio.layer.borderColor =
            UIColor.systemBlue.cgColor

            privateRadio.backgroundColor =
            .clear

            privateRadio.layer.borderColor =
            UIColor.lightGray.cgColor
        }
    }
    func textViewDidBeginEditing(
        _ textView: UITextView
    ) {

        if textView.text == "Enter description" {

            textView.text = ""

            textView.textColor = .white
        }
    }

    func textViewDidEndEditing(
        _ textView: UITextView
    ) {

        if textView.text.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty {

            textView.text = "Enter description"

            textView.textColor = .lightGray
        }
    }

    func showAlert(msg: String) {

        let alert = UIAlertController(
            title: "Error",
            message: msg,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        present(alert, animated: true)
    }
}


extension CreateBoardViewController {

    func setupUI() {

        view.backgroundColor =
        UIColor(
            red: 13/255,
            green: 17/255,
            blue: 30/255,
            alpha: 1
        )

        navigationController?.navigationBar.isHidden = true

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

        // Top Bar

        contentView.addSubview(backButton)

        contentView.addSubview(titleLabel)

        contentView.addSubview(doneButton)

        backButton.translatesAutoresizingMaskIntoConstraints =
        false

        titleLabel.translatesAutoresizingMaskIntoConstraints =
        false

        doneButton.translatesAutoresizingMaskIntoConstraints =
        false

        NSLayoutConstraint.activate([

            backButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),

            backButton.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10
            ),

            backButton.widthAnchor.constraint(
                equalToConstant: 30
            ),

            backButton.heightAnchor.constraint(
                equalToConstant: 30
            ),

            titleLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),

            titleLabel.centerYAnchor.constraint(
                equalTo: backButton.centerYAnchor
            ),

            doneButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),

            doneButton.centerYAnchor.constraint(
                equalTo: backButton.centerYAnchor
            )
        ])

        // Cover

        contentView.addSubview(coverView)

        coverView.translatesAutoresizingMaskIntoConstraints =
        false

        coverView.addSubview(coverImage)

        coverView.addSubview(coverLabel)

        coverImage.translatesAutoresizingMaskIntoConstraints =
        false

        coverLabel.translatesAutoresizingMaskIntoConstraints =
        false

        NSLayoutConstraint.activate([

            coverView.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 40
            ),

            coverView.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),

            coverView.widthAnchor.constraint(
                equalToConstant: 130
            ),

            coverView.heightAnchor.constraint(
                equalToConstant: 130
            ),

            coverImage.centerXAnchor.constraint(
                equalTo: coverView.centerXAnchor
            ),

            coverImage.centerYAnchor.constraint(
                equalTo: coverView.centerYAnchor,
                constant: -10
            ),

            coverImage.widthAnchor.constraint(
                equalToConstant: 35
            ),

            coverImage.heightAnchor.constraint(
                equalToConstant: 35
            ),

            coverLabel.topAnchor.constraint(
                equalTo: coverImage.bottomAnchor,
                constant: 8
            ),

            coverLabel.centerXAnchor.constraint(
                equalTo: coverView.centerXAnchor
            )
        ])

        // Fields

        let stack = UIStackView(
            arrangedSubviews: [

                boardNameLabel,

                boardTextField,

                descLabel,

                descriptionTextView,

                privacyLabel,

                privacyCard,

                inviteLabel,

                inviteTextField
            ]
        )

        stack.axis = .vertical

        stack.spacing = 16

        contentView.addSubview(stack)

        stack.translatesAutoresizingMaskIntoConstraints =
        false

        NSLayoutConstraint.activate([

            stack.topAnchor.constraint(
                equalTo: coverView.bottomAnchor,
                constant: 40
            ),

            stack.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),

            stack.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),

            stack.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -40
            ),

            boardTextField.heightAnchor.constraint(
                equalToConstant: 58
            ),

            descriptionTextView.heightAnchor.constraint(
                equalToConstant: 130
            ),

            privacyCard.heightAnchor.constraint(
                equalToConstant: 140
            ),

            inviteTextField.heightAnchor.constraint(
                equalToConstant: 58
            )
        ])

        setupPrivacyOptions()
    }
}


extension CreateBoardViewController {

    func setupPrivacyOptions() {

        let privateRow = createPrivacyRow(
            title: "Private",
            subtitle: "Only invited members",
            selected: true
        )

        privateRow.tag = 0

        let publicRow = createPrivacyRow(
            title: "Public",
            subtitle: "Anyone with the link",
            selected: false
        )

        publicRow.tag = 1

        let privateTap =
        UITapGestureRecognizer(
            target: self,
            action: #selector(selectPrivacy(_:))
        )

        let publicTap =
        UITapGestureRecognizer(
            target: self,
            action: #selector(selectPrivacy(_:))
        )

        privateRow.addGestureRecognizer(privateTap)

        publicRow.addGestureRecognizer(publicTap)

        let stack = UIStackView(
            arrangedSubviews: [
                privateRow,
                publicRow
            ]
        )

        stack.axis = .vertical

        stack.spacing = 10

        privacyCard.addSubview(stack)

        stack.translatesAutoresizingMaskIntoConstraints =
        false

        NSLayoutConstraint.activate([

            stack.topAnchor.constraint(
                equalTo: privacyCard.topAnchor,
                constant: 20
            ),

            stack.leadingAnchor.constraint(
                equalTo: privacyCard.leadingAnchor,
                constant: 20
            ),

            stack.trailingAnchor.constraint(
                equalTo: privacyCard.trailingAnchor,
                constant: -20
            )
        ])
    }

    func createPrivacyRow(
        title: String,
        subtitle: String,
        selected: Bool
    ) -> UIView {

        let container = UIView()

        let radio = UIView()

        radio.translatesAutoresizingMaskIntoConstraints =
        false

        radio.layer.cornerRadius = 11

        radio.layer.borderWidth = 2

        if selected {

            radio.backgroundColor = .systemBlue

            radio.layer.borderColor =
            UIColor.systemBlue.cgColor

            privateRadio = radio

        } else {

            radio.backgroundColor = .clear

            radio.layer.borderColor =
            UIColor.lightGray.cgColor

            publicRadio = radio
        }

        let titleLbl = UILabel()

        titleLbl.text = title

        titleLbl.textColor = .white

        titleLbl.font =
        .systemFont(
            ofSize: 18,
            weight: .semibold
        )

        let subLbl = UILabel()

        subLbl.text = subtitle

        subLbl.textColor = .lightGray

        subLbl.font =
        .systemFont(ofSize: 14)

        let textStack = UIStackView(
            arrangedSubviews: [
                titleLbl,
                subLbl
            ]
        )

        textStack.axis = .vertical

        textStack.spacing = 2

        let hStack = UIStackView(
            arrangedSubviews: [
                radio,
                textStack
            ]
        )

        hStack.axis = .horizontal

        hStack.spacing = 14

        hStack.alignment = .center

        container.addSubview(hStack)

        hStack.translatesAutoresizingMaskIntoConstraints =
        false

        NSLayoutConstraint.activate([

            radio.widthAnchor.constraint(
                equalToConstant: 22
            ),

            radio.heightAnchor.constraint(
                equalToConstant: 22
            ),

            hStack.topAnchor.constraint(
                equalTo: container.topAnchor
            ),

            hStack.leadingAnchor.constraint(
                equalTo: container.leadingAnchor
            ),

            hStack.trailingAnchor.constraint(
                equalTo: container.trailingAnchor
            ),

            hStack.bottomAnchor.constraint(
                equalTo: container.bottomAnchor
            )
        ])

        return container
    }
}


func makeSectionLabel(
    text: String
) -> UILabel {

    let lbl = UILabel()

    lbl.text = text

    lbl.textColor = .white

    lbl.font =
    .systemFont(
        ofSize: 18,
        weight: .semibold
    )

    return lbl
}

func makeTextField(
    placeholder: String
) -> UITextField {

    let tf = UITextField()

    tf.backgroundColor =
    UIColor.white.withAlphaComponent(0.06)

    tf.layer.cornerRadius = 16

    tf.layer.borderWidth = 1

    tf.layer.borderColor =
    UIColor.white.withAlphaComponent(0.08).cgColor

    tf.textColor = .white

    tf.attributedPlaceholder =
    NSAttributedString(
        string: placeholder,
        attributes: [
            .foregroundColor:
            UIColor.lightGray
        ]
    )

    tf.setLeftPaddingPoints(16)

    return tf
}


extension UITextField {

    func setLeftPaddingPoints(
        _ amount: CGFloat
    ) {

        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: amount,
                height: self.frame.size.height
            )
        )

        leftView = paddingView

        leftViewMode = .always
    }
}
