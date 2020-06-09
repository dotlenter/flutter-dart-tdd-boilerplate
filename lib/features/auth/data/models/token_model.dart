import 'package:flutter/foundation.dart';
import 'package:hanapp/features/auth/domain/entities/token.dart';

class TokenModel extends Token {
  TokenModel({
    @required accessToken,
    @required refreshToken,
  }) : super(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['tokens.access.token'],
      refreshToken: json['tokens.access.refresh'],
    );
  }
}
