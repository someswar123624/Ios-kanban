//
//  SignUpViewController.swift
//  caption
//
//  Created by Yalakaturi Someshwar Naidu on 09/05/26.
//

import UIKit
import FirebaseAuth
import CoreData
import FirebaseCore
import GoogleSignIn

class SignUpViewController: UIViewController {

    
    @IBOutlet weak var googleLogo: UIImageView!
    
    @IBOutlet weak var appleLogo: UIImageView!
    
    @IBOutlet weak var facebookLogo: UIImageView!
    
    @IBOutlet weak var userNameView: UIView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var cardView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        googleLogo.isUserInteractionEnabled = true

            let tap = UITapGestureRecognizer(
                target: self,
                action: #selector(handleGoogleLogin)
            )

        googleLogo.addGestureRecognizer(tap)
    }
   

        func setupUI() {

            // Background Color
            view.backgroundColor = UIColor(
                red: 243/255,
                green: 240/255,
                blue: 252/255,
                alpha: 1
            )


            cardView.backgroundColor = .white

            cardView.layer.cornerRadius = 35

            cardView.layer.shadowColor = UIColor.black.cgColor
            cardView.layer.shadowOpacity = 0.08
            cardView.layer.shadowOffset = CGSize(width: 0, height: 10)
            cardView.layer.shadowRadius = 25


            setupField(
                view: userNameView,
                textField: userNameTextField,
                placeholder: "User Name",
                icon: "person.fill"
            )

            setupField(
                view: emailView,
                textField: EmailTextField,
                placeholder: "Email Address",
                icon: "envelope.fill"
            )

            setupField(
                view: passwordView,
                textField: passwordTextField,
                placeholder: "Password",
                icon: "lock.fill",
                isSecure: true
            )

            



            socialStyle(googleLogo)
            socialStyle(appleLogo)
            socialStyle(facebookLogo)

            cardView.alpha = 0
            cardView.transform = CGAffineTransform(
                translationX: 0,
                y: 40
            )

            UIView.animate(
                withDuration: 0.8,
                delay: 0.1,
                usingSpringWithDamping: 0.7,
                initialSpringVelocity: 0.5
            ) {

                self.cardView.alpha = 1
                self.cardView.transform = .identity
            }
        }

        func setupField(
            view: UIView,
            textField: UITextField,
            placeholder: String,
            icon: String,
            isSecure: Bool = false
        ) {

            
            textField.borderStyle = .none

            
            textField.placeholder = placeholder

            
            textField.isSecureTextEntry = isSecure

            
            textField.font = UIFont.systemFont(
                ofSize: 16,
                weight: .medium
            )

            
            textField.textColor = .black

            
            let bottomLine = CALayer()

            bottomLine.frame = CGRect(
                x: 0,
                y: view.frame.height - 1,
                width: view.frame.width,
                height: 1
            )

            bottomLine.backgroundColor =
            UIColor.lightGray.withAlphaComponent(0.3).cgColor

            view.layer.addSublayer(bottomLine)

            
            let imageView = UIImageView(
                frame: CGRect(x: 0, y: 0, width: 22, height: 22)
            )

            imageView.image = UIImage(
                systemName: icon
            )

            imageView.tintColor = UIColor.systemPurple

            imageView.contentMode = .scaleAspectFit

            let leftView = UIView(
                frame: CGRect(x: 0, y: 0, width: 35, height: 22)
            )

            leftView.addSubview(imageView)

            textField.leftView = leftView
            textField.leftViewMode = .always

            
            if isSecure {

                let eyeButton = UIButton(
                    type: .custom
                )

                eyeButton.frame = CGRect(
                    x: 0,
                    y: 0,
                    width: 25,
                    height: 25
                )

                eyeButton.setImage(
                    UIImage(systemName: "eye"),
                    for: .normal
                )

                eyeButton.tintColor = .gray

                textField.rightView = eyeButton
                textField.rightViewMode = .always
            }
        }

        func socialStyle(_ imageView: UIImageView) {

            imageView.backgroundColor = .white

            imageView.layer.cornerRadius = 18

            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOpacity = 0.08
            imageView.layer.shadowOffset = CGSize(width: 0, height: 5)
            imageView.layer.shadowRadius = 10

            imageView.clipsToBounds = false
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

    

    @IBAction func signUpBtn(_ sender: UIButton) {
        
        guard let username = userNameTextField.text,
              let email = EmailTextField.text,
              let password = passwordTextField.text else {
            return
        }

        // Empty Validation
        if username.isEmpty ||
            email.isEmpty ||
            password.isEmpty {

            showAlert(message: "Please fill all fields")
            return
        }

        // Password Validation
        if password.count < 6 {

            showAlert(message: "Password must be at least 6 characters")
            return
        }

        // Firebase Signup
        Auth.auth().createUser(withEmail: email, password: password) {
            authResult, error in

            if let error = error {

                print("FULL ERROR =>", error)

                self.showAlert(message: error.localizedDescription)

                return
            }

            // Save Username
            let changeRequest =
            Auth.auth().currentUser?.createProfileChangeRequest()

            changeRequest?.displayName = username

            changeRequest?.commitChanges { error in

                if let error = error {

                    self.showAlert(message: error.localizedDescription)
                    return
                }

                print("Signup Success")
                
                


                let storyboard = UIStoryboard(
                    name: "Main",
                    bundle: nil
                )

                let homeVC =
                storyboard.instantiateViewController(
                    withIdentifier: "LoginViewController"
                )

                if let sceneDelegate =
                    UIApplication.shared.connectedScenes.first?.delegate
                    as? SceneDelegate {

                    sceneDelegate.window?.rootViewController = homeVC
                    sceneDelegate.window?.makeKeyAndVisible()
                }
            }
        }
    }

    
    @IBAction func loginBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let homeVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        
       
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

