import '../../../utils/constants/nums.dart';
import '../../../utils/constants/strings.dart';

class NewsRequest {
  final String apiKey;
  final String sources;
  final int page;
  final int pageSize;

  NewsRequest({
    this.apiKey = kDefaultApiKey,
    this.sources = 'fox-news, bbc-news, abc-news',
    this.page = 1,
    this.pageSize = kDefaultPageSize,
  });
}
