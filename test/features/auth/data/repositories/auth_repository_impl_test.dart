import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hanapp/core/error/exceptions.dart';
import 'package:hanapp/core/error/failures.dart';
import 'package:hanapp/core/network/network_info.dart';
import 'package:hanapp/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:hanapp/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:hanapp/features/auth/data/models/user_model.dart';
import 'package:hanapp/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:hanapp/features/auth/domain/entities/user.dart';
import 'package:mockito/mockito.dart';

class MockRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockLocalDataSource extends Mock implements AuthLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  AuthRepositoryImpl repositoryImpl;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
      localDataSource: mockLocalDataSource,
    );
  });

  test('should check if user session is active', () async {
    when(mockLocalDataSource.isUserLoggedIn()).thenAnswer((_) async => true);

    repositoryImpl.checkUserSession();

    verify(mockLocalDataSource.isUserLoggedIn());
  });
  group('loginUserWithEmailAndPassword', () {
    final tEmail = 'test123@app.com';
    final tPassword = 'mypassword123';

    final tUserModel = UserModel(
      userImage: '/public/user_image/no_image.png',
      blocked: false,
      subs: 'free',
      email: 'my email',
      name: 'john mar',
      birthDate: '06-15-1999',
      accessToken: 'test',
      refreshToken: 'test',
    );

    final User tUser = tUserModel;

    test('should check if the device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repositoryImpl.loginUserWithEmailAndPassword(tEmail, tPassword);

      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call to remote data source is successfull',
          () async {
        when(mockRemoteDataSource.loginUserWithEmailAndPassword(any, any))
            .thenAnswer((_) async => tUserModel);

        final result = await repositoryImpl.loginUserWithEmailAndPassword(
            tEmail, tPassword);

        verify(mockRemoteDataSource.loginUserWithEmailAndPassword(
            tEmail, tPassword));
        expect(result, Right(tUser));
      });

      test(
          'should return ServerFailure when the call to remote data source is unsuccessfull',
          () async {
        when(mockRemoteDataSource.loginUserWithEmailAndPassword(any, any))
            .thenThrow(ServerException());

        final result = await repositoryImpl.loginUserWithEmailAndPassword(
            tEmail, tPassword);
        expect(result, equals(Left(ServerFailure())));
        verify(mockRemoteDataSource.loginUserWithEmailAndPassword(
            tEmail, tPassword));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });
}
