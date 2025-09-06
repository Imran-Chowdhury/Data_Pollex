import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_pollex/src/core/base_state/remote_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  FirebaseAuthDataSource(this._auth, this._firestore);

  Future<UserModel?>? getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      return _userFromFirebase(user); // however you map it
    }
    return null;
  }

  Future<DataResponse<UserModel?>> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = await _userFromFirebase(credential.user);
      return Success(user);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<DataResponse<UserModel?>> signUp(
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
        return Success(userModel);
      }
      return Failure("User creation failed");
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Future<DataResponse<void>> signOut() async {
    try {
      await _auth.signOut();
      return Success(null);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  Stream<DataResponse<UserModel?>> authStateChanges() {
    return _auth.authStateChanges().asyncMap((user) async {
      try {
        final userModel = await _userFromFirebase(user);
        return Success(userModel);
      } catch (e) {
        return Failure(e.toString());
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
