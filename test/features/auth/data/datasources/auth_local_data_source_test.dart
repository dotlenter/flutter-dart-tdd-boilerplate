import 'package:flutter_test/flutter_test.dart';
import 'package:hanapp/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {
  void main() {
    AuthLocalDataSourceImpl dataSourceImpl;
    MockSharedPreferences mockSharedPreferences;

    setUp((){
      mockSharedPreferences = MockSharedPreferences();
      dataSourceImpl = AuthLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
    });
  }
}
