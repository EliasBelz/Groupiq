import 'package:get_it/get_it.dart';
import 'package:groupiq_flutter/services/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

class GroupiqChatService {
  final pb = GetIt.instance<PocketBaseService>().pb;

  /// Returns a paginated records list of groupiqs
  Future<ResultList<RecordModel>> getChatPage(
      {page = 1, perPage = 20, filter = ''}) async {
    return await pb.collection('groupiqs').getList(
          page: page,
          perPage: perPage,
          filter: filter,
        );
  }
}
