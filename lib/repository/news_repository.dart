
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';
import '../model/NewsChannelCategories.dart';
import '../model/NewsChannelHeadlinesModel.dart';
import '../model/NewsChannelModel.dart';
import '../res/app_urls.dart';

class NewsRepository {
  BaseApiServices apiServices = NetworkApiServices();

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlines({required String name}) async
  {
    try{
      dynamic response = await apiServices.fetchNewsChannelHeadlinesApi('${AppUrls.baseUrl}$name&apiKey=${AppUrls.apiKey}');
      return response = NewsChannelHeadlinesModel.fromJson(response);
    } catch(e) {
      rethrow;
    }
  }

  Future<NewsModel> fetchNewsApi({required String name}) async
  {
    try{
      dynamic response = await apiServices.fetchNewsChannelHeadlinesApi('${AppUrls.baseUrl2}$name&apiKey=${AppUrls.apiKey}');
      return response = NewsModel.fromJson(response);
    } catch(e) {
      rethrow;
    }
  }

  Future<CategoriesNewsModel> fetchNewsCategories({required String name}) async
  {
    try{
      dynamic response = await apiServices.fetchNewsChannelHeadlinesApi('${AppUrls.categories}$name&apiKey=${AppUrls.apiKey}');
      return response = CategoriesNewsModel.fromJson(response);
    } catch(e) {
      rethrow;
    }
  }
}