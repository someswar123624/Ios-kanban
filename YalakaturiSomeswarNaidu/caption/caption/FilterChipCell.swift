//
//  FilterChipCell.swift
//  caption
//
//  Created by Yalakaturi Someshwar Naidu on 12/05/26.
//

import UIKit

class FilterChipCell:
UICollectionViewCell {

    static let identifier =
    "FilterChipCell"

    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func setupUI() {

        contentView.layer.cornerRadius = 18

        contentView.backgroundColor =
        UIColor(
            red: 34/255,
            green: 36/255,
            blue: 59/255,
            alpha: 1
        )

        titleLabel.translatesAutoresizingMaskIntoConstraints =
        false

        titleLabel.font =
        .systemFont(
            ofSize: 14,
            weight: .semibold
        )

        titleLabel.textColor = .white

        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([

            titleLabel.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),

            titleLabel.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            )
        ])
    }

    func configure(
        title: String,
        isSelected: Bool
    ) {

        titleLabel.text = title

        contentView.backgroundColor =
        isSelected
        ? .systemPink
        : UIColor(
            red: 34/255,
            green: 36/255,
            blue: 59/255,
            alpha: 1
        )
    }
}
