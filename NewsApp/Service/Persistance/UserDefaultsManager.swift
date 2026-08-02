import Foundation

protocol UserDefaultsManaging {
    func setUserName(_ name: String)
    func getUserName() -> String?
    func setUserEmail(_ email: String)
    func getUserEmail() -> String?
    func setIsLoggedIn(_ isLoggedIn: Bool)
    func getIsLoggedIn() -> Bool
    func setThemeMode(_ isDark: Bool)
    func getThemeMode() -> Bool
    func clearUserData()
}

final class UserDefaultsManager: UserDefaultsManaging {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    private init() {}

    func setUserName(_ name: String) {
        defaults.set(name, forKey: UserDefaultsKeys.username)
    }

    func getUserName() -> String? {
        return defaults.string(forKey: UserDefaultsKeys.username)
    }

    func setUserEmail(_ email: String) {
        defaults.set(email, forKey: UserDefaultsKeys.userEmail)
    }

    func getUserEmail() -> String? {
        return defaults.string(forKey: UserDefaultsKeys.userEmail)
    }

    func setIsLoggedIn(_ isLoggedIn: Bool) {
        defaults.set(isLoggedIn, forKey: UserDefaultsKeys.isLoggedIn)
    }

    func getIsLoggedIn() -> Bool {
        return defaults.bool(forKey: UserDefaultsKeys.isLoggedIn)
    }

    func setThemeMode(_ isDark: Bool) {
        defaults.set(isDark, forKey: UserDefaultsKeys.themeMode)
    }

    func getThemeMode() -> Bool {
        return defaults.bool(forKey: UserDefaultsKeys.themeMode)
    }

    func clearUserData() {
        defaults.removeObject(forKey: UserDefaultsKeys.username)
        defaults.removeObject(forKey: UserDefaultsKeys.userEmail)
        setIsLoggedIn(false)
    }
}
