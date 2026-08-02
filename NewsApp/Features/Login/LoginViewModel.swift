import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var currentUser: User?
    private let userDefaultsManager: UserDefaultsManaging
    init( userDefaultsManager: UserDefaultsManaging? = nil) {
        self.userDefaultsManager =  userDefaultsManager ?? UserDefaultsManager.shared
    }
    func login(user: User) {
        currentUser = user
        userDefaultsManager.setIsLoggedIn(true)
        if let name = currentUser?.name {
            userDefaultsManager.setUserName(name)
        }
        if let email = currentUser?.email {
            userDefaultsManager.setUserEmail(email)
        }
    }
    
    func logout() {
        currentUser = nil
        userDefaultsManager.clearUserData()
    }
}
