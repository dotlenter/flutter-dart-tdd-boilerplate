import 'package:flutter_test/flutter_test.dart';
import 'package:hanapp/features/auth/data/models/token_model.dart';
import 'package:hanapp/features/auth/data/models/user_model.dart';

void main() {
  final tTokenModel = TokenModel(
    accessToken: 'test',
    refreshToken: 'test',
  );

  test('should be a subclass of Token entity', () async {
    expect(tTokenModel, isA<TokenModel>());
  });
}
