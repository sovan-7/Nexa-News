

import Foundation

@testable import NewsApp
final class MockUserDefaultsManager : UserDefaultsManaging {
    private(set) var userName: String?
        private(set) var userEmail: String?
        private(set) var isLoggedIn: Bool = false
        private(set) var isDarkMode: Bool = false
        private(set) var clearUserDataCallCount = 0
    
    func setUserName(_ name: String) {
        userName = name
    }
    func getUserName() -> String? {
        return userName
    }
    func setUserEmail(_ email: String) {
            userEmail = email
    }
    func getUserEmail() -> String? {
            return userEmail
    }
    func setIsLoggedIn(_ isLoggedIn: Bool) {
        self.isLoggedIn = isLoggedIn
    }
    func getIsLoggedIn() -> Bool {
        return isLoggedIn
    }
        func setThemeMode(_ isDark: Bool) {
            isDarkMode = isDark
        }
    func getThemeMode() -> Bool {
       return isDarkMode
    }
    func clearUserData() {
        clearUserDataCallCount += 1
        userName = nil
        userEmail = nil
        isLoggedIn = false
    }
}
