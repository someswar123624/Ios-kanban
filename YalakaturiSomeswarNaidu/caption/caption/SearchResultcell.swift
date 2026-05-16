//
//  SearchResultcell.swift
//  caption
//
//  Created by Yalakaturi Someshwar Naidu on 12/05/26.
//

import UIKit

class SearchResultCell:
UITableViewCell {

    static let identifier =
    "SearchResultCell"

    let cardView = UIView()

    let titleLabel = UILabel()

    let subtitleLabel = UILabel()

    let statusLabel = UILabel()

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
        UIColor(
            red: 34/255,
            green: 36/255,
            blue: 59/255,
            alpha: 1
        )

        cardView.layer.cornerRadius = 22

        contentView.addSubview(cardView)

        titleLabel.translatesAutoresizingMaskIntoConstraints =
        false

        titleLabel.font =
        .systemFont(
            ofSize: 20,
            weight: .bold
        )

        titleLabel.textColor = .white

        subtitleLabel.translatesAutoresizingMaskIntoConstraints =
        false

        subtitleLabel.font =
        .systemFont(
            ofSize: 14,
            weight: .medium
        )

        subtitleLabel.textColor =
        .white.withAlphaComponent(0.7)

        statusLabel.translatesAutoresizingMaskIntoConstraints =
        false

        statusLabel.font =
        .systemFont(
            ofSize: 13,
            weight: .bold
        )

        statusLabel.textColor = .systemPink

        cardView.addSubview(titleLabel)

        cardView.addSubview(subtitleLabel)

        cardView.addSubview(statusLabel)

        NSLayoutConstraint.activate([

            cardView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8
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
                constant: -8
            ),

            titleLabel.topAnchor.constraint(
                equalTo: cardView.topAnchor,
                constant: 18
            ),

            titleLabel.leadingAnchor.constraint(
                equalTo: cardView.leadingAnchor,
                constant: 18
            ),

            subtitleLabel.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 10
            ),

            subtitleLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),

            statusLabel.topAnchor.constraint(
                equalTo: subtitleLabel.bottomAnchor,
                constant: 14
            ),

            statusLabel.leadingAnchor.constraint(
                equalTo: titleLabel.leadingAnchor
            ),

            statusLabel.bottomAnchor.constraint(
                equalTo: cardView.bottomAnchor,
                constant: -18
            )
        ])
    }

    func configure(
        item: SearchItem
    ) {

        titleLabel.text = item.title

        subtitleLabel.text =
        item.subtitle

        statusLabel.text =
        item.status.uppercased()
    }
}
