# GithubStorage

This package provides a convenient way to persist key-value pairs directly within your GitHub repository. Using implementation of (https://pub.dev/packages/github) Thanks to (https://github.com/SpinlockLabs)

## Features

- Secure Storage: Leverages GitHub's secrets management for secure storage of your data, use private repository.
- Easy to Use: Simple API for storing and retrieving data.
- Integrated with Dart: Works seamlessly within your Dart projects.

## Getting started

```yaml
dependencies:
  github_storage: ^any
```

## Usage

Register your github account
```dart
final git = GithubStorage(
      username: "this is yours",
      personalAccessToken: "yout token",
      repository: "your repo");
```
Create file and folder first if does not exist yet in your repo
```dart
await git.createBox(name: "user", folder: "data");
```
Create object of GithubBox
```dart
GithubBox userBox = git.box(name: "user", folder: "data");
```
Save, get, delete
```dart
await userBox.put("isDarkTheme", true);
await userBox.remove("user");
bool isDark = await userBox.get("isDark");
```
Or save an object
```dart
Map user = {
    "user": "jack",
    "no": 10,
    "color": [
      "red",
      "blue",
    ],
    "planet": {"earth": "moon"}
  };

  await userBox.put("jack", user);
```

## 

Note: This description emphasizes security and ease of use. Remember to replace "Secure Storage" with the specific mechanism your package uses (e.g., encrypted files) if it's different from GitHub secrets.
