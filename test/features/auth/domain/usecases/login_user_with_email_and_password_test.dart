import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanapp/features/auth/domain/entities/user.dart';
import 'package:hanapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:hanapp/features/auth/domain/usecases/login_user_with_email_and_password.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  LoginUserWithEmailAndPassword usecase;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginUserWithEmailAndPassword(mockAuthRepository);
  });

  final tEmail = 'test';
  final tPassword = 'test';
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

  test(
    'should login user with email and password',
    () async {
      // arrange
      when(mockAuthRepository.loginUserWithEmailAndPassword(any, any))
          .thenAnswer((_) async => Right(tUser));
      // act
      final result = await usecase(Params(email: tEmail, password: tPassword));
      //assert
      expect(result, Right(tUser));
      verify(mockAuthRepository.loginUserWithEmailAndPassword(tEmail, tPassword));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
