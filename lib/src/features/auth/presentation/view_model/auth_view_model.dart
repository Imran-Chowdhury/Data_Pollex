import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/base_state/auth_state.dart';
import '../../../../core/base_state/remote_response.dart';
import '../../data/model/user_model.dart';
import '../../domain/repository/auth_repository.dart';

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository repository;

  AuthViewModel({required this.repository}) : super(const AuthState()) {
    _watchAuthState();
  }

  void _watchAuthState() {
    repository.authStateChanges().listen((response) {
      if (response is RemoteSuccess<UserModel?>) {
        state =
            state.copyWith(user: response.data, isLoading: false, error: null);
      } else if (response is RemoteFailure<UserModel?>) {
        state = state.copyWith(
            user: null, isLoading: false, error: response.message);
      }
    });
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await repository.signIn(email, password);
      if (response is RemoteSuccess<UserModel?>) {
        state =
            state.copyWith(user: response.data, isLoading: false, error: null);
      } else if (response is RemoteFailure<UserModel?>) {
        state = state.copyWith(isLoading: false, error: response.message);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signUp(String name, String email, String password,
      String confirmPassword, String role) async {
    state = state.copyWith(isLoading: true);

    if (password != confirmPassword) {
      state =
          state.copyWith(isLoading: false, error: 'Passwords do not match!');
      return;
    }

    try {
      final response = await repository.signUp(name, email, password, role);
      if (response is RemoteSuccess<UserModel?>) {
        state =
            state.copyWith(user: response.data, isLoading: false, error: null);
      } else if (response is RemoteFailure<UserModel?>) {
        state = state.copyWith(isLoading: false, error: response.message);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    try {
      await repository.signOut();
      state = state.copyWith(user: null, isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
