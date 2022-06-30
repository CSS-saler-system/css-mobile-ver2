import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../resource/models/user.dart';

extension on firebase_auth.User {
  User get toUser {
    return User(
      id: uid,
      name: displayName,
      email: email,
      photo: photoURL,
    );
  }
}
