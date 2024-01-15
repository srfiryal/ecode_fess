import 'package:ecode_fess/data/models/menfess/menfess_model.dart';

abstract class BaseMenfessRepository {
  Future<dynamic> getMenfesses({int? skip});
  Future<dynamic> getComments({required int postId, int? skip});
  Future<void> addMenfess({required String body});
  Future<void> deleteMenfess({required int id});
}