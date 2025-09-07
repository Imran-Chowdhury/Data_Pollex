import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/base_state/auth_state.dart';
import '../../data/datasource/data_source.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../view_model/auth_view_model.dart';

final authDataSourceProvider = Provider((ref) {
  return FirebaseAuthDataSource(
      FirebaseAuth.instance, FirebaseFirestore.instance);
});

final authRepositoryProvider = Provider((ref) {
  return AuthRepositoryImpl(ref.read(authDataSourceProvider));
});

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  // ref.keepAlive();
  return AuthViewModel(
    repository: ref.read(authRepositoryProvider),
  );
});
