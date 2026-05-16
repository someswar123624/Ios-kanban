# Caption – Kanban Productivity iOS App

Caption is a modern iOS productivity application built using Swift and UIKit that helps users organize tasks using a Kanban workflow system.  
The app allows users to create boards, manage tasks, search tasks, and improve productivity through a clean and interactive user experience.

---

# Features

## Authentication
- User Login
- User Signup
- Firebase Integration
- Google Sign-In Support

## Kanban Board Management
- Create Boards
- View Board Details
- Organize Tasks
- Task Categorization

## Task Management
- Add Tasks
- Update Task Status
- Delete Tasks
- Bottom Sheet Task Creation UI

## Search Functionality
- Search Boards
- Search Tasks
- Real-time Filtering

## Notifications
- Notification Screen
- Notification Models
- Custom Notification Cells

## Profile Management
- User Profile Screen
- About App Section
- Profile TableView Cells

## Data Persistence
- CoreData Integration
- Local Storage Support

## UI Components
- Custom TableView Cells
- CollectionView Filter Chips
- Smooth UIKit Navigation
- Responsive Layout Design

---

# Project Structure

```bash
caption/
│
├── AppDelegate.swift
├── ViewController.swift
├── HomeViewController.swift
├── SearchViewController.swift
├── profileViewController.swift
├── AboutAppViewController.swift
├── SignUpViewController.swift
│
├── Board.swift
├── NotificationModel.swift
├── SearchItem.swift
│
├── CoreDataManager.swift
│
├── CreateBoardViewController.swift
├── BoardDetailViewController.swift
├── AddTaskBottomSheetViewController.swift
│
├── NotificationCell.swift
├── SearchResultcell.swift
├── FilterChipCell.swift
├── profileTableViewCell.swift
│
├── Assets.xcassets
├── Base.lproj
├── caption.xcdatamodeld
└── GoogleService-Info.plist
```

---

# Tech Stack

- Swift
- UIKit
- CoreData
- Firebase Authentication
- Google Sign In
- Xcode
- MVC Architecture

---

# Screenshots

## Home Screen
(Add Screenshot)

## Board Screen
(Add Screenshot)

## Search Screen
(Add Screenshot)

## Profile Screen
(Add Screenshot)

---

# Firebase Setup

1. Create a Firebase Project
2. Enable Authentication
3. Enable Google Sign-In
4. Download `GoogleService-Info.plist`
5. Add the file to the Xcode project
6. Run the application

---

# Installation

## Clone Repository

```bash
git clone https://github.com/someswar123624/caption-kanban-ios.git
```

## Open Project

```bash
cd caption-kanban-ios
open caption.xcodeproj
```

## Run Project

- Open in Xcode
- Select Simulator
- Press `Cmd + R`

---

# Requirements

- iOS 16+
- Xcode 16+
- Swift 5+

---

# Learning Outcomes

This project helped me improve my understanding of:

- UIKit Development
- Navigation Controllers
- TableView & CollectionView
- Firebase Authentication
- CoreData Persistence
- MVC Architecture
- Search Functionality
- Custom UI Components
- Git & GitHub Workflow

---

# Future Improvements

- Dark Mode Support
- Drag & Drop Kanban Cards
- Push Notifications
- Cloud Sync
- AI Task Suggestions
- Team Collaboration
- Calendar Integration
- SwiftUI Migration

---

# GitHub Commands

```bash
git init
git add .
git commit -m "Initial Commit"
git branch -M main
git remote add origin https://github.com/someswar123624/caption-kanban-ios.git
git push -u origin main
```

---

# Author

## Yalakaturi Someswar Naidu

- iOS Developer
- Full Stack Developer
- AI Enthusiast

### GitHub
:contentReference[oaicite:0]{index=0}

---

# License

This project is developed for educational and portfolio purposes.
