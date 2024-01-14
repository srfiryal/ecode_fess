import 'dart:convert';

import 'package:ecode_fess/application/repositories/menfess/base_menfess_repository.dart';
import 'package:ecode_fess/data/models/menfess/menfess_model.dart';

import '../../../common/constants.dart';
import '../../../common/network_util.dart';

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
  Future<List<MenfessModel>> getComments({required int postId, int? skip}) async {
    skip ??= 0;
    var res = await NetworkUtil.get(Uri.parse('${Constants.baseUrl}/comments?limit=10&skip=$skip&select=user,body,reactions'));

    if (res.statusCode == 200) {
      List<MenfessModel> comments = [];
      List<dynamic> data = jsonDecode(res.body)['comments'];

      for (var element in data) {
        element['userId'] = element['user']['id'];
        comments.add(MenfessModel.fromJson(element));
      }
      return comments;
    } else {
      throw jsonDecode(res.body)['message'];
    }
  }
}