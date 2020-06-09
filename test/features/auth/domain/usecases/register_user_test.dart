import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanapp/features/auth/domain/entities/user.dart';
import 'package:hanapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:hanapp/features/auth/domain/usecases/register_user.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository with Mock implements AuthRepository {}

void main() {
  RegisterUser usecase;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = RegisterUser(mockAuthRepository);
  });

  final tEmail = 'test';
  final tPassword = 'test';
  final tName = 'test';
  final birthDate = 'test';

  final tUser = User(
    userImage: '/public/user_image/no_image.png',
    blocked: false,
    subs: 'free',
    email: 'my email',
    name: 'john mar',
    birthDate: '06-15-1999',
    accessToken: 'test',
    refreshToken: 'test',
  );

  test('should register new user', () async {
    when(mockAuthRepository.registerUser(any, any, any, any))
        .thenAnswer((_) async => Right(tUser));

    final result = await usecase(Params(
      email: tEmail,
      password: tPassword,
      name: tName,
      birthDate: birthDate,
    ));

    expect(result, Right(tUser));

    verify(mockAuthRepository.registerUser(
      tEmail,
      tPassword,
      tName,
      birthDate,
    ));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
