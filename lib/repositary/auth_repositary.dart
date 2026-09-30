
import '../core/network/api_endpoints.dart';
import '../core/network/api_service.dart';
import '../models/user.dart';

class AuthRepositary {
  final ApiService apiService;

  AuthRepositary(this.apiService);

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
    );
      return UserModel.fromJson(response.data);
  }
// Future<List<UserModel>> getUsers() async {
//     final response = await apiService.get(
//       ApiEndpoints.users,
//     );
//
//     final List<dynamic> data = response.data;
//
//     return data
//         .map(
//           (json) => UserModel.fromJson(json),
//     )
//         .toList();
//   }
}