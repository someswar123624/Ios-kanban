//
//  ViewController.swift
//  caption
//
//  Created by Yalakaturi Someshwar Naidu on 07/05/26.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseCore


class ViewController: UIViewController {
    
    @IBOutlet weak var GoogleImage: UIImageView!
    
    @IBOutlet weak var appleImage: UIImageView!
    
    @IBOutlet weak var facebookImage: UIImageView!
    
    @IBOutlet weak var passView: UIView!
    
    @IBOutlet weak var CardView: UIView!
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var emailOutlet: UITextField!
    
    @IBOutlet weak var passOutlet: UITextField!
    
    @IBOutlet weak var forgotLabel: UILabel!
    
    
    @IBOutlet weak var loginBtn: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        startAnimations()
        GoogleImage.isUserInteractionEnabled = true

            let tap = UITapGestureRecognizer(
                target: self,
                action: #selector(handleGoogleLogin)
            )

            GoogleImage.addGestureRecognizer(tap)
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        if Auth.auth().currentUser != nil {
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let homeVC = storyboard.instantiateViewController(
//                withIdentifier: "HomeViewController"
//            )
//
//            if let sceneDelegate =
//                UIApplication.shared.connectedScenes.first?.delegate
//                as? SceneDelegate {
//
//                sceneDelegate.window?.rootViewController = homeVC
//                sceneDelegate.window?.makeKeyAndVisible()
//            }
//        }
////        floatingAnimation()
//    }
    func floatingAnimation() {

        UIView.animate(
            withDuration: 2,
            delay: 0,
            options: [.autoreverse, .repeat],
            animations: {

                self.CardView.transform =
                CGAffineTransform(
                    translationX: 0,
                    y: -10
                )
            }
        )
    }
    func setupUI() {
        
        
        view.backgroundColor = UIColor(
            red: 240/255,
            green: 238/255,
            blue: 250/255,
            alpha: 1
        )

        
        CardView.backgroundColor = .white
        CardView.layer.cornerRadius = 30
        
        CardView.layer.shadowColor = UIColor.black.cgColor
        CardView.layer.shadowOpacity = 0.08
        CardView.layer.shadowOffset = CGSize(width: 0, height: 8)
        CardView.layer.shadowRadius = 20
        
        emailView.backgroundColor = .clear
        
        emailView.layer.cornerRadius = 0
        emailView.layer.borderWidth = 0
        
        // Bottom line only
        let emailLine = CALayer()
        emailLine.frame = CGRect(
            x: 0,
            y: emailView.frame.height - 1,
            width: emailView.frame.width,
            height: 1
        )
        
        emailLine.backgroundColor = UIColor.lightGray.cgColor
        emailView.layer.addSublayer(emailLine)

        
        passView.backgroundColor = .clear
        
        passView.layer.cornerRadius = 0
        passView.layer.borderWidth = 0
        
        // Bottom line only
        let passLine = CALayer()
        passLine.frame = CGRect(
            x: 0,
            y: passView.frame.height - 1,
            width: passView.frame.width,
            height: 1
        )
        
        passLine.backgroundColor = UIColor.lightGray.cgColor
        passView.layer.addSublayer(passLine)
 
        
        emailOutlet.borderStyle = .none
        passOutlet.borderStyle = .none
        
        emailOutlet.backgroundColor = .clear
        passOutlet.backgroundColor = .clear
        
        emailOutlet.placeholder = "your.email@example.com"
        passOutlet.placeholder = "Password"

        loginBtn.layer.cornerRadius = 14
        loginBtn.clipsToBounds = true
        
        
        let gradient = CAGradientLayer()
        gradient.frame = loginBtn.bounds
        
        gradient.colors = [
            UIColor.systemBlue.cgColor,
            UIColor.systemPurple.cgColor
        ]
        
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        
        loginBtn.layer.insertSublayer(gradient, at: 0)

        socialStyle(GoogleImage)
        socialStyle(appleImage)
        socialStyle(facebookImage)

        
        forgotLabel.textColor = .systemPurple
        
        UIView.animate(
            withDuration: 0.8,
            delay: 0.1,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5
        ) {

            self.CardView.alpha = 1
            self.CardView.transform = .identity
        }

        
    }

    
    func socialStyle(_ imageView: UIImageView) {
        
        imageView.backgroundColor = .white
        
        imageView.layer.cornerRadius = 16
        
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.08
        imageView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imageView.layer.shadowRadius = 8
        
        imageView.clipsToBounds = false
    }
    func startAnimations() {

       

        CardView.alpha = 0
        CardView.transform = CGAffineTransform(
            translationX: 0,
            y: 80
        )

//        emailView.alpha = 0
//        passView.alpha = 0
//
//        loginBtn.alpha = 0
//        loginBtn.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
//
//        GoogleImage.alpha = 0
//        appleImage.alpha = 0
//        facebookImage.alpha = 0
//
//        GoogleImage.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
//        appleImage.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
//        facebookImage.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)

     

        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5
        ) {

            self.CardView.alpha = 1
            self.CardView.transform = .identity
        }

        

        UIView.animate(
            withDuration: 0.5,
            delay: 0.3
        ) {

            self.emailView.alpha = 1
        }

        

        UIView.animate(
            withDuration: 0.5,
            delay: 0.5
        ) {

            self.passView.alpha = 1
        }

       

        UIView.animate(
            withDuration: 0.6,
            delay: 0.7,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 1
        ) {

            self.loginBtn.alpha = 1
            self.loginBtn.transform = .identity
        }

        

        animateSocialIcon(
            image: GoogleImage,
            delay: 0.9
        )

        animateSocialIcon(
            image: appleImage,
            delay: 1.0
        )

        animateSocialIcon(
            image: facebookImage,
            delay: 1.1
        )
    }
    func animateSocialIcon(
        image: UIImageView,
        delay: Double
    ) {

        UIView.animate(
            withDuration: 0.6,
            delay: delay,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 1
        ) {

            image.alpha = 1
            image.transform = .identity
        }
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {

        guard let email = emailOutlet.text,
              let password = passOutlet.text else {
            return
        }

        if email.isEmpty || password.isEmpty {

            showAlert(message: "Please fill all fields")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) {
            authResult, error in

            if let error = error {

                self.showAlert(message: error.localizedDescription)
                return
            }

            print("Login Success")

            
            let storyboard = UIStoryboard(
                name: "Main",
                bundle: nil
            )

            let homeVC =
            storyboard.instantiateViewController(
                withIdentifier: "MainTabBar"
            )

            
            if let sceneDelegate =
                UIApplication.shared.connectedScenes.first?.delegate
                as? SceneDelegate {

                sceneDelegate.window?.rootViewController = homeVC

                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    func showAlert(message: String) {

        let alert = UIAlertController(
            title: "Alert",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default
            )
        )

        present(alert, animated: true)
    }
    
    
    @IBAction func signupBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let homeVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController")
        
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            
            sceneDelegate.window?.rootViewController = homeVC
            sceneDelegate.window?.makeKeyAndVisible()
            
        }
    }
    @objc func handleGoogleLogin() {

        guard let clientID =
            FirebaseApp.app()?.options.clientID
        else {
            return
        }

        let config = GIDConfiguration(
            clientID: clientID
        )

        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(
            withPresenting: self
        ) { result, error in

            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard
                let user = result?.user,
                let idToken = user.idToken?.tokenString
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )

            Auth.auth().signIn(with: credential) {
                authResult,
                error in

                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                print("Google Login Success")

                UserDefaults.standard.set(
                    true,
                    forKey: "isLoggedIn"
                )

                let vc = self.storyboard?
                    .instantiateViewController(
                        withIdentifier: "MainTabBar"
                    )

                vc?.modalPresentationStyle = .fullScreen

                self.present(vc!, animated: true)
            }
        }
    }
    
}
