import 'package:github_storage/github_storage.dart';
import 'package:github_storage/src/github_box.dart';

void main() async {
  final git = GithubStorage(
      username: "this is yours",
      personalAccessToken: "yout token",
      repository: "your repo");

  /// Create if not exist yet on repo
  await git.createBox(name: "user", folder: "data");

  /// Create object of GithubBox
  GithubBox userBox = git.box(name: "user", folder: "data");
  GithubBox settingBox = git.box(name: "setting", folder: "setting");

  await userBox.put("flutter", {"version": 1, "isDart": true});
  await settingBox.put("isDarkTheme", true);

  bool isDark = await settingBox.get("isDark");
  print(isDark);

  await userBox.remove("jack");
  Map setting = await settingBox.getRawData();
  print(setting.toString());

  Map user = {
    "user": "jack",
    "no": 10,
    "color": [
      "red",
      "blue",
    ],
    "planet": {"earth": "moon"}
  };

  await settingBox.put("jack", user);
}
