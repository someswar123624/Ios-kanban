//
//  HomeViewController.swift
//  caption
//
//  Created by Yalakaturi Someshwar Naidu on 09/05/26.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var greetLabel: UILabel!

    
    @IBOutlet weak var boradLabel: UILabel!
    
    @IBOutlet weak var newBoardBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let overviewLabel = UILabel()

    let statsStack = UIStackView()

    var tasksCard = UIView()
    var boardsCard = UIView()
    var progressCard = UIView()
    var totalTasks = 0
    var completedTasks = 0
    

    
    var selectedBoard: Board?
    
    let buttonGradient = CAGradientLayer()
    var boardData: [Board] = []

    let db = Firestore.firestore()


        override func viewDidLoad() {
            super.viewDidLoad()

            setupBackground()

            setupGreeting()
            setupOverviewSection()

            setupButton()

            setupTableView()

            setupTabBar()

            animateScreen()
            animateButtonGlow()
            fetchDashboardStats()
            
            
        }
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {

        if segue.identifier ==
            "GoToBoardDetail" {

            let vc =
            segue.destination
            as! BoardDetailViewController

            vc.board = selectedBoard
        }
    }
    
    func fetchBoards() {
            
            guard let currentEmail =
                    Auth.auth().currentUser?.email
            else {
                return
            }

            db.collection("boards")
                .getDocuments { snapshot, error in

                    if let error = error {

                        print(error.localizedDescription)
                        return
                    }

                    guard let documents =
                            snapshot?.documents
                    else {
                        return
                    }

                    let allBoards = documents.map {

                        var board = Board(data: $0.data())

                        board.id = $0.documentID

                        return board
                    }
                    self.boardData = allBoards.filter {

                        if $0.privacy == "Public" {

                            return true
                        }

                        return $0.members.contains(
                            currentEmail
                        )
                    }

                    DispatchQueue.main.async {

                        self.tableView.reloadData()
                    }
                }
        }
    func animateButtonGlow() {

        let pulse = CABasicAnimation(
            keyPath: "shadowOpacity"
        )

        pulse.fromValue = 0.2
        pulse.toValue = 0.6

        pulse.duration = 1.4
        pulse.autoreverses = true
        pulse.repeatCount = .infinity

        newBoardBtn.layer.add(
            pulse,
            forKey: "pulse"
        )
    }
    func addShimmerEffect() {

        let gradient = CAGradientLayer()

        gradient.colors = [

            UIColor.clear.cgColor,

            UIColor.white.withAlphaComponent(0.35).cgColor,

            UIColor.clear.cgColor
        ]

        gradient.frame =
        CGRect(
            x: -view.bounds.width,
            y: 0,
            width: view.bounds.width,
            height: greetLabel.bounds.height
        )

        gradient.startPoint =
        CGPoint(x: 0, y: 0.5)

        gradient.endPoint =
        CGPoint(x: 1, y: 0.5)

        greetLabel.layer.mask = gradient

        let animation = CABasicAnimation(
            keyPath: "transform.translation.x"
        )

        animation.fromValue = -view.bounds.width
        animation.toValue = view.bounds.width

        animation.duration = 2.2

        animation.repeatCount = .infinity

        gradient.add(
            animation,
            forKey: "shimmer"
        )
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        buttonGradient.frame =
        newBoardBtn.bounds
    }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            animateTable()
            fetchBoards()
            
