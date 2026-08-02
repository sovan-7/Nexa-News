import Testing
@testable import NewsApp
@MainActor
struct LoginViewModelTests {
    
    @Test func checkCurrentUserNull() async throws {
        let mockUserDefaultsManager = MockUserDefaultsManager()
        let loginViewModel=LoginViewModel(userDefaultsManager: mockUserDefaultsManager)
        #expect(loginViewModel.currentUser == nil)
    }
    
    @Test
    func login() async throws{
        let mockUserDefaultsManager = MockUserDefaultsManager()
        let loginViewModel=LoginViewModel(userDefaultsManager: mockUserDefaultsManager)
        let user = User(name: "Sovan", email: "sovan@example.com")

        loginViewModel.login(user:user)
        #expect(loginViewModel.currentUser?.name == "Sovan")
    }
    
    @Test func logout() async throws {
        let mockUserDefaultsManager = MockUserDefaultsManager()
        let loginViewModel=LoginViewModel(userDefaultsManager: mockUserDefaultsManager)
        loginViewModel.logout()
        #expect(loginViewModel.currentUser == nil)
    }
    
}
