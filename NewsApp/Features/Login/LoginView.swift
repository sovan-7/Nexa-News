import SwiftUI

struct LoginFormError {
    var emailErrorMsg: String = ""
    var passwordErrorMsg: String = ""
}

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible: Bool = false
    @State private var rememberMe: Bool = false
    @State private var loginFormError = LoginFormError()
    @State private var path = NavigationPath()
    @EnvironmentObject var loginViewModel: LoginViewModel

    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack {
                    logoBadge.padding(.top, 40)

                    VStack {
                        Text("Welcome back")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.black)
                        Text("Sign in to pick up where you left off.")
                            .font(.system(size: 16))
                            .foregroundColor(themeManager.colors.textSecondary)
                            .multilineTextAlignment(.center)
                    }.padding(.bottom, 8)

                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            labelField(label: "Email", icon: "envelope", placeHolder: "name@company.com") {
                                ZStack(alignment: .leading) {
                                    if email.isEmpty {
                                        Text(verbatim:"name@company.com")
                                            .foregroundColor(themeManager.colors.textMuted)
                                    }
                                    TextField("", text: $email)
                                        .foregroundStyle(.black)
                                        .tint(themeManager.colors.primary)
                                        .keyboardType(.emailAddress)
                                        .textInputAutocapitalization(.never)
                                        .autocorrectionDisabled(true).textContentType(.init(rawValue: "")).accessibilityIdentifier("emailField")
                                }
                            }
                            if !loginFormError.emailErrorMsg.isEmpty {
                                Text(loginFormError.emailErrorMsg)
                                    .font(.system(size: 13))
                                    .foregroundColor(themeManager.colors.secondary)
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            labelPasswordField
                            if !loginFormError.passwordErrorMsg.isEmpty {
                                Text(loginFormError.passwordErrorMsg)
                                    .font(.system(size: 13))
                                    .foregroundColor(themeManager.colors.secondary)
                            }
                        }

                        HStack {
                            Button(action: { rememberMe.toggle() }) {
                                HStack(spacing: 6) {
                                    RoundedRectangle(cornerRadius: 5)
                                        .strokeBorder(rememberMe ? Color.clear : themeManager.colors.fieldBackground, lineWidth: 1.5)
                                        .background(
                                            RoundedRectangle(cornerRadius: 5)
                                                .fill(rememberMe ? themeManager.colors.primary : Color.clear)
                                        )
                                        .frame(width: 18, height: 18)
                                        .overlay {
                                            if rememberMe {
                                                Image(systemName: "checkmark")
                                                    .font(.system(size: 11, weight: .bold))
                                                    .foregroundColor(themeManager.colors.textWhite)
                                            }
                                        }
                                    Text("Remember me")
                                        .font(.system(size: 15))
                                        .foregroundColor(themeManager.colors.textSecondary)
                                }
                            }.accessibilityIdentifier("rememberMeToggle")

                            Spacer()
                            Button(action: {}) {
                                Text("Forgot?")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(themeManager.colors.primary)
                            }
                        }

                        Button(action: {
                            if isFormValid {
                                loginViewModel.login(user: User(id: UUID(), name: "Sovan", email: "sovan@example.com"))
                                //path.append("dashboard")
                            }
                        }) {
                            Text("Sign in")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(themeManager.colors.primary)
                                .cornerRadius(12)
                        }
                        .padding(.top, 4).accessibilityIdentifier("signInButton")

                        dividerRow.padding(.top, 4)

                        Button(action: {}) {
                            HStack(spacing: 8) {
                                Image(systemName: "faceid")
                                    .font(.system(size: 16))
                                Text("Sign in with Face ID")
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(themeManager.colors.fieldBackground, lineWidth: 1.5))
                        }

                        HStack(spacing: 4) {
                            Text("New here?")
                                .font(.system(size: 15))
                                .foregroundColor(themeManager.colors.textSecondary)
                            Button(action: {}) {
                                Text("Create an account")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(themeManager.colors.primary)
                            }
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 32)
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 32)
                }
                .padding(.horizontal, 24)
            }
            .background(themeManager.colors.background)
            .scrollBounceBehavior(.basedOnSize)
            .navigationDestination(for: String.self) { value in
//                if value == "dashboard" {
//                    DashboardView()
//                }
            }
        }
    }

    private var logoBadge: some View {
        RoundedRectangle(cornerRadius: 16).fill(themeManager.colors.primary).frame(width: 60, height: 60).overlay {
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 24))
                .foregroundColor(themeManager.colors.primary)
        }
    }

    private var dividerRow: some View {
        HStack(spacing: 10) {
            Rectangle().fill(themeManager.colors.fieldBackground).frame(height: 1)
            Text("or").font(.system(size: 12)).foregroundColor(themeManager.colors.textSecondary)
            Rectangle().fill(themeManager.colors.fieldBackground).frame(height: 1)
        }
    }

    @ViewBuilder
    private func labelField<Content: View>(label: String, icon: String, placeHolder: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label).font(.system(size: 15, weight: .medium)).foregroundColor(themeManager.colors.textSecondary)
            HStack(spacing: 8) {
                Image(systemName: icon).font(.system(size: 16)).foregroundColor(themeManager.colors.textMuted).frame(width: 18)
                content().font(.system(size: 15))
            }
            .padding(.horizontal, 12)
            .frame(height: 48)
            .background(themeManager.colors.fieldBackground)
            .cornerRadius(12)
        }
    }

    private var labelPasswordField: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Password").font(.system(size: 15, weight: .medium)).foregroundColor(themeManager.colors.textSecondary)
            HStack(spacing: 8) {
                Image(systemName: "lock").font(.system(size: 16)).foregroundColor(themeManager.colors.textMuted).frame(width: 18)
                Group {
                    if isPasswordVisible {
                        TextField("Enter your password", text: $password).accessibilityIdentifier("passwordField")
                    } else {
                        SecureField("Enter your password", text: $password).accessibilityIdentifier("passwordField")
                    }
                }
                .font(.system(size: 15))
                .foregroundColor(.black)
                Button(action: { isPasswordVisible.toggle() }) {
                    Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        .font(.system(size: 16))
                        .foregroundColor(themeManager.colors.textMuted).accessibilityIdentifier("eye")

                }
            }
            .padding(.horizontal, 12)
            .frame(height: 48)
            .background(themeManager.colors.fieldBackground)
            .cornerRadius(12)
        }
    }

    // Fixed: resets errors each time, and fixes the password bug
    var isFormValid: Bool {
        loginFormError = LoginFormError() // reset before revalidating

        if email.isEmpty {
            loginFormError.emailErrorMsg = "Email is required!"
        } else if !email.isValidEmail {
            loginFormError.emailErrorMsg = "Please enter a valid email"
        }

        if password.isEmpty {
            loginFormError.passwordErrorMsg = "Password is required!"
        }

        return loginFormError.emailErrorMsg.isEmpty && loginFormError.passwordErrorMsg.isEmpty
    }
}

#Preview {
    LoginView().environmentObject(LoginViewModel())
        .environmentObject(ThemeManager())
}
