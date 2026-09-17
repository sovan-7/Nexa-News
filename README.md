# Nexa News (News App)

<img width="1200" height="320" alt="banner" src="https://github.com/user-attachments/assets/29054532-4830-4606-9aec-e8f6bacee8d1" />
<br/>
<br/>

An iOS news reader built with SwiftUI. It shows headlines, sorted by category, and lets you bookmark articles to read later.

## ✨ Features

- 🔐 **Login**: checks the email and password fields and keeps you signed in
- 🗂️ **Categories**: Sports, Politics, Business, Health and Science
- 📰 **Details**: large header image, author, source and date
- 🔥 **Trending**: full-screen feed you swipe through vertically
- 🔖 **Bookmarks**: saved with Core Data, so they're kept after you close the app
- 🌗 **Themes**: light, dark or follow the system setting
- 👤 **Profile**: legal pages, share sheet, logout

## 🛠️ Tech stack

- SwiftUI
- MVVM
- async/await
- Core Data
- UserDefaults
- Swift Testing and XCTest


Getting started
You need Xcode 26 or later (the app targets iOS 26.1) and a free NewsAPI key.
Clone the repo and open NewsApp.xcodeproj.
Put your key in NewsApp/Utils/Constant.swift.
Press ⌘R to run. Any valid email and any password will sign you in.
Tests

