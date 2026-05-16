//
//  SearchViewController.swift
//  caption
//
//  Created by Yalakaturi Someshwar Naidu on 10/05/26.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SearchViewController:
    UIViewController {
    var selectedBoard: Board?
    
    let db = Firestore.firestore()
    
    var boards: [Board] = []
    
    var tasks: [Task] = []
    
    var items: [SearchItem] = []
    
    var filteredItems: [SearchItem] = []
    
    let titleLabel = UILabel()
    
    let searchBar = UISearchBar()
    
    var collectionView: UICollectionView!
    
    let tableView = UITableView()
    
    let filters = [
        "All",
        "Boards",
        "Tasks",
        "Todo",
        "Doing",
        "Done"
    ]
    
    var selectedFilter = "All"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupUI()
        setupTabBar()
        
        
        setupTableView()
        
        fetchBoards()
        
        fetchTasks()
    }
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        
        if segue.identifier ==
            "GoToBoardDetailFromSearch" {
            
            let vc =
            segue.destination
            as! BoardDetailViewController
            
            vc.board = selectedBoard
        }
    }
}


extension SearchViewController {

    func setupUI() {

        view.backgroundColor =
        UIColor(
            red: 10/255,
            green: 10/255,
            blue: 25/255,
            alpha: 1
        )

        titleLabel.translatesAutoresizingMaskIntoConstraints =
        false

        titleLabel.text = "Search"

        titleLabel.font =
        .systemFont(
            ofSize: 38,
            weight: .heavy
        )

        titleLabel.textColor = .white

        view.addSubview(titleLabel)

        searchBar.translatesAutoresizingMaskIntoConstraints =
        false

        searchBar.searchBarStyle = .minimal

        searchBar.placeholder =
        "Search boards, tasks..."

        searchBar.delegate = self

        searchBar.tintColor = .systemPink

        view.addSubview(searchBar)
        view.addSubview(collectionView)
        

        tableView.translatesAutoresizingMaskIntoConstraints =
        false

        tableView.backgroundColor = .clear

        tableView.separatorStyle = .none

        view.addSubview(tableView)

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(
                equalTo:
                view.safeAreaLayoutGuide.topAnchor,
                constant: 12
            ),

            titleLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 24
            ),

            searchBar.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: 18
            ),

            searchBar.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),

            searchBar.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
            collectionView.topAnchor.constraint(
                equalTo: searchBar.bottomAnchor,
                constant: 14
            ),

            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),

            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            collectionView.heightAnchor.constraint(
                equalToConstant: 50
            ),

            tableView.topAnchor.constraint(
                equalTo: collectionView.bottomAnchor,
                constant: 12
            ),

            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            
        ])
    }
}


extension SearchViewController {

    func setupCollectionView() {

        let layout =
        UICollectionViewFlowLayout()

        layout.scrollDirection = .horizontal

        layout.minimumLineSpacing = 12

        collectionView =
        UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collectionView.translatesAutoresizingMaskIntoConstraints =
        false

        collectionView.backgroundColor = .clear

        collectionView.showsHorizontalScrollIndicator =
        false

        collectionView.delegate = self

        collectionView.dataSource = self

        collectionView.register(
            FilterChipCell.self,
            forCellWithReuseIdentifier:
            FilterChipCell.identifier
        )
    }
}


extension SearchViewController:
UITableViewDelegate,
UITableViewDataSource {

    func setupTableView() {

        tableView.delegate = self

        tableView.dataSource = self

        tableView.register(
            SearchResultCell.self,
            forCellReuseIdentifier:
            SearchResultCell.identifier
        )
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {

        return filteredItems.count
    }
    

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell =
        tableView.dequeueReusableCell(
            withIdentifier:
            SearchResultCell.identifier,
            for: indexPath
        ) as! SearchResultCell

        let item =
        filteredItems[indexPath.row]

        cell.configure(item: item)

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {

        return 140
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {

        tableView.deselectRow(
            at: indexPath,
            animated: true
        )

        let item =
        filteredItems[indexPath.row]

        if item.type == "Boards" {

            if let board =
                boards.first(where: {

                    $0.id == item.id
                }) {

                selectedBoard = board

                performSegue(
                    withIdentifier:
                    "GoToBoardDetailFromSearch",
                    sender: nil
                )
            }
        }
    }
    
}


extension SearchViewController:
UISearchBarDelegate {

    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {

        filterData(
            searchText: searchText
        )
    }

    func filterData(
        searchText: String = ""
    ) {

        let text =
        searchText.lowercased()

        filteredItems =
        items.filter {

            let matchesSearch =

            text.isEmpty
            ||
            $0.title.lowercased().contains(text)
            ||
            $0.subtitle.lowercased().contains(text)
            ||
            $0.status.lowercased().contains(text)

            let matchesFilter =

            selectedFilter == "All"
            ||
            $0.type.lowercased() ==
            selectedFilter.lowercased()
            ||
            $0.status.lowercased() ==
            selectedFilter.lowercased()

            return
            matchesSearch
            &&
            matchesFilter
        }

        tableView.reloadData()
    }
}


extension SearchViewController:
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        return filters.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell =
        collectionView.dequeueReusableCell(
            withReuseIdentifier:
            FilterChipCell.identifier,
            for: indexPath
        ) as! FilterChipCell

        let filter =
        filters[indexPath.item]

        cell.configure(
            title: filter,
            isSelected:
            selectedFilter == filter
        )

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {

        selectedFilter =
        filters[indexPath.item]

        collectionView.reloadData()

        filterData(
            searchText:
            searchBar.text ?? ""
        )
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout:
        UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        return CGSize(
            width: 90,
            height: 36
        )
    }
}

extension SearchViewController {

    func fetchBoards() {

        guard let email =
        Auth.auth().currentUser?.email else {
            return
        }

        db.collection("boards")
            .whereField(
                "members",
                arrayContains: email
            )
            .getDocuments { snapshot, error in

                if let documents =
                    snapshot?.documents {

                    self.boards =
                    documents.map {

                        Board(
                            data: $0.data()
                        )
                    }

                    self.reloadSearchItems()
                }
            }
    }

    func fetchTasks() {

        guard let email =
        Auth.auth().currentUser?.email else {
            return
        }

        db.collection("tasks")
            .whereField(
                "assignedTo",
                isEqualTo: email
            )
            .getDocuments { snapshot, error in

                if let documents =
                    snapshot?.documents {

                    self.tasks =
                    documents.map {

                        Task(
                            data: $0.data()
                        )
                    }

                    self.reloadSearchItems()
                }
            }
    }
}


extension SearchViewController {

    func reloadSearchItems() {

        items.removeAll()

        let boardItems =
        boards.map {

            SearchItem(

                id: $0.id,

                title: $0.title,

                subtitle:
                "\($0.members.count) Members",

                type: "Boards",

                status: $0.privacy,

                assignedTo: ""
            )
        }

        let taskItems =
        tasks.map {

            SearchItem(

                id: $0.id,

                title: $0.title,

                subtitle: $0.description,

                type: "Tasks",

                status: $0.status,

                assignedTo: $0.assignedTo
            )
        }

        items.append(contentsOf: boardItems)

        items.append(contentsOf: taskItems)

        filteredItems = items

        tableView.reloadData()
    }
}
extension SearchViewController {

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
