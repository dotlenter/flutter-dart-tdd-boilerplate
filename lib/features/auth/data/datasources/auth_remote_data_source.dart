import 'package:hanapp/core/error/exceptions.dart';
import 'package:hanapp/core/util/remote_data_source_in_url.dart';
import 'package:hanapp/features/auth/data/models/token_model.dart';
import 'package:hanapp/features/auth/data/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AuthRemoteDataSource {
  Future<UserModel> registerUser(
    String email,
    String password,
    String name,
    String birthDate,
  );
  Future<UserModel> loginUserWithEmailAndPassword(
    String email,
    String password,
  );
  Future<UserModel> resetPassword(
    String token,
    String newPassword,
  );
  Future<TokenModel> refreshAuthToken(String refreshToken);
  Future<UserModel> forgotPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  String rootUrl = RemoteDataSourceURL().toString();

  AuthRemoteDataSourceImpl({@required this.client});

  @override
  Future<UserModel> forgotPassword(String email) {
    return null;
  }

  @override
  Future<UserModel> loginUserWithEmailAndPassword(
      String email, String password) async {
    final response = await client.post('$rootUrl/auth/login',
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            <String, dynamic>{'email': email, 'password': password}));

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> registerUser(
      String email, String password, String name, String birthDate) async {
    final response = await client.post(
      '$rootUrl/auth/register',
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
        'name': name,
        'birthDate': birthDate,
      }),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw InvalidEmailOrPasswordException();
    } else if(response.statusCode == 400){
      throw EmailAlreadyTakenException();
    }
    else {
      throw ServerException();
    }
  }

  @override
  Future<TokenModel> refreshAuthToken(String refreshToken) {
    // TODO: implement refreshAuthToken
    return null;
  }

  @override
  Future<UserModel> resetPassword(String token, String newPassword) {
    // TODO: implement resetPassword
    return null;
  }
}
