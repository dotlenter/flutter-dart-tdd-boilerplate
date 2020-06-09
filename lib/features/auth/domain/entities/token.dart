import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Token extends Equatable{
  final String accessToken;
  final String refreshToken;
  Token({
    @required this.accessToken, 
    @required this.refreshToken,
  });

  @override
  List<Object> get props => [accessToken, refreshToken];
}
