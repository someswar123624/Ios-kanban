//
//  SceneDelegate.swift
//  caption
//
//  Created by Yalakaturi Someshwar Naidu on 07/05/26.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?




    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
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

        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        window = UIWindow(windowScene: windowScene)

        let storyboard = UIStoryboard(
            name: "Main",
            bundle: nil
        )

        
        // CHECK FIREBASE SESSION
        if Auth.auth().currentUser != nil {

            let homeVC =
            storyboard.instantiateViewController(
                withIdentifier: "MainTabBar"
            )

            window?.rootViewController = homeVC

        } else {

            let loginVC =
            storyboard.instantiateViewController(
                withIdentifier: "LoginViewController"
            )

            window?.rootViewController = loginVC
        }

        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

