import 'dart:convert';

import 'package:ecode_fess/application/repositories/menfess/base_menfess_repository.dart';
import 'package:ecode_fess/data/models/menfess/menfess_model.dart';

import '../../../common/constants.dart';
import '../../../common/network_util.dart';
import '../../../presentation/core/shared_data.dart';

class MenfessRepository extends BaseMenfessRepository {
  @override
  Future<dynamic> getMenfesses({int? skip}) async {
    skip ??= 0;
    var res = await NetworkUtil.get(Uri.parse('${Constants.baseUrl}/posts?limit=10&skip=$skip&select=userId,body,reactions'));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw jsonDecode(res.body)['message'];
    }
  }

  @override
  Future<dynamic> getComments({required int postId, int? skip}) async {
    skip ??= 0;
    var res = await NetworkUtil.get(Uri.parse('${Constants.baseUrl}/comments?limit=10&skip=$skip&select=user,body,reactions'));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw jsonDecode(res.body)['message'];
    }
  }

  @override
  Future<void> addMenfess({required String body}) async {
    var res = await NetworkUtil.post(Uri.parse('${Constants.baseUrl}/posts/add'), body: jsonEncode({
      'body': body,
      'userId': SharedData.userData.value!.id.toString()
    }));

    if (res.statusCode != 200) {
      throw jsonDecode(res.body)['message'];
    }
  }

  @override
  Future<void> addComment({required int postId, required String body}) async {
    var res = await NetworkUtil.post(Uri.parse('${Constants.baseUrl}/posts/add'), body: jsonEncode({
      'body': body,
      'postId': postId.toString(),
      'userId': SharedData.userData.value!.id.toString()
    }));

    if (res.statusCode != 200) {
      throw jsonDecode(res.body)['message'];
    }
  }

  @override
  Future<void> updateMenfess({required int id, required String body}) async {
    var res = await NetworkUtil.put(Uri.parse('${Constants.baseUrl}/posts/$id'), body: jsonEncode({
      'body': body,
    }));

    if (res.statusCode != 200) {
      throw jsonDecode(res.body)['message'];
    }
  }

  @override
  Future<void> deleteMenfess({required int id}) async {
    var res = await NetworkUtil.delete(Uri.parse('${Constants.baseUrl}/posts/$id'));

    if (res.statusCode != 200) {
      throw jsonDecode(res.body)['message'];
    }
  }
}