import 'package:github/github.dart';
import 'github_box.dart';
import '../src/helper.dart';

class GithubStorage {
  /// Github username
  final String username;

  /// https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens
  final String personalAccessToken;

  /// Public or private repository name
  /// https://docs.github.com/en/repositories
  final String repository;

  GithubStorage(
      {required this.username,
      required this.personalAccessToken,
      required this.repository});

  /// Create box/file object
  GithubBox box({required String name, required String folder}) {
    return GithubBox(
        name: name, username, personalAccessToken, repository, folder);
  }

  /// Remove box from github
  Future<void> deleteBox({required String name, required String folder}) async {
    final box =
        await GitHub(auth: Authentication.withToken(personalAccessToken))
            .repositories
            .getContents(RepositorySlug(username, repository), "$folder/$name");
    await GitHub(auth: Authentication.withToken(personalAccessToken))
        .repositories
        .deleteFile(RepositorySlug(username, repository), "$folder/$name",
            "Delete box: $name", box.file!.sha!, "main");
  }

  /// Create new empty box/file if not exist yet
  Future<void> createBox({required String name, required String folder}) async {
    await GitHub(auth: Authentication.withToken(personalAccessToken))
        .repositories
        .createFile(
          RepositorySlug(username, repository),
          CreateFile(
              branch: "main",
              path: "$folder/$name",
              content: prettyByte({}),
              message: "Create new box: /$folder/$name"),
        );
  }
}
