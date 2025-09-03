import '../../../../core/base_state/remote_response.dart';
import '../../data/model/user_model.dart';

abstract class AuthRepository {
  Future<RemoteResponse<UserModel?>> signIn(String email, String password);
  Future<RemoteResponse<UserModel?>> signUp(
      String name, String email, String password, String role);
  Future<void> signOut();
  Stream<RemoteResponse<UserModel?>> authStateChanges();
}
