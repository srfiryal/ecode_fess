import 'package:ecode_fess/data/models/menfess/menfess_model.dart';

abstract class BaseMenfessRepository {
  Future<dynamic> getMenfesses({int? skip});
  Future<List<MenfessModel>> getComments({required int postId, int? skip});
}