//
//  profileViewController.swift
//  caption
//
//  Created by Yalakaturi Someshwar Naidu on 10/05/26.
//

import UIKit
import FirebaseAuth

class profileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    struct categories {
        
        var labelName : String
        var imageLabel : String
    }
    var sections : [[categories]] = [
        
        [
            
            categories(
                labelName: "Account Settings",
                imageLabel: "person.crop.circle"
            ),
            
            categories(
                labelName: "Notification Settings",
                imageLabel: "bell.badge.fill"
            ),
            
            categories(
                labelName: "Privacy & Security",
                imageLabel: "lock.shield.fill"
            )
        ],
        
        [
            
            categories(
                labelName: "Help & Support",
                imageLabel: "questionmark.circle.fill"
            ),
            
            categories(
                labelName: "About App",
                imageLabel: "info.circle.fill"
            )
        ]
    ]
    
    
    @IBOutlet weak var profileCardView: UIView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var ProfileEmail: UILabel!
    
    private let statusView = UIView()
    private let glowView = UIView()
    let logoutButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupBackground()
        setupCard()
        setupProfileImage()
        setupLabels()
        setupGlow()
        loadUserData()
        animateUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        
        tableView.separatorStyle = .none
        
        tableView.showsVerticalScrollIndicator = false
        setupLogoutButton()
        tableView.contentInset.bottom = 100
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        applyGradientToCard()
    }
    func setupLogoutButton() {
        
        view.addSubview(logoutButton)
        
        
        // POSITION
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            logoutButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),
            
            logoutButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),
            
            logoutButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            ),
            
            logoutButton.heightAnchor.constraint(
                equalToConstant: 58
            )
        ])
        
        
        // TITLE
        logoutButton.setTitle(
            "Logout",
            for: .normal
        )
        
        logoutButton.setTitleColor(
            .white,
            for: .normal
        )
        
        logoutButton.titleLabel?.font =
        UIFont.systemFont(
            ofSize: 18,
            weight: .bold
        )
        
        
        // ICON
        logoutButton.setImage(
            UIImage(
                systemName: "rectangle.portrait.and.arrow.right"
            ),
            for: .normal
        )
        
        logoutButton.tintColor = .white
        
        logoutButton.semanticContentAttribute =
            .forceRightToLeft
        
        logoutButton.imageEdgeInsets =
        UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 0,
            right: -10
        )
        
        
        // DESIGN
        logoutButton.backgroundColor =
        UIColor.systemRed.withAlphaComponent(0.18)
        
        logoutButton.layer.cornerRadius = 18
        
        logoutButton.layer.borderWidth = 1
        
        logoutButton.layer.borderColor =
        UIColor.systemRed.withAlphaComponent(0.35).cgColor
        
        
        // SHADOW
        logoutButton.layer.shadowColor =
        UIColor.systemRed.cgColor
        
        logoutButton.layer.shadowOpacity = 0.3
        
        logoutButton.layer.shadowRadius = 12
        
        logoutButton.layer.shadowOffset =
        CGSize(width: 0, height: 6)
        
        
        // ACTION
        logoutButton.addTarget(
            self,
            action: #selector(logoutTapped),
            for: .touchUpInside
        )
    }
    func loadUserData() {
        
        if let user = Auth.auth().currentUser {
            
            profileName.text = user.displayName
            ProfileEmail.text = user.email
        }
    }
    
    func setupBackground() {
        
        view.backgroundColor = .black
        
        let gradient = CAGradientLayer()
        
        gradient.frame = view.bounds
        
        gradient.colors = [
            
            UIColor.black.cgColor,
            
            UIColor(
                red: 0.07,
                green: 0.02,
                blue: 0.15,
                alpha: 1
            ).cgColor,
            
            UIColor.black.cgColor
        ]
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    
    
    func setupCard() {
        
        profileCardView.layer.cornerRadius = 28
        
        profileCardView.clipsToBounds = true
        
        
        // SOFT SHADOW
        profileCardView.layer.shadowColor =
        UIColor.systemPurple.cgColor
        
        profileCardView.layer.shadowOpacity = 0.15
        
        profileCardView.layer.shadowRadius = 18
        
        profileCardView.layer.shadowOffset =
        CGSize(width: 0, height: 10)
        
        
        // BORDER
        profileCardView.layer.borderWidth = 1
        
        profileCardView.layer.borderColor =
        UIColor.white.withAlphaComponent(0.03).cgColor
    }
    
    
    func applyGradientToCard() {
        
        // REMOVE OLD LAYERS
        profileCardView.layer.sublayers?.removeAll(where: {
            $0.name == "cardGradient"
        })
        
        
        // MAIN CONTAINER
        profileCardView.clipsToBounds = true
        
        profileCardView.layer.cornerRadius = 28
        
        
        // GRADIENT
        let gradient = CAGradientLayer()
        
        gradient.name = "cardGradient"
        
        gradient.frame = profileCardView.bounds
        
        gradient.cornerRadius = 28
        
        gradient.colors = [
            
            UIColor(
                red: 0.24,
                green: 0.18,
                blue: 0.45,
                alpha: 1
            ).cgColor,
            
            UIColor(
                red: 0.08,
                green: 0.08,
                blue: 0.16,
                alpha: 1
            ).cgColor
        ]
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        profileCardView.layer.insertSublayer(
            gradient,
            at: 0
        )
        
        
        // BLUR VIEW
        let blurEffect =
        UIBlurEffect(style: .systemUltraThinMaterialDark)
        
        let blurView =
        UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = profileCardView.bounds
        
        blurView.layer.cornerRadius = 28
        
        blurView.clipsToBounds = true
        
        blurView.alpha = 0.7
        
        profileCardView.insertSubview(
            blurView,
            at: 0
        )
    }
    
    
    
    func setupProfileImage() {
        
        profileImage.image =
        UIImage(systemName: "person.crop.circle.fill")
        
        profileImage.tintColor = .systemPink
        
        profileImage.backgroundColor =
        UIColor.white.withAlphaComponent(0.15)
        
        
        // SIZE + SHAPE
        profileImage.layer.cornerRadius =
        profileImage.frame.height / 2
        
        profileImage.clipsToBounds = true
        
        
        // BORDER
        profileImage.layer.borderWidth = 3
        
        profileImage.layer.borderColor =
        UIColor.white.withAlphaComponent(0.8).cgColor
        
        
        // SOFT GLOW
        profileImage.layer.shadowColor =
        UIColor.systemPurple.cgColor
        
        profileImage.layer.shadowOpacity = 0.25
        
        profileImage.layer.shadowRadius = 12
        
        profileImage.layer.shadowOffset = .zero
    }
    
    
    func setupLabels() {
        
        profileName.font =
        UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        profileName.textColor = .white
        
        
        ProfileEmail.font =
        UIFont.systemFont(ofSize: 13, weight: .medium)
        
        ProfileEmail.textColor =
        UIColor.white.withAlphaComponent(0.7)
    }
    
    
    func setupGlow() {
        
        glowView.frame = CGRect(
            x: -20,
            y: -20,
            width: 90,
            height: 90
        )
        
        glowView.backgroundColor =
        UIColor.systemPurple.withAlphaComponent(0.06)
        
        glowView.layer.cornerRadius = 45
        
        glowView.layer.shadowColor =
        UIColor.systemPurple.cgColor
        
        glowView.layer.shadowOpacity = 0.8
        
        glowView.layer.shadowRadius = 30
        
        glowView.layer.shadowOffset = .zero
        
        profileCardView.insertSubview(
            glowView,
            at: 0
        )
    }
    
    
    
    func animateUI() {
        
        profileCardView.alpha = 0
        
        profileCardView.transform =
        CGAffineTransform(
            translationX: 0,
            y: 50
        )
        
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5
        ) {
            
            self.profileCardView.alpha = 1
            
            self.profileCardView.transform = .identity
        }
        
        
        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: [.autoreverse, .repeat]
        ) {
            
            self.profileImage.transform =
            CGAffineTransform(
                translationX: 0,
                y: -6
            )
        }
    }
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        
        return sections.count
    }
    
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        
        return sections[section].count
    }
    
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        
        let cell =
        UITableViewCell(
            style: .subtitle,
            reuseIdentifier: "cell"
        )
        
        let data =
        sections[indexPath.section][indexPath.row]
        
        
        // TITLE
        cell.textLabel?.text =
        data.labelName
        
        cell.textLabel?.font =
        UIFont.systemFont(
            ofSize: 17,
            weight: .semibold
        )
        
        cell.textLabel?.textColor = .white
        
        
        // ICON
        cell.imageView?.image =
        UIImage(
            systemName: data.imageLabel
        )
        
        cell.imageView?.tintColor =
            .systemPink
        
        
        // CELL DESIGN
        cell.backgroundColor =
        UIColor.white.withAlphaComponent(0.05)
        
        cell.layer.cornerRadius = 18
        
        cell.clipsToBounds = true
        
        // WHITE RIGHT ARROW
        let whiteArrow = UIImageView()
        
        whiteArrow.image =
        UIImage(
            systemName: "chevron.right"
        )
        
        whiteArrow.tintColor = .white
        
        whiteArrow.contentMode = .scaleAspectFit
        
        whiteArrow.frame = CGRect(
            x: 0,
            y: 0,
            width: 12,
            height: 18
        )
        
        cell.accessoryView = whiteArrow
        
        
        
        // SELECTION
        let bgView = UIView()
        
        bgView.backgroundColor =
        UIColor.systemPurple.withAlphaComponent(0.25)
        
        cell.selectedBackgroundView = bgView
        // SEPARATOR
        let separator = UIView()
        
        separator.backgroundColor =
        UIColor.white.withAlphaComponent(0.12)
        
        separator.frame = CGRect(
            x: 65,
            y: 74,
            width: tableView.frame.width - 90,
            height: 0.6
        )
        
        cell.addSubview(separator)
        
        
        return cell
    }
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        
        return 75
    }
    
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        
        return 5
    }
    
    
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        tableView.deselectRow(
            at: indexPath,
            animated: true
        )

        if indexPath.section == 1 &&
            indexPath.row == 1 {

            performSegue(
                withIdentifier: "goToAbout",
                sender: self
            )
        }
    }
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        
        cell.contentView.frame =
        cell.contentView.frame.inset(
            by: UIEdgeInsets(
                top: 8,
                left: 16,
                bottom: 8,
                right: 16
            )
        )
    }
    @objc func logoutTapped() {
        
        do {
            
            try Auth.auth().signOut()
            
            print("Logged Out")
            
            
            let storyboard = UIStoryboard(
                name: "Main",
                bundle: nil
            )
            
            let loginVC =
            storyboard.instantiateViewController(
                withIdentifier: "LoginViewController"
            )
            
            
            if let sceneDelegate =
                UIApplication.shared.connectedScenes.first?.delegate
                as? SceneDelegate {
                
                sceneDelegate.window?.rootViewController = loginVC
                
                sceneDelegate.window?.makeKeyAndVisible()
            }
            
        } catch {
            
            print(error.localizedDescription)
        }
    }
}


extension profileViewController {

    func setupTabBar() {

        guard let tabBar = tabBarController?.tabBar else {
            return
        }

        let appearance = UITabBarAppearance()

        appearance.configureWithOpaqueBackground()

        appearance.backgroundColor =
        UIColor(
            red: 35/255,
            green: 36/255,
            blue: 58/255,
            alpha: 0.95
        )

        appearance.stackedLayoutAppearance.selected.iconColor =
        .systemPink

        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [

            .foregroundColor: UIColor.systemPink
        ]

        appearance.stackedLayoutAppearance.normal.iconColor =
        .white

        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [

            .foregroundColor: UIColor.white
        ]

        UITabBar.appearance().standardAppearance =
        appearance

        UITabBar.appearance().scrollEdgeAppearance =
        appearance

        UITabBar.appearance().tintColor =
        .systemPink

        UITabBar.appearance().unselectedItemTintColor =
        .white

        UITabBar.appearance().layer.cornerRadius = 24

        UITabBar.appearance().layer.masksToBounds = true
    }
}
