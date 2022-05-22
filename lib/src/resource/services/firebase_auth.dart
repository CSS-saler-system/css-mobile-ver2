import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthService {
  Future<String?> verifyPhoneNumber(String phoneNumber);
  Future<bool> verifyOtp(String verificationId, String otp);
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
        await _firebaseAuth.signInWithCredential(credential).then((value) {
          log("You are logged in successfully");
        });
        completer.complete("");
      },
      verificationFailed: (FirebaseAuthException e) {
        log("verificationFailed ${e.message}");
        completer.complete("");
      },
      codeSent: (String verificationId, int? resendToken) {
        log("codeSent $verificationId");
        completer.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    return completer.future;
  }

  @override
  Future<bool> verifyOtp(String verificationId, String otp) async {
    bool result = false;

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      final UserCredential authResult =
          await _firebaseAuth.signInWithCredential(credential);
      final User? user = authResult.user;
      String token = await user!.getIdToken();
      log("user" + token);
      if (token.isNotEmpty) {
        result = true;
      }
    } catch (e) {
      result = false;
    }
    return result;
  }
}
