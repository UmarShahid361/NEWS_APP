
abstract class BaseApiServices {
  Future<dynamic> fetchNewsChannelHeadlinesApi(String url);
  Future<dynamic> fetchNewsApi(String url);
  Future<dynamic> fetchNewsCategories(String url);
}