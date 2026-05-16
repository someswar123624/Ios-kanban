import UIKit
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // SAVE USER
    func saveUser(username: String, email: String) {

        let user = User(context: context)

        user.username = username
        user.email = email
        user.isLoggedIn = true

        do {
            try context.save()
            print("User Saved")
        } catch {
            print("Error Saving User")
        }
    }

    // FETCH USER
    func fetchUser() -> User? {

        let request: NSFetchRequest<User> = User.fetchRequest()

        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print("Fetch Error")
        }

        return nil
    }

    // UPDATE USER
    func updateUser(username: String, email: String) {

        let request: NSFetchRequest<User> = User.fetchRequest()

        do {
            let users = try context.fetch(request)

            if let user = users.first {

                user.username = username
                user.email = email

                try context.save()

                print("Updated")
            }

        } catch {
            print("Update Error")
        }
    }

    // LOGOUT
    func logoutUser() {

        let request: NSFetchRequest<User> = User.fetchRequest()

        do {
            let users = try context.fetch(request)

            if let user = users.first {

                user.isLoggedIn = false

                try context.save()
            }

        } catch {
            print("Logout Error")
        }
    }
//    @IBAction func updateButtonTapped(_ sender: UIButton) {
//
//        let updatedUsername = usernameTextField.text ?? ""
//        let updatedEmail = emailTextField.text ?? ""
//
//        CoreDataManager.shared.updateUser(
//            username: updatedUsername,
//            email: updatedEmail
//        )
//    }
}
