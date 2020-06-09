import 'package:hanapp/features/auth/data/models/user_model.dart';
import 'package:hanapp/features/auth/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  /// Throws [NoUserLoggedInException] if there's no cached user.
  Future<bool> isUserLoggedIn();

  Future<void> cacheUserSession(UserModel userToCache);

  Future<User> getUserLoggedIn();

  Future<bool> logoutUser();

  Future<void> clearUserCache();
}

const CACHED_USER = 'CACHED_USER';
const CACHED_USER_SETTINGS = 'CACHED_USER_SETTINGS';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheUserSession(UserModel userToCache) {
    return sharedPreferences.setString(
        CACHED_USER, jsonEncode(userToCache.toJson()));
  }

  @override
  Future<bool> isUserLoggedIn()  {
    final user = sharedPreferences.getString(CACHED_USER);
    if (user != null) return Future.value(true);
    else return Future.value(false);
  }

  @override
  Future<User> getUserLoggedIn() {
    return null;
  }

  @override
  Future<void> clearUserCache() {
    final cache = sharedPreferences.remove(CACHED_USER);
    return cache;
  }

  @override
  Future<bool> logoutUser() {
    return clearUserCache();
  }
}
