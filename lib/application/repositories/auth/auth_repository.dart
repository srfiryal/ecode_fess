import 'dart:convert';

import 'package:ecode_fess/application/repositories/auth/base_auth_repository.dart';
import 'package:ecode_fess/data/models/user/user_model.dart';
import 'package:ecode_fess/presentation/core/shared_data.dart';

import '../../../common/constants.dart';
import '../../../common/network_util.dart';
import '../../../common/shared_preferences_service.dart';

class AuthRepository extends BaseAuthRepository {
  @override
  Future<void> login(String username, String password) async {
    var res = await NetworkUtil.post(Uri.parse('${Constants.baseUrl}/auth/login'), body: {
      'username': username,
      'password': password
    });

    if (res.statusCode == 200) {
      UserModel userModel = UserModel.fromJson(jsonDecode(res.body));
      await SharedPreferencesService.setToken(userModel.token);
      await SharedPreferencesService.setUserId(userModel.id);
      SharedData.userData.value = userModel;
    } else {
      throw jsonDecode(res.body)['message'];
    }
  }

  @override
  Future<void> logout() async {
    await SharedPreferencesService.clearAllPrefs();
  }
}