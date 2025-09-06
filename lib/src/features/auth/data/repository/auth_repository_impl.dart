import '../../../../core/base_state/remote_response.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/data_source.dart';
import '../model/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource dataSource;
  AuthRepositoryImpl(this.dataSource);

  @override
  Future<DataResponse<UserModel?>> signIn(String email, String password) =>
      dataSource.signIn(email, password);

  @override
  Future<DataResponse<UserModel?>> signUp(
          String name, String email, String password, String role) =>
      dataSource.signUp(name, email, password, role);

  @override
  Future<void> signOut() => dataSource.signOut();

  @override
  Stream<DataResponse<UserModel?>> authStateChanges() =>
      dataSource.authStateChanges();
}
