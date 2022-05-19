import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseAuthService {
  Future<String?> verifyPhoneNumber(String phoneNumber);
  Future<bool> verifyOtp(String verificationId, String otp);
}

class FirebaseAuthServiceImpl extends FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthServiceImpl(this._firebaseAuth);

  @override
  Future<String?> verifyPhoneNumber(String phoneNumber) async {
    String result = "";
    bool running = true;
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential).then((value) {
          log("You are logged in successfully");
        });
        running = false;
      },
      verificationFailed: (FirebaseAuthException e) {
        log("verificationFailed ${e.message}");
        running = false;
      },
      codeSent: (String verificationId, int? resendToken) {
        log("codeSent $verificationId");
        result = verificationId;
        running = false;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    if(running == false) {
      return result;
    }
  }

  @override
  Future<bool> verifyOtp(String verificationId, String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    log(credential.token.toString());

    await _firebaseAuth
        .signInWithCredential(credential)
        .then((UserCredential user) {
      log(user.credential!.token.toString());
      return true;
    }).catchError((e) {
      return false;
    });

    return false;
  }
}
