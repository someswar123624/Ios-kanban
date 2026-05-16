//
//  NotificationCell.swift
//  caption
//

import UIKit

class NotificationCell:
UITableViewCell {

    let cardView = UIView()

    let iconView = UIView()

    let bellImage = UIImageView()

    let titleLabel = UILabel()

    let subtitleLabel = UILabel()

    let unreadDot = UIView()

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
        fatalError()
    }

    func setupUI() {

        backgroundColor = .clear

        selectionStyle = .none

        cardView.translatesAutoresizingMaskIntoConstraints =
        false

        cardView.backgroundColor =
        UIColor.white.withAlphaComponent(0.08)

        cardView.layer.cornerRadius = 24

        contentView.addSubview(cardView)

        iconView.translatesAutoresizingMaskIntoConstraints =
        false

        iconView.backgroundColor =
        UIColor.systemPink.withAlphaComponent(0.2)

        iconView.layer.cornerRadius = 24

        cardView.addSubview(iconView)

        bellImage.translatesAutoresizingMaskIntoConstraints =
        false

        bellImage.image =
        UIImage(systemName: "bell.fill")

        bellImage.tintColor = .systemPink

        iconView.addSubview(bellImage)

        titleLabel.translatesAutoresizingMaskIntoConstraints =
        false

        titleLabel.font =
        .systemFont(
            ofSize: 18,
            weight: .bold
        )

        titleLabel.textColor = .white

        cardView.addSubview(titleLabel)

        subtitleLabel.translatesAutoresizingMaskIntoConstraints =
        false

        subtitleLabel.font =
        .systemFont(ofSize: 14)

        subtitleLabel.textColor =
        UIColor.white.withAlphaComponent(0.7)

        subtitleLabel.numberOfLines = 2

        cardView.addSubview(subtitleLabel)

        unreadDot.translatesAutoresizingMaskIntoConstraints =
        false

        unreadDot.backgroundColor =
        UIColor.systemPink

        unreadDot.layer.cornerRadius = 6

        cardView.addSubview(unreadDot)

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

            iconView.leadingAnchor.constraint(
                equalTo: cardView.leadingAnchor,
                constant: 16
            ),

            iconView.centerYAnchor.constraint(
                equalTo: cardView.centerYAnchor
            ),

            iconView.widthAnchor.constraint(
                equalToConstant: 48
            ),

            iconView.heightAnchor.constraint(
                equalToConstant: 48
            ),

            bellImage.centerXAnchor.constraint(
                equalTo: iconView.centerXAnchor
            ),

            bellImage.centerYAnchor.constraint(
                equalTo: iconView.centerYAnchor
            ),

            titleLabel.topAnchor.constraint(
                equalTo: cardView.topAnchor,
                constant: 20
            ),

            titleLabel.leadingAnchor.constraint(
                equalTo: iconView.trailingAnchor,
                constant: 16
            ),

            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 8
            ),

            subtitleLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),

            subtitleLabel.trailingAnchor.constraint(
                equalTo: cardView.trailingAnchor,
                constant: -20
            ),

            unreadDot.topAnchor.constraint(
                equalTo: cardView.topAnchor,
                constant: 18
            ),

            unreadDot.trailingAnchor.constraint(
                equalTo: cardView.trailingAnchor,
                constant: -18
            ),

            unreadDot.widthAnchor.constraint(
                equalToConstant: 12
            ),

            unreadDot.heightAnchor.constraint(
                equalToConstant: 12
            )
        ])
    }

    func configure(
        notification: NotificationModel
    ) {

        titleLabel.text = "Task Assigned"

        subtitleLabel.text =
        notification.message

        unreadDot.isHidden =
        notification.isRead
    }
}
