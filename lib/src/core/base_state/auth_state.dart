import 'package:data_pollex/src/features/auth/data/model/user_model.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({UserModel? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [user, isLoading, error];
}
