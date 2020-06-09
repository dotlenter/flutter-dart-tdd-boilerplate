import 'package:meta/meta.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    @required userImage,
    @required blocked,
    @required subs,
    @required email,
    @required name,
    @required birthDate,
    @required accessToken,
    @required refreshToken,
  }) : super(
          userImage: userImage,
          blocked: blocked,
          subs: subs,
          email: email,
          name: name,
          birthDate: birthDate,
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accessToken: json['tokens.access.token'],
      birthDate: json['user.birthdate'],
      blocked: json['user.blocked'],
      email: json['user.email'],
      name: json['user.name'],
      refreshToken: json['tokens.refresh.token'],
      subs: json['user.subs'],
      userImage: json['user.userimage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'birthDate': birthDate,
      'blocked': blocked,
      'email': email,
      'name': name,
      'subs': subs,
      'userImage': userImage,
    };
  }
}
