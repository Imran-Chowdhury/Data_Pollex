import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_pollex/src/core/base_state/remote_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseAuthDataSource(this._auth, this._firestore);

  Future<Response<UserModel?>> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await _userFromFirebase(credential.user);
      return SuccessResponse(user);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }

  Future<Response<UserModel?>> signUp(
    String name,
    String email,
    String password,
    String role,
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        final userModel = UserModel(
          id: user.uid,
          name: name,
          email: email,
          role: role,
        );
        await _firestore
            .collection("users")
            .doc(user.uid)
            .set(userModel.toMap());
        return SuccessResponse(userModel);
      }
      return FailureResponse("User creation failed");
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }

  Future<Response<void>> signOut() async {
    try {
      await _auth.signOut();
      return SuccessResponse(null);
    } catch (e) {
      return FailureResponse(e.toString());
    }
  }

  Stream<Response<UserModel?>> authStateChanges() {
    return _auth.authStateChanges().asyncMap((user) async {
      try {
        final userModel = await _userFromFirebase(user);
        return SuccessResponse(userModel);
      } catch (e) {
        return FailureResponse(e.toString());
      }
    });
  }

  Future<UserModel?> _userFromFirebase(User? user) async {
    if (user == null) return null;
    final snapshot = await _firestore.collection("users").doc(user.uid).get();
    if (!snapshot.exists) return null;
    return UserModel.fromMap(snapshot.data()!, user.uid);
  }
}
