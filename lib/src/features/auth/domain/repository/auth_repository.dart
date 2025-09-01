import '../../data/datasource/response.dart';
import '../../data/model/user_model.dart';

abstract class AuthRepository {
  Future<UserRemoteResponse<UserModel?>> signIn(String email, String password);
  Future<UserRemoteResponse<UserModel?>> signUp(
      String name, String email, String password, String role);
  Future<void> signOut();
  Stream<UserRemoteResponse<UserModel?>> authStateChanges();
}
