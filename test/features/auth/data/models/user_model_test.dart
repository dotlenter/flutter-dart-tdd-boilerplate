import 'package:flutter_test/flutter_test.dart';
import 'package:hanapp/features/auth/data/models/user_model.dart';

void main() {
  final tUserModel = UserModel(
    userImage: '/public/user_image/no_image.png',
    blocked: false,
    subs: 'free',
    email: 'my email',
    name: 'john mar',
    birthDate: '06-15-1999', 
    refreshToken: 'test', 
    accessToken: 'test',
  );

  test(
    'should be a subclass of User entity', 
    () async {
    expect(tUserModel, isA<UserModel>());
  });
}
