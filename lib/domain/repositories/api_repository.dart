import '../../utils/resources/data_state.dart';
import '../models/requests/news.request.dart';
import '../models/responses/news_response.dart';

abstract class ApiRepository {
  Future<DataState<NewsResponse>> getNewsArticles({
    required NewsRequest request,
  });
}
