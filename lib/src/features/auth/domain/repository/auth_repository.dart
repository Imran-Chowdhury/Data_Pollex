import '../../../../core/base_state/remote_response.dart';
import '../../data/model/user_model.dart';

abstract class AuthRepository {
  Future<DataResponse<UserModel?>> signIn(String email, String password);
  Future<DataResponse<UserModel?>> signUp(
      String name, String email, String password, String role);
  Future<void> signOut();
  Stream<DataResponse<UserModel?>> authStateChanges();
  Future<UserModel?>? getCurrentUser();
}
