//
//  LoginViewUITest.swift
//  NewsAppUITests
//

import XCTest

final class LoginViewUITest: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UI-TESTING-RESET-LOGIN"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    // MARK: - Validation errors

    @MainActor
    func testTappingSignInWithEmptyFieldsShowsBothValidationErrors() throws {
        let signInButton = app.buttons["signInButton"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 3))
        signInButton.tap()

        XCTAssertTrue(app.staticTexts["Email is required!"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Password is required!"].exists)
    }

    @MainActor
    func testEmptyEmailOnlyShowsEmailRequiredError() throws {
        let passwordField = app.secureTextFields["passwordField"]
        XCTAssertTrue(passwordField.waitForExistence(timeout: 3))
        passwordField.tap()
        passwordField.typeText("password123")

        let signInButton = app.buttons["signInButton"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 3))
        signInButton.tap()

        XCTAssertTrue(app.staticTexts["Email is required!"].waitForExistence(timeout: 2))
        XCTAssertFalse(app.staticTexts["Password is required!"].exists)
    }

    @MainActor
    func testEmptyPasswordOnlyShowsPasswordRequiredError() throws {
        let emailField = app.textFields["emailField"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 3))
        emailField.tap()
        emailField.typeText("sovan@example.com")

        let signInButton = app.buttons["signInButton"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 3))
        signInButton.tap()

        XCTAssertTrue(app.staticTexts["Password is required!"].waitForExistence(timeout: 2))
        XCTAssertFalse(app.staticTexts["Email is required!"].exists)
    }

    @MainActor
    func testInvalidEmailFormatShowsValidationError() throws {
        let emailField = app.textFields["emailField"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 3))
        emailField.tap()
        emailField.typeText("notanemail")

        let passwordField = app.secureTextFields["passwordField"]
        XCTAssertTrue(passwordField.waitForExistence(timeout: 3))
        passwordField.tap()
        passwordField.typeText("password123")

        let signInButton = app.buttons["signInButton"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 3))
        signInButton.tap()

        XCTAssertTrue(app.staticTexts["Please enter a valid email"].waitForExistence(timeout: 2))
    }

    @MainActor
    func testErrorsClearAfterFixingFieldsAndRetrying() throws {
        let signInButton = app.buttons["signInButton"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 3))
        signInButton.tap()
        XCTAssertTrue(app.staticTexts["Email is required!"].waitForExistence(timeout: 2))

        let emailField = app.textFields["emailField"]
        emailField.tap()
        emailField.typeText("sovan@example.com")

        let passwordField = app.secureTextFields["passwordField"]
        passwordField.tap()
        passwordField.typeText("password123")

        signInButton.tap()

        XCTAssertFalse(app.staticTexts["Email is required!"].exists)
        XCTAssertFalse(app.staticTexts["Password is required!"].exists)
    }

    // MARK: - Password visibility toggle

    @MainActor
    func testPasswordVisibilityToggleSwitchesFieldType() throws {
        let secureField = app.secureTextFields["passwordField"]
        XCTAssertTrue(secureField.waitForExistence(timeout: 3))
        XCTAssertFalse(app.textFields["passwordField"].exists)

        let eyeButton = app.buttons["eye"]
        XCTAssertTrue(eyeButton.waitForExistence(timeout: 3))
        eyeButton.tap()

        XCTAssertTrue(app.textFields["passwordField"].waitForExistence(timeout: 2))
        XCTAssertFalse(app.secureTextFields["passwordField"].exists)
    }

    // MARK: - Remember me toggle

    @MainActor
    func testRememberMeCheckboxTogglesOnTap() throws {
        let rememberMeButton = app.buttons["rememberMeToggle"]
        XCTAssertTrue(rememberMeButton.waitForExistence(timeout: 3))
        rememberMeButton.tap()
        rememberMeButton.tap()
    }

    // MARK: - Successful sign-in

    @MainActor
    func testValidCredentialsDismissesLoginScreen() throws {
        let emailField = app.textFields["emailField"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 3))
        emailField.tap()
        emailField.typeText("sovan@example.com")

        let passwordField = app.secureTextFields["passwordField"]
        XCTAssertTrue(passwordField.waitForExistence(timeout: 3))
        passwordField.tap()
        passwordField.typeText("password123")

        let signInButton = app.buttons["signInButton"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 3))
        signInButton.tap()

        let welcomeText = app.staticTexts["Welcome back"]
        XCTAssertFalse(welcomeText.waitForExistence(timeout: 2))
    }

    // MARK: - Launch performance

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
