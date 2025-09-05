import '../../../../core/base_state/remote_response.dart';
import '../../data/model/user_model.dart';

abstract class AuthRepository {
  Future<Response<UserModel?>> signIn(String email, String password);
  Future<Response<UserModel?>> signUp(
      String name, String email, String password, String role);
  Future<void> signOut();
  Stream<Response<UserModel?>> authStateChanges();
}
