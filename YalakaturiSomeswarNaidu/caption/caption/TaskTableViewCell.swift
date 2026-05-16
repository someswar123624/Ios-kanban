//
//  TaskTableViewCell.swift
//  caption
//

import UIKit

class TaskTableViewCell:
UITableViewCell {

   
    let cardView = UIView()

    let statusGlow = UIView()

    let titleLabel = UILabel()

    let descLabel = UILabel()

    let assignedLabel = UILabel()

    let avatarView = UIView()

    let avatarLabel = UILabel()

    

    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {

        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError(
            "init(coder:) has not been implemented"
        )
    }

  

    func setupUI() {

        backgroundColor = .clear

        selectionStyle = .none

        contentView.backgroundColor = .clear

        // CARD

        cardView.translatesAutoresizingMaskIntoConstraints =
        false

        cardView.backgroundColor =
        UIColor.white.withAlphaComponent(0.12)

        cardView.layer.cornerRadius = 24

        cardView.layer.borderWidth = 1

        cardView.layer.borderColor =
        UIColor.white.withAlphaComponent(0.08).cgColor

        contentView.addSubview(cardView)

        // GLOW

        statusGlow.translatesAutoresizingMaskIntoConstraints =
        false

        statusGlow.layer.cornerRadius = 6

        cardView.addSubview(statusGlow)

        // TITLE

        titleLabel.translatesAutoresizingMaskIntoConstraints =
        false

        titleLabel.font =
        .systemFont(
            ofSize: 18,
            weight: .bold
        )

        titleLabel.textColor = .white

        cardView.addSubview(titleLabel)

        // DESCRIPTION

        descLabel.translatesAutoresizingMaskIntoConstraints =
        false

        descLabel.font =
        .systemFont(ofSize: 14)

        descLabel.textColor = UIColor.white.withAlphaComponent(0.75)

        descLabel.numberOfLines = 2

        cardView.addSubview(descLabel)

        // ASSIGNED

        assignedLabel.translatesAutoresizingMaskIntoConstraints =
        false

        assignedLabel.font =
        .systemFont(
            ofSize: 13,
            weight: .medium
        )

        assignedLabel.textColor =
        UIColor.systemGray2

        cardView.addSubview(assignedLabel)

        // AVATAR

        avatarView.translatesAutoresizingMaskIntoConstraints =
        false

        avatarView.layer.cornerRadius = 22

        avatarView.backgroundColor =
        UIColor.systemPink.withAlphaComponent(0.3)

        cardView.addSubview(avatarView)

        avatarLabel.translatesAutoresizingMaskIntoConstraints =
        false

        avatarLabel.font =
        .systemFont(
            ofSize: 16,
            weight: .bold
        )

        avatarLabel.textColor = .white

        avatarView.addSubview(avatarLabel)

        // CONSTRAINTS

        NSLayoutConstraint.activate([

            cardView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10
            ),

            cardView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 20
            ),

            cardView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -20
            ),

            cardView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -10
            ),

            cardView.heightAnchor.constraint(
                greaterThanOrEqualToConstant: 120
            ),

            statusGlow.leadingAnchor.constraint(
                equalTo: cardView.leadingAnchor,
                constant: 18
            ),

            statusGlow.topAnchor.constraint(
                equalTo: cardView.topAnchor,
                constant: 24
            ),

            statusGlow.widthAnchor.constraint(
                equalToConstant: 12
            ),

            statusGlow.heightAnchor.constraint(
                equalToConstant: 12
            ),

            titleLabel.leadingAnchor.constraint(
                equalTo: statusGlow.trailingAnchor,
                constant: 14
            ),

            titleLabel.topAnchor.constraint(
                equalTo: cardView.topAnchor,
                constant: 18
            ),

            titleLabel.trailingAnchor.constraint(
                equalTo: avatarView.leadingAnchor,
                constant: -12
            ),

            descLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),

            descLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 10
            ),

            descLabel.trailingAnchor.constraint(
                equalTo: cardView.trailingAnchor,
                constant: -20
            ),

            assignedLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),

            assignedLabel.topAnchor.constraint(
                equalTo: descLabel.bottomAnchor,
                constant: 14
            ),

            assignedLabel.bottomAnchor.constraint(
                equalTo: cardView.bottomAnchor,
                constant: -18
            ),

            avatarView.trailingAnchor.constraint(
                equalTo: cardView.trailingAnchor,
                constant: -18
            ),

            avatarView.centerYAnchor.constraint(
                equalTo: titleLabel.centerYAnchor
            ),

            avatarView.widthAnchor.constraint(
                equalToConstant: 44
            ),

            avatarView.heightAnchor.constraint(
                equalToConstant: 44
            ),

            avatarLabel.centerXAnchor.constraint(
                equalTo: avatarView.centerXAnchor
            ),

            avatarLabel.centerYAnchor.constraint(
                equalTo: avatarView.centerYAnchor
            )
        ])
    }

  

    func configure(task: Task) {

        titleLabel.text =
        task.title

        descLabel.text =
        task.description

        assignedLabel.text =
        "Assigned to: \(task.assignedTo)"

        avatarLabel.text =
        String(
            task.assignedTo.prefix(1)
        ).uppercased()

        switch task.status {

        case "Todo":

            statusGlow.backgroundColor =
            UIColor.systemOrange

            avatarView.backgroundColor =
            UIColor.systemOrange
                .withAlphaComponent(0.25)

        case "Doing":

            statusGlow.backgroundColor =
            UIColor.systemBlue

            avatarView.backgroundColor =
            UIColor.systemBlue
                .withAlphaComponent(0.25)

        default:

            statusGlow.backgroundColor =
            UIColor.systemGreen

            avatarView.backgroundColor =
            UIColor.systemGreen
                .withAlphaComponent(0.25)
        }

        addFloatingAnimation()
    }

  

    func addFloatingAnimation() {

        layer.removeAllAnimations()

        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: [
                .autoreverse,
                .repeat,
                .allowUserInteraction
            ]
        ) {

            self.transform =
            CGAffineTransform(
                translationX: 0,
                y: -2
            )
        }
    }
}
