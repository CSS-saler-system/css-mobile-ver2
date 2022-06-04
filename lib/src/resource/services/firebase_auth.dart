import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthService {
  Future<String?> verifyPhoneNumber(String phoneNumber);
  Future<String> verifyOtp(String verificationId, String otp);
}

class FirebaseAuthServiceImpl extends FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthServiceImpl(this._firebaseAuth);

  @override
  Future<String?> verifyPhoneNumber(String phoneNumber) async {
    final completer = Completer<String>();
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential).then((value) {});
        completer.complete("");
      },
      verificationFailed: (FirebaseAuthException e) {
        completer.complete("");
      },
      codeSent: (String verificationId, int? resendToken) {
        completer.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    return completer.future;
  }

  @override
  Future<String> verifyOtp(String verificationId, String otp) async {
    try {
      String token = "";

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      final UserCredential authResult =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;
      token = await user!.getIdToken();
      log("firebaseToken: " + token);
      if (token.isNotEmpty) {
        return token;
      }
    } catch (e) {}
    return "";
  }
}
