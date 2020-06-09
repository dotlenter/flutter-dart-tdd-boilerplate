import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanapp/features/auth/domain/entities/token.dart';
import 'package:hanapp/features/auth/domain/repositories/auth_repository.dart';
import 'package:hanapp/features/auth/domain/usecases/refresh_auth_token.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  RefreshAuthToken usecase;
  MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = RefreshAuthToken(mockAuthRepository);
  });

  test(
    'should refresh token',
    () async {
      final tRefreshToken = 'test';
      final tToken = Token(accessToken: 'test', refreshToken: 'test');
      // arrange
      when(mockAuthRepository.refreshAuthToken(any))
          .thenAnswer((_) async => Right(tToken));
      // act
      final result = await usecase(Params(refreshToken: tRefreshToken));
      // assert
      expect(result, Right(tToken));
      verify(mockAuthRepository.refreshAuthToken(tRefreshToken));
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
