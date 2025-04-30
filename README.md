# 📰 News App

A Flutter application to browse top news headlines, read full articles, and bookmark them with **offline support and sync** via Firebase.

---

## 🚀 Features

- **Browse Top Headlines**  
  Fetch and display the latest news from a public News API.

- **Article Details View**  
  Tap on a headline to view full article details, including:
  - Content, author, source, and publication date.
  - Bookmark or unbookmark the article (requires login).

- **User Authentication**  
  Sign Up, Sign In, and Sign Out using Firebase Authentication.

- **Bookmarks**  
  Save your favorite articles for later access.  
  - Bookmarking is available only for authenticated users.
  - Bookmarks are synced between local storage (Hive) and the cloud (Firestore).

- **Offline Support**  
  Access saved (bookmarked) articles even without an internet connection.

- **Read Without Login**  
  Users can browse and read articles freely without authentication; logging in is only required to use bookmark features.

---

## 🔧 Technologies & Libraries

| Purpose                     | Library                             |
|----------------------------|-------------------------------------|
| Framework                  | Flutter                             |
| State Management & DI      | GetX                                |
| Authentication             | Firebase Auth                       |
| Cloud Database             | Firebase Firestore                  |
| Local Storage              | Hive , hive_flutter                 |
| File Access                | path_provider                       |
| HTTP Networking            | http                                |
| Connectivity Checks        | connectivity_plus                   |
| Equality & Helpers         | equitable , dartz                   |
| Code Generation            | hive_generator, build_runner        |

---

## 🏗️ Architecture (Clean)

- **Domain Layer**: Entities, UseCases, Repository Interfaces  
- **Data Layer**: API, Firestore, Hive, and Models  
- **Presentation Layer**: UI, Pages, Widgets, GetX Controllers  

---

## 📲 APK Download

👉 [Download APK](https://drive.google.com/file/d/13-hBQy85H88b-GncLVvL5s7EF-292xO7/view?usp=sharing)  

---

## ⚙️ Setup Instructions

### Prerequisites
- Flutter SDK installed  
- Firebase project configured  
- FlutterFire CLI installed  
- News API key from [newsapi.org](https://newsapi.org)

---

### 🚀 Installation

```bash
git clone <repository_url>
cd news_app
flutter pub get
flutterfire configure
flutter packages pub run build_runner build --delete-conflicting-outputs
```

1. Replace `'YOUR_NEWS_API_KEY'` in:  
   `lib/data/datasources/remote/news_api_datasource_impl.dart`

2. Enable Email/Password auth in Firebase

3. Firestore Structure:
```
users/{userId}/bookmarks/{articleId}
```

---

### ▶️ Run the App

```bash
flutter run
```

---

## 🎥 Demonstration

| SignIn Screen | Home Sceen |  Article Details | Bookmark Screen |
|---------------|-------------|--------------------|--------------------|
| <img src="https://github.com/user-attachments/assets/58b350b5-415f-4384-8ede-cbeecc55b98b" alt="SignIn Screen" width="250"> | <img src="https://github.com/user-attachments/assets/29ddd9ce-508a-4acd-b30b-172f521bf2a9" alt="Home Screen" width="250"> | <img src="https://github.com/user-attachments/assets/a6f090f2-d34d-46bb-a3c2-3e21bf156ad8" alt="Artcile Details Screen" width="250"> | <img src="https://github.com/user-attachments/assets/84ba8e8d-e34c-4af8-8843-e6bc7e9698fe" alt="Bookmark Screen" width="250"> |

---
