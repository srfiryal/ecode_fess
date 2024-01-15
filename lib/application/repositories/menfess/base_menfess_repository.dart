abstract class BaseMenfessRepository {
  Future<dynamic> getMenfesses({int? skip});
  Future<dynamic> getComments({required int postId, int? skip});
  Future<void> addMenfess({required String body});
  Future<void> addComment({required int postId, required String body});
  Future<void> updateMenfess({required int id, required String body});
  Future<void> deleteMenfess({required int id});
  Future<void> deleteComment({required int id});
}