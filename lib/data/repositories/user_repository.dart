import 'package:flutter_kag/app/utils/http.dart';
import 'package:flutter_kag/data/models/user_model.dart';

class UserRepository with HttpClient {
  Future<List<UserModel>?> getListUser() async {
    try {
      final response = await get('/users').catchError(handleError);
      return UserModel.fromList(response);
    } catch (e) {
      return null;
    }
  }
}
