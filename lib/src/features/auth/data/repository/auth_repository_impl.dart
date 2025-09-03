import '../../../../core/base_state/remote_response.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/data_source.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;
  AuthRepositoryImpl(this.dataSource);

  @override
  Future<RemoteResponse<UserModel?>> signIn(String email, String password) =>
      dataSource.signIn(email, password);

  @override
  Future<RemoteResponse<UserModel?>> signUp(
          String name, String email, String password, String role) =>
      dataSource.signUp(name, email, password, role);

  @override
  Future<void> signOut() => dataSource.signOut();

  @override
  Stream<RemoteResponse<UserModel?>> authStateChanges() =>
      dataSource.authStateChanges();
}
