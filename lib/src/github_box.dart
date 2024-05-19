import 'dart:convert';
import 'package:github/github.dart';
import 'helper.dart';

class GithubBox {
  final String name;
  final String _username;
  final String _personalAccessToken;
  final String _repository;
  final String _folder;

  GithubBox(
    this._username,
    this._personalAccessToken,
    this._repository,
    this._folder, {
    required this.name,
  });

  /// Example put("user", "flutter")
  /// or
  /// put("user": {"user: "flutter", "isDart": true})
  Future<void> put(String key, dynamic value) async {
    final box = await GitHub(
            auth: Authentication.withToken(_personalAccessToken))
        .repositories
        .getContents(RepositorySlug(_username, _repository), "$_folder/$name");
    Map<String, dynamic> content = json.decode(box.file!.text);
    content.addAll({key: value});
    await GitHub(auth: Authentication.withToken(_personalAccessToken))
        .repositories
        .updateFile(RepositorySlug(_username, _repository), "$_folder/$name",
            "Modified key: $key", prettyByte(content), box.file!.sha!,
            branch: "main");
  }

  /// Return single value of key
  Future<dynamic> get(String key) async {
    final box = await GitHub(
            auth: Authentication.withToken(_personalAccessToken))
        .repositories
        .getContents(RepositorySlug(_username, _repository), "$_folder/$name");
    Map<String, dynamic> content = json.decode(box.file!.text);
    return content[key];
  }

  /// Return Map of all box/file
  Future<Map<String, dynamic>> getRawData() async {
    final box = await GitHub(
            auth: Authentication.withToken(_personalAccessToken))
        .repositories
        .getContents(RepositorySlug(_username, _repository), "$_folder/$name");
    return json.decode(box.file!.text);
  }

  /// Delete key
  Future<void> remove(String key) async {
    final box = await GitHub(
            auth: Authentication.withToken(_personalAccessToken))
        .repositories
        .getContents(RepositorySlug(_username, _repository), "$_folder/$name");
    Map<String, dynamic> content = json.decode(box.file!.text);
    content.remove(key);
    await GitHub(auth: Authentication.withToken(_personalAccessToken))
        .repositories
        .updateFile(RepositorySlug(_username, _repository), "$_folder/$name",
            "Modified key: $key", prettyByte(content), box.file!.sha!,
            branch: "main");
  }
}
