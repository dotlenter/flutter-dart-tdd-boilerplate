import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String userImage;
  final bool blocked;
  final String subs;
  final String email;
  final String name;
  final String birthDate;
  final String accessToken;
  final String refreshToken;

  User({
    @required this.userImage,
    @required this.blocked,
    @required this.subs,
    @required this.email,
    @required this.name,
    @required this.birthDate,
    @required this.accessToken, 
    @required this.refreshToken,
  });

  @override
  List<Object> get props => [userImage, blocked, subs, email, name, birthDate, accessToken, refreshToken];

}
