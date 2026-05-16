//
//  BoardTableViewCell.swift
//  caption
//
//  Created by Yalakaturi Someshwar Naidu on 10/05/26.
//

import UIKit

class BoardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    
    
    @IBOutlet weak var rightArrow: UIImageView!
    
    
    @IBOutlet weak var imageCell: UIView!
    
    @IBOutlet weak var cellTask: UILabel!
    
    @IBOutlet weak var NoOfTasks: UILabel!
    
    
       
    private let iconImage = UIImageView()

    private let blurEffectView =
    UIVisualEffectView(
        effect: UIBlurEffect(style: .systemUltraThinMaterialDark)
    )


    func addParallaxEffect() {

        let amount: CGFloat = 10

        let horizontal =
        UIInterpolatingMotionEffect(
            keyPath: "center.x",
            type: .tiltAlongHorizontalAxis
        )

        horizontal.minimumRelativeValue = -amount
        horizontal.maximumRelativeValue = amount

        let vertical =
        UIInterpolatingMotionEffect(
            keyPath: "center.y",
            type: .tiltAlongVerticalAxis
        )

        vertical.minimumRelativeValue = -amount
        vertical.maximumRelativeValue = amount

        let group = UIMotionEffectGroup()

        group.motionEffects = [
            horizontal,
            vertical
        ]

        cellView.addMotionEffect(group)
    }
    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.backgroundColor = .clear
        backgroundColor = .clear

        cellView.layer.cornerRadius = 22

        cellView.backgroundColor =
        UIColor.white.withAlphaComponent(0.08)

        cellView.layer.shadowColor =
        UIColor.black.cgColor

        cellView.layer.shadowOpacity = 0.25

        cellView.layer.shadowRadius = 12

        cellView.layer.shadowOffset =
        CGSize(width: 0, height: 8)
        
        setupMainUI()

        setupBlur()

        setupIcon()

        setupArrow()

        setupTypography()

        animateCard()
        addParallaxEffect()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        blurEffectView.frame = cellView.bounds
    }
    override func prepareForReuse() {
        super.prepareForReuse()

        iconImage.image = nil
    }
}


extension BoardTableViewCell {

    func setupMainUI() {

        selectionStyle = .none

        backgroundColor = .clear

        contentView.backgroundColor = .clear

        // CARD

        cellView.backgroundColor =
        UIColor(
            red: 28/255,
            green: 28/255,
            blue: 40/255,
            alpha: 0.88
        )

        cellView.layer.cornerRadius = 32

        cellView.layer.cornerCurve = .continuous

        cellView.clipsToBounds = false

        // SHADOW

        cellView.layer.shadowColor =
        UIColor.systemPurple.cgColor

        cellView.layer.shadowOpacity = 0.18

        cellView.layer.shadowOffset =
        CGSize(width: 0, height: 12)

        cellView.layer.shadowRadius = 25

        // BORDER

        cellView.layer.borderWidth = 1

        cellView.layer.borderColor =
        UIColor.white.withAlphaComponent(0.08).cgColor

        // ICON CONTAINER

        imageCell.layer.cornerRadius = 22

        imageCell.layer.cornerCurve = .continuous

        imageCell.clipsToBounds = true
    }
}


extension BoardTableViewCell {

    func setupBlur() {

        DispatchQueue.main.async {

            self.blurEffectView.frame =
            self.cellView.bounds
        }

        blurEffectView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]

        blurEffectView.layer.cornerRadius = 32

        blurEffectView.clipsToBounds = true

        cellView.insertSubview(
            blurEffectView,
            at: 0
        )
    }
}


extension BoardTableViewCell {

    func setupTypography() {

        cellTask.font = UIFont.systemFont(
            ofSize: 24,
            weight: .bold
        )

        cellTask.textColor = .white

        NoOfTasks.font = UIFont.systemFont(
            ofSize: 16,
            weight: .medium
        )

        NoOfTasks.textColor =
        UIColor.white.withAlphaComponent(0.7)
    }
}


extension BoardTableViewCell {

    func setupIcon() {

        iconImage.translatesAutoresizingMaskIntoConstraints = false

        iconImage.tintColor = .white

        iconImage.contentMode = .scaleAspectFit

        imageCell.addSubview(iconImage)

        NSLayoutConstraint.activate([

            iconImage.centerXAnchor.constraint(
                equalTo: imageCell.centerXAnchor
            ),

            iconImage.centerYAnchor.constraint(
                equalTo: imageCell.centerYAnchor
            ),

            iconImage.widthAnchor.constraint(
                equalToConstant: 28
            ),

            iconImage.heightAnchor.constraint(
                equalToConstant: 28
            )
        ])
    }
}

extension BoardTableViewCell {

    func setupArrow() {

        rightArrow.image =
        UIImage(systemName: "chevron.right")

        rightArrow.tintColor =
        UIColor.white.withAlphaComponent(0.45)

        rightArrow.contentMode = .scaleAspectFit
    }
}


extension BoardTableViewCell {
    func configure(
        title: String,
        privacy: String,
        membersCount: Int,
        color: UIColor,
        icon: String
    ) {

        cellTask.text = title

        NoOfTasks.text =
        "\(privacy) • \(membersCount) Members"

        iconImage.image =
        UIImage(systemName: icon)

        imageCell.backgroundColor = color

        applyPremiumGradient(color: color)

        if privacy == "Public" {

            rightArrow.tintColor =
            UIColor.systemGreen

        } else {

            rightArrow.tintColor =
            UIColor.systemOrange
        }
    }
}



extension BoardTableViewCell {

    func applyPremiumGradient(color: UIColor) {

        // Remove old gradient only

        imageCell.layer.sublayers?.removeAll(where: {

            $0.name == "gradientLayer"
        })

        let gradient = CAGradientLayer()

        gradient.name = "gradientLayer"

        gradient.colors = [

            color.cgColor,

            color.withAlphaComponent(0.55).cgColor
        ]

        gradient.startPoint =
        CGPoint(x: 0, y: 0)

        gradient.endPoint =
        CGPoint(x: 1, y: 1)

        gradient.frame = imageCell.bounds

        gradient.cornerRadius = 22

        imageCell.layer.insertSublayer(
            gradient,
            at: 0
        )

        // Glow

        imageCell.layer.shadowColor =
        color.cgColor

        imageCell.layer.shadowOpacity = 0.45

        imageCell.layer.shadowOffset =
        CGSize(width: 0, height: 0)

        imageCell.layer.shadowRadius = 14
    }
}



extension BoardTableViewCell {

    func animateCard() {

        cellView.alpha = 0

        cellView.transform =
        CGAffineTransform(
            translationX: 0,
            y: 40
        )

        UIView.animate(
            withDuration: 0.9,
            delay: 0.05,
            usingSpringWithDamping: 0.82,
            initialSpringVelocity: 0.5
        ) {

            self.cellView.alpha = 1

            self.cellView.transform = .identity
        }
    }

    }

    

