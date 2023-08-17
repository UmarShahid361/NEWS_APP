
import 'package:flutter/foundation.dart';
import 'package:NEWS/model/NewsChannelCategories.dart';
import 'package:NEWS/model/NewsChannelModel.dart';

import '../model/NewsChannelHeadlinesModel.dart';
import '../repository/news_repository.dart';

class NewsViewModel extends ChangeNotifier {
  final myRepo = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi({required String name}) async {
    try{
      final response = await myRepo.fetchNewsChannelHeadlines(name: name);
      return response;
    } catch(e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  Future<NewsModel> fetchNewsApi({required String name}) async {
    try{
      final response = await myRepo.fetchNewsApi(name: name);
      return response;
    } catch(e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  Future<CategoriesNewsModel> fetchNewsCategories({required String name}) async {
    try{
      final response = await myRepo.fetchNewsCategories(name: name);
      return response;
    } catch(e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
}