//            addShimmerEffect()
        }
    
    }



    extension HomeViewController {

        func setupBackground() {

            let gradient = CAGradientLayer()

            gradient.colors = [

                UIColor(
                    red: 10/255,
                    green: 10/255,
                    blue: 18/255,
                    alpha: 1
                ).cgColor,

                UIColor(
                    red: 20/255,
                    green: 18/255,
                    blue: 35/255,
                    alpha: 1
                ).cgColor
            ]

            gradient.startPoint =
            CGPoint(x: 0, y: 0)

            gradient.endPoint =
            CGPoint(x: 1, y: 1)

            gradient.frame = view.bounds

            view.layer.insertSublayer(
                gradient,
                at: 0
            )
        }
    }



    extension HomeViewController {

        func setupGreeting() {
            
            let hour =
                Calendar.current.component(
                    .hour,
                    from: Date()
                )
            var greeting = ""

            switch hour {

                case 5..<12:
                    greeting = "Good Morning,"

                case 12..<17:
                    greeting = "Good Afternoon,"

                case 17..<21:
                    greeting = "Good Evening,"

                default:
                    greeting = "Working Late,"
                }

                let name =
                Auth.auth().currentUser?.displayName
                ?? "Somesh"

                greetLabel.text =
                "\(greeting)\n\(name)"

            greetLabel.numberOfLines = 2

            greetLabel.font =
            UIFont.systemFont(
                ofSize: 20,
                weight: .bold
            )

            greetLabel.textColor = .white

            greetLabel.adjustsFontSizeToFitWidth = true

            greetLabel.minimumScaleFactor = 0.7

            greetLabel.lineBreakMode = .byWordWrapping

            boradLabel.text = "My Boards"

            boradLabel.font =
            UIFont.systemFont(
                ofSize: 24,
                weight: .bold
            )

            boradLabel.textColor =
            UIColor.white.withAlphaComponent(0.92)
        }
    }



    extension HomeViewController {

        func setupButton() {

            newBoardBtn.setTitle(
                "New Board",
                for: .normal
            )

            newBoardBtn.setTitleColor(
                .white,
                for: .normal
            )

            newBoardBtn.titleLabel?.font =
            UIFont.systemFont(
                ofSize: 13,
                weight: .bold
            )

            newBoardBtn.layer.cornerRadius = 18

            newBoardBtn.layer.cornerCurve = .continuous

            newBoardBtn.clipsToBounds = false

            newBoardBtn.contentEdgeInsets =
            UIEdgeInsets(
                top: 12,
                left: 18,
                bottom: 12,
                right: 18
            )

            buttonGradient.colors = [

                UIColor.systemBlue.cgColor,

                UIColor.systemPink.cgColor
            ]

            buttonGradient.startPoint =
            CGPoint(x: 0, y: 0)

            buttonGradient.endPoint =
            CGPoint(x: 1, y: 1)

            buttonGradient.cornerRadius = 18

            if buttonGradient.superlayer == nil {

                newBoardBtn.layer.insertSublayer(
                    buttonGradient,
                    at: 0
                )
            }

            newBoardBtn.layer.shadowColor =
            UIColor.systemPink.cgColor

            newBoardBtn.layer.shadowOpacity = 0.3

            newBoardBtn.layer.shadowRadius = 10

            newBoardBtn.layer.shadowOffset =
            CGSize(width: 0, height: 6)
        }
    }



    extension HomeViewController {

        func setupTableView() {

            tableView.delegate = self

            tableView.dataSource = self

            tableView.backgroundColor = .clear

            tableView.separatorStyle = .none

            tableView.showsVerticalScrollIndicator = false

            tableView.rowHeight = 105

            tableView.contentInset = UIEdgeInsets(
                top: 4,
                left: 0,
                bottom: 40,
                right: 0
            )
        }
    }



    extension HomeViewController {

        func setupTabBar() {

            guard let tabBar = tabBarController?.tabBar else {
                return
            }

            tabBar.backgroundColor =
            UIColor(
                red: 25/255,
                green: 25/255,
                blue: 38/255,
                alpha: 0.94
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

    

    extension HomeViewController {

        func animateScreen() {

            greetLabel.alpha = 0

            boradLabel.alpha = 0

            newBoardBtn.alpha = 0

            greetLabel.transform =
            CGAffineTransform(
                translationX: 0,
                y: -40
            )

            UIView.animate(
                withDuration: 1,
                delay: 0.1,
                usingSpringWithDamping: 0.82,
                initialSpringVelocity: 0.5
            ) {

                self.greetLabel.alpha = 1

                self.greetLabel.transform = .identity
            }

            UIView.animate(
                withDuration: 1,
                delay: 0.25
            ) {

                self.boradLabel.alpha = 1
            }

            UIView.animate(
                withDuration: 1,
                delay: 0.35
            ) {

                self.newBoardBtn.alpha = 1
            }
        }

        func animateTable() {

            tableView.visibleCells.forEach {

                $0.alpha = 0

                $0.transform =
                CGAffineTransform(
                    translationX: 0,
                    y: 50
                )
            }

            for (index, cell)
            in tableView.visibleCells.enumerated() {

                UIView.animate(
                    withDuration: 0.9,
                    delay: Double(index) * 0.08,
                    usingSpringWithDamping: 0.82,
                    initialSpringVelocity: 0.5
                ) {

                    cell.alpha = 1

                    cell.transform = .identity
                }
            }
        }
    }


    extension HomeViewController:
    UITableViewDelegate,
    UITableViewDataSource {

        func numberOfSections(
            in tableView: UITableView
        ) -> Int {

            return boardData.count
        }

        func tableView(
            _ tableView: UITableView,
            numberOfRowsInSection section: Int
        ) -> Int {

            return 1
        }

        func tableView(
            _ tableView: UITableView,
            heightForFooterInSection section: Int
        ) -> CGFloat {

            return 10
        }

        func tableView(
            _ tableView: UITableView,
            viewForFooterInSection section: Int
        ) -> UIView? {

            let view = UIView()

            view.backgroundColor = .clear

            return view
        }
        func tableView(
            _ tableView: UITableView,
            didSelectRowAt indexPath: IndexPath
        ) {

            selectedBoard =
            boardData[indexPath.section]

            performSegue(
                withIdentifier: "GoToBoardDetail",
                sender: self
            )
        }
        func tableView(
            _ tableView: UITableView,
            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
        ) -> UISwipeActionsConfiguration? {

            let deleteAction = UIContextualAction(
                style: .destructive,
                title: "Delete"
            ) { _, _, completion in

                let board =
                self.boardData[indexPath.section]

                // ALERT

                let alert = UIAlertController(
                    title: "Delete Board",
                    message: "Are you sure you want to delete this board?",
                    preferredStyle: .alert
                )

                let cancel = UIAlertAction(
                    title: "Cancel",
                    style: .cancel
                )

                let delete = UIAlertAction(
                    title: "Delete",
                    style: .destructive
                ) { _ in

                    let boardId = board.id

                    // DELETE FROM FIRESTORE

                    self.db.collection("boards")
                        .document(boardId)
                        .delete { error in

                        if let error = error {

                            print(
                                error.localizedDescription
                            )

                            return
                        }

                        // REMOVE LOCAL DATA

                        self.boardData.remove(
                            at: indexPath.section
                        )

                        // DELETE SECTION ANIMATION

                        tableView.deleteSections(
                            IndexSet(integer: indexPath.section),
                            with: .automatic
                        )

                        print("Board Deleted")
                    }
                }

                alert.addAction(cancel)

                alert.addAction(delete)

                self.present(
                    alert,
                    animated: true
                )

                completion(true)
            }

            deleteAction.image =
            UIImage(systemName: "trash.fill")

            deleteAction.backgroundColor =
            .systemRed

            let configuration =
            UISwipeActionsConfiguration(
                actions: [deleteAction]
            )

            configuration.performsFirstActionWithFullSwipe = true

            return configuration
        }

        func tableView(
            _ tableView: UITableView,
            cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell {

            let data =
            boardData[indexPath.section]

            let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "bcell",
                for: indexPath
            ) as! BoardTableViewCell

            cell.configure(
                title: data.title,
                privacy: data.privacy,
                membersCount: data.members.count,
                color: .systemPurple,
                icon: "folder.fill"
            )
            // INITIAL ANIMATION STATE

            cell.alpha = 0

            cell.transform =
            CGAffineTransform(
                translationX: 0,
                y: 40
            )

            // CARD SHADOW

            cell.layer.shadowColor =
            UIColor.black.cgColor

            cell.layer.shadowOpacity = 0.25

            cell.layer.shadowRadius = 12

            cell.layer.shadowOffset =
            CGSize(width: 0, height: 8)

            // RANDOM SLIGHT ROTATION EFFECT

            cell.transform =
            CGAffineTransform(
                rotationAngle: CGFloat.random(
                    in: -0.02...0.02
                )
            ).translatedBy(
                x: 0,
                y: 40
            )

            // ENTRY ANIMATION

            UIView.animate(
                withDuration: 0.8,
                delay: Double(indexPath.section) * 0.08,
                usingSpringWithDamping: 0.82,
                initialSpringVelocity: 0.6
            ) {

                cell.alpha = 1

                cell.transform = .identity
            }

            // CONTINUOUS FLOATING EFFECT

            UIView.animate(
                withDuration: 2,
                delay: Double(indexPath.section) * 0.2,
                options: [
                    .autoreverse,
                    .repeat,
                    .allowUserInteraction
                ]
            ) {

                cell.transform =
                CGAffineTransform(
                    translationX: 0,
                    y: -4
                )
            }

            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }

}
extension HomeViewController {


    func setupOverviewSection() {

        // OVERVIEW LABEL

        overviewLabel.translatesAutoresizingMaskIntoConstraints = false

        overviewLabel.text = "Overview"

        overviewLabel.font =
        UIFont.systemFont(
            ofSize: 24,
            weight: .bold
        )

        overviewLabel.textColor = .white

        view.addSubview(overviewLabel)

        NSLayoutConstraint.activate([

            overviewLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            overviewLabel.topAnchor.constraint(
                equalTo: greetLabel.bottomAnchor,
                constant: 28
            )
        ])

        // STACK

        statsStack.translatesAutoresizingMaskIntoConstraints = false

        statsStack.axis = .horizontal

        statsStack.distribution = .fillEqually

        statsStack.spacing = 14

        view.addSubview(statsStack)

        NSLayoutConstraint.activate([

            statsStack.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 20
            ),

            statsStack.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -20
            ),

            statsStack.topAnchor.constraint(
                equalTo: overviewLabel.bottomAnchor,
                constant: 18
            ),

            statsStack.heightAnchor.constraint(
                equalToConstant: 110
            )
        ])

        // CREATE REAL FIREBASE CARDS

        tasksCard = createStatCard(
            title: "Tasks",
            value: "0",
            icon: "checkmark.circle.fill",
            color: .systemPink
        )

        boardsCard = createStatCard(
            title: "Boards",
            value: "0",
            icon: "square.grid.2x2.fill",
            color: .systemBlue
        )

        progressCard = createStatCard(
            title: "Progress",
            value: "0%",
            icon: "chart.line.uptrend.xyaxis",
            color: .systemPurple
        )

        statsStack.addArrangedSubview(tasksCard)

        statsStack.addArrangedSubview(boardsCard)

        statsStack.addArrangedSubview(progressCard)

        // MOVE EXISTING UI DOWN

        boradLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            boradLabel.topAnchor.constraint(
                equalTo: statsStack.bottomAnchor,
                constant: 28
            )
        ])
    }


    func createStatCard(
        title: String,
        value: String,
        icon: String,
        color: UIColor
    ) -> UIView {

        let card = UIView()

        card.backgroundColor =
        UIColor.white.withAlphaComponent(0.06)

        card.layer.cornerRadius = 26

        card.layer.cornerCurve = .continuous

        card.layer.borderWidth = 1

        card.layer.borderColor =
        UIColor.white.withAlphaComponent(0.06).cgColor

        card.layer.shadowColor =
        color.cgColor

        card.layer.shadowOpacity = 0.18

        card.layer.shadowRadius = 14

        card.layer.shadowOffset =
        CGSize(width: 0, height: 8)

        // ICON

        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.image =
        UIImage(systemName: icon)

        imageView.tintColor = color

        // VALUE LABEL

        let valueLabel = UILabel()

        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        valueLabel.text = value

        valueLabel.tag = 100

        valueLabel.font =
        UIFont.systemFont(
            ofSize: 28,
            weight: .black
        )

        valueLabel.textColor = .white

        // TITLE

        let titleLabel = UILabel()

        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = title

        titleLabel.font =
        UIFont.systemFont(
            ofSize: 13,
            weight: .medium
        )

        titleLabel.textColor =
        UIColor.white.withAlphaComponent(0.65)

        card.addSubview(imageView)

        card.addSubview(valueLabel)

        card.addSubview(titleLabel)

        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(
                equalTo: card.topAnchor,
                constant: 16
            ),

            imageView.leadingAnchor.constraint(
                equalTo: card.leadingAnchor,
                constant: 16
            ),

            imageView.widthAnchor.constraint(
                equalToConstant: 22
            ),

            imageView.heightAnchor.constraint(
                equalToConstant: 22
            ),

            valueLabel.leadingAnchor.constraint(
                equalTo: card.leadingAnchor,
                constant: 16
            ),

            valueLabel.centerYAnchor.constraint(
                equalTo: card.centerYAnchor
            ),

            titleLabel.leadingAnchor.constraint(
                equalTo: card.leadingAnchor,
                constant: 16
            ),

            titleLabel.bottomAnchor.constraint(
                equalTo: card.bottomAnchor,
                constant: -14
            )
        ])

        return card
    }


    func fetchDashboardStats() {

        guard let currentEmail =
                Auth.auth().currentUser?.email
        else {
            return
        }

        db.collection("boards")
            .addSnapshotListener { snapshot, error in

            if let error = error {

                print(error.localizedDescription)
                return
            }

            guard let documents =
                    snapshot?.documents
            else {
                return
            }

            let userBoards = documents.filter {

                let data = $0.data()

                let privacy =
                data["privacy"] as? String ?? ""

                let members =
                data["members"] as? [String] ?? []

                if privacy == "Public" {
                    return true
                }

                return members.contains(currentEmail)
            }

            // UPDATE BOARDS CARD

            self.updateBoardsCard(
                count: userBoards.count
            )

            // TEMP VALUES

            var tempTotalTasks = 0
            var tempCompletedTasks = 0

            let group = DispatchGroup()

            for board in userBoards {

                group.enter()

                self.db.collection("boards")
                    .document(board.documentID)
                    .collection("tasks")
                    .getDocuments { snapshot, error in

                    let tasks =
                    snapshot?.documents ?? []

                    tempTotalTasks += tasks.count

                    for task in tasks {

                        let data = task.data()

                        let status =
                        data["status"] as? String ?? ""

                        if status.lowercased() == "done" {

                            tempCompletedTasks += 1
                        }
                    }

                    group.leave()
                }
            }

            group.notify(queue: .main) {

                self.totalTasks =
                tempTotalTasks

                self.completedTasks =
                tempCompletedTasks

                self.updateTaskCard(
                    count: tempTotalTasks
                )

                let progress =
                tempTotalTasks == 0
                ? 0
                : Int(
                    (
                        Double(tempCompletedTasks)
                        /
                        Double(tempTotalTasks)
                    ) * 100
                )

                self.updateProgressCard(
                    progress: progress
                )
            }
        }
    }
    


    func updateTaskCard(count: Int) {

        updateCardValue(
            in: tasksCard,
            value: "\(count)"
        )
    }

    func updateBoardsCard(count: Int) {

        updateCardValue(
            in: boardsCard,
            value: "\(count)"
        )
    }

    func updateProgressCard(progress: Int) {

        updateCardValue(
            in: progressCard,
            value: "\(progress)%"
        )
    }


    func updateCardValue(
        in card: UIView,
        value: String
    ) {

        if let label =
            card.viewWithTag(100)
            as? UILabel {

            label.text = value
        }
    }
}

